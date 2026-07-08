MODDIR=${0%/*}
data_dir="/data/adb/akashaProxy"

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

until [ -d "/sdcard/Android" ]; do
    sleep 2
done

. ${data_dir}/sing-box.config

if [ ! -d ${data_dir}/run ]; then
    mkdir -p ${data_dir}/run
fi
crond -c ${data_dir}/run

if [ "${compatible_dashboard}" = "true" ] ; then
    [ -L /data/clash ] || ln -s /data/adb/akashaProxy /data/sing-box
fi

if [ "${self_start}" = "true" ] ; then
    nohup ${data_dir}/scripts/sing-box.service -s && ${data_dir}/scripts/sing-box.iptables -s & > ${data_dir}/run/run.logs 2>&1 &
fi
