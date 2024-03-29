List<String> cateButtonList = [
  '전체',
  '유산소',
  '가슴',
  '어깨',
  '등',
  '이두',
  '삼두',
  '복부',
  '다리',
  '엉덩이',
  '기타'
];

Map<String, List> workoutMap = {
  '유산소': [
    '걷기',
    '런닝',
    '런닝 머신',
    '로잉 머신',
    '마운틴 클라이머',
    '사이클',
    '스태퍼',
    '점핑잭',
    '줄넘기',
    '버피 테스트',
  ],
  '가슴': [
    '푸시 업',
    '딥스',
    '플라이',
    '머신 플라이',
    '덤벨 플라이',
    '펙 덱 플라이',
    '풀오버',
    '바벨 풀오버',
    '덤벨 풀오버',
    '벤치 프레스',
    '스미스 머신 벤치 프레스',
    '인클라인 벤치 프레스',
    '디클라인 벤치 프레스',
    '스퀴즈 프레스',
    '플레이트 프레스',
    '체스트 프레스',
    '체스트 프레스 머신',
    '덤벨 체스트 프레스',
    '케이블 크로스 오버',
  ],
  '어깨': [
    'Y-레이즈',
    '숄더 프레스',
    '숄더 프레스 머신',
    '덤벨 숄더 프레스',
    '바벨 숄더 프레스',
    '밀리터리 프레스',
    '비하인드 넥 프레스',
    '프론트 레이즈',
    '레터럴 레이즈',
    '벤트 오버 레터럴 레이즈',
    '슈러그',
    '업라이트 로우',
    '리버스 플라이',
    '케이블 리버스 플라이',
    '펙 덱 리버스 플라이',
    '페이스 풀',
  ],
  '등': [
    '로우',
    '바벨 로우',
    '덤벨 로우',
    '시티드 로우',
    '시티드 머신 로우',
    '시티드 케이블 로우',
    'T-바 로우',
    '데드리프트',
    '컨벤셔널 데드리프트',
    '루마니안 데드리프트',
    '스모 데드리프트',
    '스티프 데드리프트',
    '풀 업',
    '랫 풀 다운',
    '프론트 머신 랫 풀 다운',
    '케이블 풀 다운',
  ],
  '이두': [
    'EZ-바 컬',
    '바벨 컬',
    '덤벨 컬',
    '해머 컬',
    '케이블 컬',
  ],
  '삼두': [
    '덤벨 트라이셉스 익스텐션',
    '라잉 바벨 트라이셉스 익스텐션',
    '라잉 덤벨 트라이셉스 익스텐션',
    '킥백',
    '케이블 푸쉬 다운',
    '프렌치 프레스',
  ],
  '복부': [
    'L-시트',
    '러시안 트위스트',
    '레그 레이즈',
    '행잉 레그 레이즈',
    '체어 레그 레이즈',
    'AB 휠 롤아웃',
    'V-업',
    '사이드 밴드',
    '싯 업',
    '에어 바이크',
    '크런치',
    '케이블 크런치',
    '시티드 크런치',
    '레그 리프트 크런치',
    '리버스 크런치',
    '바이시클 크런치'
        '플랭크',
    '사이드 플랭크',
  ],
  '다리': [
    '스쿼트',
    '바벨 스쿼트',
    '덤벨 스쿼트',
    '스미스 머신 스쿼트',
    '케틀벨 스쿼트',
    '레그 프레스',
    '레그 컬',
    '하이박스 점프',
    '런지',
    '덤벨 런지',
    '바벨 런지',
    '카프 레이즈',
    '스텝 업',
  ],
  '엉덩이': [
    '힙 쓰러스트',
    '힙 레이즈',
    '힙 어브덕션',
    '힙 익스텐션',
    '덩키 킥',
    '힙 킥 백',
    '사이드 레그 레이즈',
    '브릿지',
  ],
};

Map routineMap = {
  '등&이두 샘플': {
    '풀업': {
      'category': '등',
      'set_info': [
        {
          'set': '4',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '랫 풀 다운': {
      'category': '등',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '바벨 로우': {
      'category': '등',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '시티드 로우': {
      'category': '등',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    'EZ-바 컬': {
      'category': '이두',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '덤벨 컬': {
      'category': '이두',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '해머 컬': {
      'category': '이두',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '9',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '가슴&삼두 샘플': {
    '벤치 프레스': {
      'category': '가슴',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '딥스': {
      'category': '가슴',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '10',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '킥백': {
      'category': '삼두',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '케이블 푸쉬 다운': {
      'category': '삼두',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '어깨&다리 샘플': {
    '밀리터리 프레스': {
      'category': '어깨',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '레터럴 레이즈': {
      'category': '어깨',
      'set_info': [
        {
          'set': '4',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '리버스 플라이': {
      'category': '어깨',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '스쿼트': {
      'category': '다리',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '런지': {
      'category': '다리',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '데드 리프트': {
      'category': '등',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '6',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '복근 샘플': {
    '행잉 레그 레이즈': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '크런치': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '바이시클 크런치': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '간단한 운동 샘플': {
    '풀업': {
      'category': '등',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '10',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '싯업': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '푸시업': {
      'category': '가슴',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '스쿼트': {
      'category': '다리',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '40',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '5X5 A 샘플': {
    '벤치 프레스': {
      'category': '가슴',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '바벨 스쿼트': {
      'category': '다리',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '바벨 로우': {
      'category': '등',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '5X5 B 샘플': {
    '바벨 스쿼트': {
      'category': '다리',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '밀리터리 프레스': {
      'category': '어깨',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '데드 리프트': {
      'category': '등',
      'set_info': [
        {
          'set': '1',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
  '홈 트레이닝 샘플': {
    '플랭크': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '',
          'time': '1',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '브릿지': {
      'category': '엉덩이',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '스쿼트': {
      'category': '다리',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '크런치': {
      'category': '복부',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '15',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '푸시업': {
      'category': '가슴',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '15',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
    '레터럴 레이즈': {
      'category': '어깨',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '30',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': '분'
        }
      ]
    },
  },
};
