#!/bin/bash

if [[ -n "$1" ]]; then
    current_seed=$1
else
    current_seed=0
fi


if [[ -n "$2" ]]; then
    max_seeds=$2
else
    max_seeds=10
fi

echo $current_seed
echo $max_seeds

while(( $current_seed < $max_seeds ))
do
    python run_model.py --do_train --do_lower_case \
      --data_dir ./data/waseem-sexism \
      --bert_model bert-base-uncased \
      --max_seq_length 128 \
      --train_batch_size 32 \
      --learning_rate 2e-5 \
      --num_train_epochs 20 \
      --early_stop 5 \
      --output_dir runs/waseem-sexism-soc_new_seed_${current_seed} \
       --seed ${current_seed} \
       --task_name ws \
       --reg_explanations \
       --nb_range 5 \
       --sample_n 5 \
       --negative_weight 0.125 \
       --reg_strength 0.1 \
       --lm_dir runs/lm_ws \
       --hiex_add_itself \
       --neutral_words_file data/identity.csv
    let current_seed++
done
