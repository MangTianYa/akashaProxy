MODDIR=/data/adb/akashaProxy
. ${MODDIR}/sing-box.env

pid=$(curl -sL http://127.0.0.1:${kernel_ui_port} | grep sing-box)
if [[ "${pid}" ]]; then
    echo "正在停止akashaProxy."
    ${MODDIR}/scripts/sing-box.service -k && ${MODDIR}/scripts/sing-box.iptables -k
else
    echo "正在启动akashaProxy."
    ${MODDIR}/scripts/sing-box.service -s && ${MODDIR}/scripts/sing-box.iptables -s
fi
