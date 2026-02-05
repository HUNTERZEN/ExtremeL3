function exec(cmd) {
  return fetch(`/exec?cmd=${encodeURIComponent(cmd)}`).then(r => r.text());
}

function toast(msg) {
  const t = document.getElementById("toast");
  t.innerText = msg;
  t.classList.add("show");
  setTimeout(() => t.classList.remove("show"), 2000);
}

async function writeConf(key, value) {
  await exec(`sed -i 's/^${key}=.*/${key}=${value}/' /data/adb/extremel3.conf`);
}

function setMode(v) {
  writeConf("MODE", v);
  toast(v === "gaming" ? "Gaming mode enabled" : "Balanced mode enabled");
}

function setCpuGov(v) {
  writeConf("CPU_GOV", v);
  toast("CPU governor saved");
}

function setGpuGov(v) {
  writeConf("GPU_GOV", v);
  toast("GPU governor saved");
}

async function loadSettings() {
  const conf = await exec("cat /data/adb/extremel3.conf");

  conf.split("\n").forEach(line => {
    const [k, v] = line.split("=");
    if (k === "MODE") document.getElementById("mode").value = v;
    if (k === "CPU_GOV") document.getElementById("cpuGov").value = v;
    if (k === "GPU_GOV") document.getElementById("gpuGov").value = v;
  });
}

loadSettings();

