3×3 Convolution Accelerator (Verilog)

3×3 / 2×2 컨볼루션 연산을 하드웨어로 가속하기 위한 Verilog RTL 설계 프로젝트입니다. 입력 행렬을 메모리에 저장하고, 컨트롤러(state machine)가 데이터 흐름을 제어하여 연산 모듈(PE 기반)에서 컨볼루션을 수행한 뒤 결과를 7-세그먼트 디스플레이로 출력합니다.

개요
목표: 3×3 커널 컨볼루션의 곱셈·누산(MAC)을 PE(Processing Element) 단위로 처리해 가속
언어 / 환경: Verilog HDL (시뮬레이션 기반, 각 모듈별 testbench 포함)
필터 크기: 3×3, 2×2 두 가지 지원 (컨트롤러에서 선택)
데이터: 4×4 행렬 3개를 3개의 RAM 뱅크에 저장 후 처리
동작 흐름
Memory (4×4 ×3 RAM)  ->  Computation (PE / systolic)  ->  Display (7-seg)
        ^                          ^                            ^
        └─────────── Controller (FSM: 주소/RW/필터 제어) ───────┘
                                   ^
                              LUT + MUX (주소·데이터 경로 선택)
top 모듈이 LUT, MUX, Controller, Computation, Memory, 7-seg 디스플레이를 인스턴스화하여 전체 파이프라인을 구성합니다.

Top ports: clk (입력), out_digit[7:0] / out_data[6:0] (디스플레이 출력)
디렉터리 구조
.
├── Top/                      # 최상위 통합 모듈
│   ├── top.v                 # 전체 시스템 통합 (clk -> 7-seg 출력)
│   ├── LUT.v                 # 주소 생성용 룩업 테이블
│   └── tb_top.v              # 최상위 테스트벤치
│
├── Control/
│   └── Controller.v          # FSM: 주소/Read-Write/필터 선택 제어
│
├── Computation/PE/           # 연산 코어 (Processing Element)
│   ├── SinglePE.v            # 단일 PE (곱셈+누산)
│   ├── Multiplier.v          # 곱셈기
│   ├── EightAdder.v / FullAdder.v / HalfAdder.v   # 가산기
│   ├── 8_bit_register.v / d_flip_flop_behavioral.v
│   ├── sys_2_2.v / sys_3_3.v # 2×2 / 3×3 systolic 배열
│   ├── CM_Serial.v / comp_modeling.v
│   ├── *mux* / *demux*       # 데이터 경로용 MUX/DEMUX (gate/behavioral)
│   ├── and/or/not_gate.v     # 기본 게이트
│   └── tb_*.v                # PE / 직렬·병렬 / DEMUX 테스트벤치
│
├── Memory/                   # 행렬 저장 메모리
│   ├── memory.v              # 메모리 통합 모듈
│   ├── ram.v / out_ram.v / three_out_ram.v
│   ├── mem/                  # RAM, register, flip-flop 등 하위 모듈 + tb
│   └── tb_memory.v
│
├── Display/                  # 결과 출력
│   ├── LED.v
│   ├── binary_to_BCD.v       # 이진수 -> BCD 변환
│   └── tb_display.v
│
└── 7_Segments/               # 7-세그먼트 디스플레이 관련
주요 모듈
모듈	역할
top	전체 시스템 통합. clk 입력 → 컨볼루션 → 7-seg 출력
Controller	FSM으로 메모리 주소, Read/Write, 필터 크기(3×3/2×2) 제어
computation_module (PE)	곱셈·누산 기반 컨볼루션 연산
memory_module	4×4 행렬 3개를 3개 RAM 뱅크에 저장/인출
LUT	주소 생성용 룩업 테이블
binary_to_BCD + 7-seg	연산 결과를 디스플레이용 신호로 변환
시뮬레이션
각 단계별 testbench가 포함되어 있습니다. 사용하는 시뮬레이터(ModelSim/Vivado/Icarus 등)에 맞춰 필요한 소스와 testbench를 함께 컴파일해 실행하세요.

# 예) Icarus Verilog로 최상위 시뮬레이션
iverilog -o top_sim Top/top.v Top/LUT.v Control/Controller.v \
    Computation/PE/*.v Memory/*.v Memory/mem/*.v Display/*.v Top/tb_top.v
vvp top_sim
단위 검증: Computation/PE/SinglePE_tb.v, tb_parallel1/2.v, Memory/tb_memory.v, Display/tb_display.v
통합 검증: Top/tb_top.v
참고
각 하위 폴더에 별도 readme.md가 있어 모듈별 상세 설명을 확인할 수 있습니다.
게이트 레벨/동작 레벨(behavioral) 구현이 함께 들어 있어 설계 비교·학습용으로도 활용 가능합니다.
