-- oh-my-posh.lua
-- Updated for oh-my-posh v28+

local ohmyposh_dir = __clink_profile_dir.."oh-my-posh/"
local ohmyposh_exe = __clink_profile_dir.."oh-my-posh/bin/oh-my-posh.exe"

local ohmyposh_prompt = clink.promptfilter(999)
function ohmyposh_prompt:filter(prompt)
    prompt = io.popen(ohmyposh_exe..' print primary --config "'..ohmyposh_dir..'paradox.omp.json"'):read("*a")
    return prompt, false
end
