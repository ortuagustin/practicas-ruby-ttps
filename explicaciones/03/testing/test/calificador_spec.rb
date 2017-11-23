require 'minitest/autorun'
require 'date'
require 'calificador'
require 'trabajo_factory'

describe Calificador do
  before do
    @trabajo = TrabajoFactory.build
  end

  describe '#initialize' do
    describe 'when every possible argument is provided' do
      before do
        @fecha_limite = Date.new(2016, 10, 30)
        @calificador = Calificador.new(@trabajo, @fecha_limite)
      end

      it 'stores its arguments' do
        @calificador.trabajo.must_equal @trabajo
        @calificador.fecha_limite.must_equal @fecha_limite
      end
    end

    describe 'when the limit date is omitted' do
      before do
        @fecha_limite = Date.new(2016, 10, 30)
        @calificador = Calificador.new(@trabajo, @fecha_limite)
      end

      it 'infers the limit date' do
        @calificador.fecha_limite.wont_be_nil
      end
    end
  end

  describe '#calificar' do

    before do
      @fecha_limite = Date.new(2016, 10, 30)
      @calificador = Calificador.new(@trabajo, @fecha_limite)
    end

    it 'grades according to the properties of the delivery' do
      @trabajo = TrabajoFactory.build(fecha_entrega: @fecha_limite, originalidad: 5, simplicidad: 5, prolijidad: 5, desarrollo: 5, asistencia: 5)
      @calificador = Calificador.new(@trabajo, @fecha_limite)
      @calificador.calificar
      @calificador.trabajo.nota.must_equal 82.5
    end

    it 'grades in the 0..100 range' do
      @calificador.calificar
      (0..100).must_include @calificador.trabajo.nota
    end

    describe 'when grades all have the maximum value and delivery is on time' do
      before do
        @trabajo = TrabajoFactory.build(fecha_entrega: @fecha_limite, originalidad: 10, simplicidad: 10, prolijidad: 10, desarrollo: 10, asistencia: 10)
        @calificador = Calificador.new(@trabajo, @fecha_limite)
      end

      it 'assigns a final grade of 100' do
        @calificador.calificar
        @calificador.trabajo.nota.must_equal 100
      end
    end

    describe 'when grades all have the minimum value and delivery is not on time' do
      before do
        @trabajo = TrabajoFactory.build(fecha_entrega: @fecha_limite + 1, originalidad: 0, simplicidad: 0, prolijidad: 0, desarrollo: 0, asistencia: 0)
        @calificador = Calificador.new(@trabajo, @fecha_limite)
      end

      it 'assigns a final grade of 0' do
        @calificador.calificar
        @calificador.trabajo.nota.must_equal 0
      end
    end

    it 'stores the final grade in the delivery' do
      @calificador.trabajo.nota.must_be_nil
      @calificador.calificar
      @calificador.trabajo.nota.wont_be_nil
      @calificador.trabajo.nota.must_be_kind_of(Numeric)
    end

  end

  describe '#aprobado?' do
    describe 'when the delivery has not been graded yet' do
      before do
        @trabajo.nota = nil # This marks the delivery as not graded
        @calificador = Calificador.new(@trabajo)
      end

      it 'qualifies the delivery and then checks its mark' do
        called = false
        @calificador.stub(:calificar, ->{ called = true; @trabajo.nota = 4 }) do
          @calificador.aprobado?
        end
        called.must_equal true
      end
    end

    describe 'when the delivery has already been graded' do
      before do
        @trabajo.nota = 4 # This marks the delivery as already graded
        @calificador = Calificador.new(@trabajo)
      end

      it 'only checks its mark' do
        called = false
        @calificador.stub(:calificar, ->{ called = true }) do
          @calificador.aprobado?
        end
        called.must_equal false
      end
    end

    describe 'when the mark is below #porcentaje_aprobacion' do
      before do
        @calificador = Calificador.new(@trabajo)
        @trabajo.nota = @calificador.porcentaje_aprobacion / 2
      end

      it 'returns false' do
        @calificador.aprobado?.must_equal false
      end
    end

    describe 'when the mark is below #porcentaje_aprobacion' do
      before do
        @calificador = Calificador.new(@trabajo)
        @trabajo.nota = @calificador.porcentaje_aprobacion * 2
      end

      it 'returns false' do
        @calificador.aprobado?.must_equal true
      end
    end
  end

  describe '#porcentajes' do
    before do
      @calificador = Calificador.new(nil)
    end

    it 'must add up to 100%' do
      @calificador.porcentajes.values.inject(0, &:+).must_equal 100
    end

    it 'must include every possible mark part (originalidad, simplicidad, etc.)'do
      @calificador.porcentajes.keys.must_equal [:originalidad, :simplicidad, :prolijidad, :entrega_a_termino, :desarrollo, :bonus_asistencia]
    end
  end

  describe '#porcentaje_aprobacion' do
    before do
      @calificador = Calificador.new(nil)
    end

    it 'is in the 1..100 range' do
      (1..100).must_include @calificador.porcentaje_aprobacion
    end
  end

  describe 'Grading' do
    before do
      @trabajo.originalidad = 7
      @trabajo.simplicidad = 3
      @trabajo.prolijidad = 5
      @calificador = Calificador.new(@trabajo)
    end

    describe '#originalidad' do
      it 'takes the value from the delivery, ranges it in 1..10 and multiplies that by the according percentage' do
        @calificador.send(:originalidad).must_equal 7
      end
    end

    describe '#simplicidad' do
      it 'takes the value from the delivery, ranges it in 1..10 and multiplies that by the according percentage' do
        @calificador.send(:simplicidad).must_equal 7.5
      end
    end

    describe '#prolijidad' do
      describe 'when the delivery is tidy' do
        it 'adds tidiness percentage' do
          @calificador.send(:prolijidad).must_equal 15
        end
      end

      describe 'when the delivery is not tidy' do
        before do
          @trabajo = TrabajoFactory.build(prolijidad: 2)
          @calificador = Calificador.new(@trabajo)
        end
        it 'does not add anything for tidiness' do
          @calificador.send(:prolijidad).must_equal 0
        end
      end
    end

    describe '#entrega_a_termino' do
      before do
        @trabajo = TrabajoFactory.build
      end

      describe 'when the delivery is on time' do
        it 'adds timeliness percentage' do
          @calificador = Calificador.new(@trabajo, Date.today + 1)
          @calificador.send(:entrega_a_termino).must_equal @calificador.porcentajes[:entrega_a_termino]
        end
      end

      describe 'when the delivery is not on time' do
        it 'does not add anything for timeliness' do
          @calificador = Calificador.new(@trabajo, Date.today - 1)
          @calificador.send(:entrega_a_termino).must_equal 0
        end
      end
    end

    describe '#desarrollo' do
      describe 'when the development is acceptable or better' do
        before do
          @trabajo = TrabajoFactory.build(desarrollo: 10)
          @calificador = Calificador.new(@trabajo)
        end

        it 'adds good development percentage' do
          @calificador.send(:desarrollo).must_equal @calificador.porcentajes[:desarrollo]
        end
      end

      describe 'when the development is below acceptable standards' do
        before do
          @trabajo = TrabajoFactory.build(desarrollo: 1)
          @calificador = Calificador.new(@trabajo)
        end
        it 'does not add anything for good development' do
          @calificador.send(:desarrollo).must_equal 0
        end
      end

    end

    describe '#bonus_asistencia' do
      describe 'when the student has attended to at least half of the 10 classes' do
        before do
          @trabajo = TrabajoFactory.build(asistencia: 5)
          @calificador = Calificador.new(@trabajo)
        end

        it 'adds attendance bonus percentage' do
          @calificador.send(:bonus_asistencia).must_equal @calificador.porcentajes[:bonus_asistencia]
        end
      end

      describe 'when the student has attended to less than half of the 10 classes' do
        before do
          @trabajo = TrabajoFactory.build(asistencia: 4)
          @calificador = Calificador.new(@trabajo)
        end

        it 'does not add anything for attendance bonus' do
          @calificador.send(:bonus_asistencia).must_equal 0
        end
      end
    end
  end
end
