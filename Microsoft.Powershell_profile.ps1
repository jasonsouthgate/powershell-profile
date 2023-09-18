function cd.. { cd .. }

# Enable command line prompt for git branch and status
Import-Module posh-git

# Enable git aliases if so inclined
Import-Module git-aliases -DisableNameChecking
# https://github.com/gluons/powershell-git-aliases/blob/master/src/aliases.ps1

# e.g.
# gco "foo-feature"
# gcb "bar-new-feature"
# ga .
# gcmsg "this is my commit message"
# gp
# gl

# Tab auto-completion for kubectl command
Import-Module PSKubectlCompletion
Register-KubectlCompletion

# terraform aliases for the main command loop
New-Alias -Name "tf" -Value "terraform"

function tfi { terraform init }
function tfp { terraform plan }
function tfa { terraform apply --auto-approve }

# Powershell, give me grep!
function grep {
    $input | out-string -stream | select-string $args
}
# Powershell, give me export!
function export {
    $pos = $args[0].IndexOf("=")
    $leftPart  = $args[0].Substring(0, $pos)
    $rightPart = $args[0].Substring($pos+1)
    [System.Environment]::SetEnvironmentVariable($leftPart, $rightPart, [System.EnvironmentVariableTarget]::User)
}

# Powershell, give me touch!
function touch {
    New-Item -ItemType File -Name ($args[0])
}

# Powershell, I want to focus. Give me control of Spotify!
function focus {
    start 'https://open.spotify.com/user/spotify/playlist/37i9dQZF1DWX9ZIH7jslKG?si=I4EcN0cnQFy0tdyk_meqqA'
}

# Powershell, I want to relax. Give me control of Spotify!
function relax {
    start 'https://open.spotify.com/user/calmingmusicacademy/playlist/5ePKan7UdZQYLda19zLx2L?si=gUyqCHaPScqtm8uE9CkY7A'
}

# kubectl aliases - syntax 
#
#kc = kubectl
#    sys=--namespace kube-system
#
#sub-commands:
# g = get, d = describe, rm = delete, a = apply -f, ex = exec -i -t, lo = logs -f
#
# resources:
# po = pod, dep=deployment, ing=ingress, svc=service, cm=configmap, sec=secret, ns=namespace, no=node
# 
# flags:
# output = oyaml, ojson, owide
# all = --all or --all-namespaces, depending on the command
# sl = --show-labels
# w = -w/--watch
# 
# value flags: (should be at the very end):
# f = -f/--filename
# l = -l/--selector

function kc() { & kubectl $args }
function kcsys() { & kubectl --namespace=kube-system $args }
function kca() { & kubectl apply --recursive -f $args }
function kcsysa() { & kubectl --namespace=kube-system apply --recursive -f $args }
function kcak() { & kubectl apply -k $args }
function kck() { & kubectl kustomize $args }
function kcex() { & kubectl exec -i -t $args }
function kcsysex() { & kubectl --namespace=kube-system exec -i -t $args }
function kclo() { & kubectl logs -f $args }
function kcsyslo() { & kubectl --namespace=kube-system logs -f $args }
function kclop() { & kubectl logs -f -p $args }
function kcsyslop() { & kubectl --namespace=kube-system logs -f -p $args }
function kcp() { & kubectl proxy $args }
function kcpf() { & kubectl port-forward $args }
function kcg() { & kubectl get $args }
function kcsysg() { & kubectl --namespace=kube-system get $args }
function kcd() { & kubectl describe $args }
function kcsysd() { & kubectl --namespace=kube-system describe $args }
function kcrm() { & kubectl delete $args }
function kcsysrm() { & kubectl --namespace=kube-system delete $args }
function kcrun() { & kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t $args }
function kcsysrun() { & kubectl --namespace=kube-system run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t $args }
function kcgpo() { & kubectl get pods $args }
function kcsysgpo() { & kubectl --namespace=kube-system get pods $args }
function kcdpo() { & kubectl describe pods $args }
function kcsysdpo() { & kubectl --namespace=kube-system describe pods $args }
function kcrmpo() { & kubectl delete pods $args }
function kcsysrmpo() { & kubectl --namespace=kube-system delete pods $args }
function kcgdep() { & kubectl get deployment $args }
function kcsysgdep() { & kubectl --namespace=kube-system get deployment $args }
function kcddep() { & kubectl describe deployment $args }
function kcsysddep() { & kubectl --namespace=kube-system describe deployment $args }
function kcrmdep() { & kubectl delete deployment $args }
function kcsysrmdep() { & kubectl --namespace=kube-system delete deployment $args }
function kcgsvc() { & kubectl get service $args }
function kcsysgsvc() { & kubectl --namespace=kube-system get service $args }
function kcdsvc() { & kubectl describe service $args }
function kcsysdsvc() { & kubectl --namespace=kube-system describe service $args }
function kcrmsvc() { & kubectl delete service $args }
function kcsysrmsvc() { & kubectl --namespace=kube-system delete service $args }
function kcging() { & kubectl get ingress $args }
function kcsysging() { & kubectl --namespace=kube-system get ingress $args }
function kcding() { & kubectl describe ingress $args }
function kcsysding() { & kubectl --namespace=kube-system describe ingress $args }
function kcrming() { & kubectl delete ingress $args }
function kcsysrming() { & kubectl --namespace=kube-system delete ingress $args }
function kcgcm() { & kubectl get configmap $args }
function kcsysgcm() { & kubectl --namespace=kube-system get configmap $args }
function kcdcm() { & kubectl describe configmap $args }
function kcsysdcm() { & kubectl --namespace=kube-system describe configmap $args }
function kcrmcm() { & kubectl delete configmap $args }
function kcsysrmcm() { & kubectl --namespace=kube-system delete configmap $args }
function kcgsec() { & kubectl get secret $args }
function kcsysgsec() { & kubectl --namespace=kube-system get secret $args }
function kcdsec() { & kubectl describe secret $args }
function kcsysdsec() { & kubectl --namespace=kube-system describe secret $args }
function kcrmsec() { & kubectl delete secret $args }
function kcsysrmsec() { & kubectl --namespace=kube-system delete secret $args }
function kcgno() { & kubectl get nodes $args }
function kcdno() { & kubectl describe nodes $args }
function kcgns() { & kubectl get namespaces $args }
function kcdns() { & kubectl describe namespaces $args }
function kcrmns() { & kubectl delete namespaces $args }
function kcgoyaml() { & kubectl get -o=yaml $args }
function kcsysgoyaml() { & kubectl --namespace=kube-system get -o=yaml $args }
function kcgpooyaml() { & kubectl get pods -o=yaml $args }
function kcsysgpooyaml() { & kubectl --namespace=kube-system get pods -o=yaml $args }
function kcgdepoyaml() { & kubectl get deployment -o=yaml $args }
function kcsysgdepoyaml() { & kubectl --namespace=kube-system get deployment -o=yaml $args }
function kcgsvcoyaml() { & kubectl get service -o=yaml $args }
function kcsysgsvcoyaml() { & kubectl --namespace=kube-system get service -o=yaml $args }
function kcgingoyaml() { & kubectl get ingress -o=yaml $args }
function kcsysgingoyaml() { & kubectl --namespace=kube-system get ingress -o=yaml $args }
function kcgcmoyaml() { & kubectl get configmap -o=yaml $args }
function kcsysgcmoyaml() { & kubectl --namespace=kube-system get configmap -o=yaml $args }
function kcgsecoyaml() { & kubectl get secret -o=yaml $args }
function kcsysgsecoyaml() { & kubectl --namespace=kube-system get secret -o=yaml $args }
function kcgnooyaml() { & kubectl get nodes -o=yaml $args }
function kcgnsoyaml() { & kubectl get namespaces -o=yaml $args }
function kcgowide() { & kubectl get -o=wide $args }
function kcsysgowide() { & kubectl --namespace=kube-system get -o=wide $args }
function kcgpoowide() { & kubectl get pods -o=wide $args }
function kcsysgpoowide() { & kubectl --namespace=kube-system get pods -o=wide $args }
function kcgdepowide() { & kubectl get deployment -o=wide $args }
function kcsysgdepowide() { & kubectl --namespace=kube-system get deployment -o=wide $args }
function kcgsvcowide() { & kubectl get service -o=wide $args }
function kcsysgsvcowide() { & kubectl --namespace=kube-system get service -o=wide $args }
function kcgingowide() { & kubectl get ingress -o=wide $args }
function kcsysgingowide() { & kubectl --namespace=kube-system get ingress -o=wide $args }
function kcgcmowide() { & kubectl get configmap -o=wide $args }
function kcsysgcmowide() { & kubectl --namespace=kube-system get configmap -o=wide $args }
function kcgsecowide() { & kubectl get secret -o=wide $args }
function kcsysgsecowide() { & kubectl --namespace=kube-system get secret -o=wide $args }
function kcgnoowide() { & kubectl get nodes -o=wide $args }
function kcgnsowide() { & kubectl get namespaces -o=wide $args }
function kcgojson() { & kubectl get -o=json $args }
function kcsysgojson() { & kubectl --namespace=kube-system get -o=json $args }
function kcgpoojson() { & kubectl get pods -o=json $args }
function kcsysgpoojson() { & kubectl --namespace=kube-system get pods -o=json $args }
function kcgdepojson() { & kubectl get deployment -o=json $args }
function kcsysgdepojson() { & kubectl --namespace=kube-system get deployment -o=json $args }
function kcgsvcojson() { & kubectl get service -o=json $args }
function kcsysgsvcojson() { & kubectl --namespace=kube-system get service -o=json $args }
function kcgingojson() { & kubectl get ingress -o=json $args }
function kcsysgingojson() { & kubectl --namespace=kube-system get ingress -o=json $args }
function kcgcmojson() { & kubectl get configmap -o=json $args }
function kcsysgcmojson() { & kubectl --namespace=kube-system get configmap -o=json $args }
function kcgsecojson() { & kubectl get secret -o=json $args }
function kcsysgsecojson() { & kubectl --namespace=kube-system get secret -o=json $args }
function kcgnoojson() { & kubectl get nodes -o=json $args }
function kcgnsojson() { & kubectl get namespaces -o=json $args }
function kcgall() { & kubectl get --all-namespaces $args }
function kcdall() { & kubectl describe --all-namespaces $args }
function kcgpoall() { & kubectl get pods --all-namespaces $args }
function kcdpoall() { & kubectl describe pods --all-namespaces $args }
function kcgdepall() { & kubectl get deployment --all-namespaces $args }
function kcddepall() { & kubectl describe deployment --all-namespaces $args }
function kcgsvcall() { & kubectl get service --all-namespaces $args }
function kcdsvcall() { & kubectl describe service --all-namespaces $args }
function kcgingall() { & kubectl get ingress --all-namespaces $args }
function kcdingall() { & kubectl describe ingress --all-namespaces $args }
function kcgcmall() { & kubectl get configmap --all-namespaces $args }
function kcdcmall() { & kubectl describe configmap --all-namespaces $args }
function kcgsecall() { & kubectl get secret --all-namespaces $args }
function kcdsecall() { & kubectl describe secret --all-namespaces $args }
function kcgnsall() { & kubectl get namespaces --all-namespaces $args }
function kcdnsall() { & kubectl describe namespaces --all-namespaces $args }
function kcgsl() { & kubectl get --show-labels $args }
function kcsysgsl() { & kubectl --namespace=kube-system get --show-labels $args }
function kcgposl() { & kubectl get pods --show-labels $args }
function kcsysgposl() { & kubectl --namespace=kube-system get pods --show-labels $args }
function kcgdepsl() { & kubectl get deployment --show-labels $args }
function kcsysgdepsl() { & kubectl --namespace=kube-system get deployment --show-labels $args }
function kcrmall() { & kubectl delete --all $args }
function kcsysrmall() { & kubectl --namespace=kube-system delete --all $args }
function kcrmpoall() { & kubectl delete pods --all $args }
function kcsysrmpoall() { & kubectl --namespace=kube-system delete pods --all $args }
function kcrmdepall() { & kubectl delete deployment --all $args }
function kcsysrmdepall() { & kubectl --namespace=kube-system delete deployment --all $args }
function kcrmsvcall() { & kubectl delete service --all $args }
function kcsysrmsvcall() { & kubectl --namespace=kube-system delete service --all $args }
function kcrmingall() { & kubectl delete ingress --all $args }
function kcsysrmingall() { & kubectl --namespace=kube-system delete ingress --all $args }
function kcrmcmall() { & kubectl delete configmap --all $args }
function kcsysrmcmall() { & kubectl --namespace=kube-system delete configmap --all $args }
function kcrmsecall() { & kubectl delete secret --all $args }
function kcsysrmsecall() { & kubectl --namespace=kube-system delete secret --all $args }
function kcrmnsall() { & kubectl delete namespaces --all $args }
function kcgw() { & kubectl get --watch $args }
function kcsysgw() { & kubectl --namespace=kube-system get --watch $args }
function kcgpow() { & kubectl get pods --watch $args }
function kcsysgpow() { & kubectl --namespace=kube-system get pods --watch $args }
function kcgdepw() { & kubectl get deployment --watch $args }
function kcsysgdepw() { & kubectl --namespace=kube-system get deployment --watch $args }
function kcgsvcw() { & kubectl get service --watch $args }
function kcsysgsvcw() { & kubectl --namespace=kube-system get service --watch $args }
function kcgingw() { & kubectl get ingress --watch $args }
function kcsysgingw() { & kubectl --namespace=kube-system get ingress --watch $args }
function kcgcmw() { & kubectl get configmap --watch $args }
function kcsysgcmw() { & kubectl --namespace=kube-system get configmap --watch $args }
function kcgsecw() { & kubectl get secret --watch $args }
function kcsysgsecw() { & kubectl --namespace=kube-system get secret --watch $args }
function kcgnow() { & kubectl get nodes --watch $args }
function kcgnsw() { & kubectl get namespaces --watch $args }
function kcgoyamlall() { & kubectl get -o=yaml --all-namespaces $args }
function kcgpooyamlall() { & kubectl get pods -o=yaml --all-namespaces $args }
function kcgdepoyamlall() { & kubectl get deployment -o=yaml --all-namespaces $args }
function kcgsvcoyamlall() { & kubectl get service -o=yaml --all-namespaces $args }
function kcgingoyamlall() { & kubectl get ingress -o=yaml --all-namespaces $args }
function kcgcmoyamlall() { & kubectl get configmap -o=yaml --all-namespaces $args }
function kcgsecoyamlall() { & kubectl get secret -o=yaml --all-namespaces $args }
function kcgnsoyamlall() { & kubectl get namespaces -o=yaml --all-namespaces $args }
function kcgalloyaml() { & kubectl get --all-namespaces -o=yaml $args }
function kcgpoalloyaml() { & kubectl get pods --all-namespaces -o=yaml $args }
function kcgdepalloyaml() { & kubectl get deployment --all-namespaces -o=yaml $args }
function kcgsvcalloyaml() { & kubectl get service --all-namespaces -o=yaml $args }
function kcgingalloyaml() { & kubectl get ingress --all-namespaces -o=yaml $args }
function kcgcmalloyaml() { & kubectl get configmap --all-namespaces -o=yaml $args }
function kcgsecalloyaml() { & kubectl get secret --all-namespaces -o=yaml $args }
function kcgnsalloyaml() { & kubectl get namespaces --all-namespaces -o=yaml $args }
function kcgwoyaml() { & kubectl get --watch -o=yaml $args }
function kcsysgwoyaml() { & kubectl --namespace=kube-system get --watch -o=yaml $args }
function kcgpowoyaml() { & kubectl get pods --watch -o=yaml $args }
function kcsysgpowoyaml() { & kubectl --namespace=kube-system get pods --watch -o=yaml $args }
function kcgdepwoyaml() { & kubectl get deployment --watch -o=yaml $args }
function kcsysgdepwoyaml() { & kubectl --namespace=kube-system get deployment --watch -o=yaml $args }
function kcgsvcwoyaml() { & kubectl get service --watch -o=yaml $args }
function kcsysgsvcwoyaml() { & kubectl --namespace=kube-system get service --watch -o=yaml $args }
function kcgingwoyaml() { & kubectl get ingress --watch -o=yaml $args }
function kcsysgingwoyaml() { & kubectl --namespace=kube-system get ingress --watch -o=yaml $args }
function kcgcmwoyaml() { & kubectl get configmap --watch -o=yaml $args }
function kcsysgcmwoyaml() { & kubectl --namespace=kube-system get configmap --watch -o=yaml $args }
function kcgsecwoyaml() { & kubectl get secret --watch -o=yaml $args }
function kcsysgsecwoyaml() { & kubectl --namespace=kube-system get secret --watch -o=yaml $args }
function kcgnowoyaml() { & kubectl get nodes --watch -o=yaml $args }
function kcgnswoyaml() { & kubectl get namespaces --watch -o=yaml $args }
function kcgowideall() { & kubectl get -o=wide --all-namespaces $args }
function kcgpoowideall() { & kubectl get pods -o=wide --all-namespaces $args }
function kcgdepowideall() { & kubectl get deployment -o=wide --all-namespaces $args }
function kcgsvcowideall() { & kubectl get service -o=wide --all-namespaces $args }
function kcgingowideall() { & kubectl get ingress -o=wide --all-namespaces $args }
function kcgcmowideall() { & kubectl get configmap -o=wide --all-namespaces $args }
function kcgsecowideall() { & kubectl get secret -o=wide --all-namespaces $args }
function kcgnsowideall() { & kubectl get namespaces -o=wide --all-namespaces $args }
function kcgallowide() { & kubectl get --all-namespaces -o=wide $args }
function kcgpoallowide() { & kubectl get pods --all-namespaces -o=wide $args }
function kcgdepallowide() { & kubectl get deployment --all-namespaces -o=wide $args }
function kcgsvcallowide() { & kubectl get service --all-namespaces -o=wide $args }
function kcgingallowide() { & kubectl get ingress --all-namespaces -o=wide $args }
function kcgcmallowide() { & kubectl get configmap --all-namespaces -o=wide $args }
function kcgsecallowide() { & kubectl get secret --all-namespaces -o=wide $args }
function kcgnsallowide() { & kubectl get namespaces --all-namespaces -o=wide $args }
function kcgowidesl() { & kubectl get -o=wide --show-labels $args }
function kcsysgowidesl() { & kubectl --namespace=kube-system get -o=wide --show-labels $args }
function kcgpoowidesl() { & kubectl get pods -o=wide --show-labels $args }
function kcsysgpoowidesl() { & kubectl --namespace=kube-system get pods -o=wide --show-labels $args }
function kcgdepowidesl() { & kubectl get deployment -o=wide --show-labels $args }
function kcsysgdepowidesl() { & kubectl --namespace=kube-system get deployment -o=wide --show-labels $args }
function kcgslowide() { & kubectl get --show-labels -o=wide $args }
function kcsysgslowide() { & kubectl --namespace=kube-system get --show-labels -o=wide $args }
function kcgposlowide() { & kubectl get pods --show-labels -o=wide $args }
function kcsysgposlowide() { & kubectl --namespace=kube-system get pods --show-labels -o=wide $args }
function kcgdepslowide() { & kubectl get deployment --show-labels -o=wide $args }
function kcsysgdepslowide() { & kubectl --namespace=kube-system get deployment --show-labels -o=wide $args }
function kcgwowide() { & kubectl get --watch -o=wide $args }
function kcsysgwowide() { & kubectl --namespace=kube-system get --watch -o=wide $args }
function kcgpowowide() { & kubectl get pods --watch -o=wide $args }
function kcsysgpowowide() { & kubectl --namespace=kube-system get pods --watch -o=wide $args }
function kcgdepwowide() { & kubectl get deployment --watch -o=wide $args }
function kcsysgdepwowide() { & kubectl --namespace=kube-system get deployment --watch -o=wide $args }
function kcgsvcwowide() { & kubectl get service --watch -o=wide $args }
function kcsysgsvcwowide() { & kubectl --namespace=kube-system get service --watch -o=wide $args }
function kcgingwowide() { & kubectl get ingress --watch -o=wide $args }
function kcsysgingwowide() { & kubectl --namespace=kube-system get ingress --watch -o=wide $args }
function kcgcmwowide() { & kubectl get configmap --watch -o=wide $args }
function kcsysgcmwowide() { & kubectl --namespace=kube-system get configmap --watch -o=wide $args }
function kcgsecwowide() { & kubectl get secret --watch -o=wide $args }
function kcsysgsecwowide() { & kubectl --namespace=kube-system get secret --watch -o=wide $args }
function kcgnowowide() { & kubectl get nodes --watch -o=wide $args }
function kcgnswowide() { & kubectl get namespaces --watch -o=wide $args }
function kcgojsonall() { & kubectl get -o=json --all-namespaces $args }
function kcgpoojsonall() { & kubectl get pods -o=json --all-namespaces $args }
function kcgdepojsonall() { & kubectl get deployment -o=json --all-namespaces $args }
function kcgsvcojsonall() { & kubectl get service -o=json --all-namespaces $args }
function kcgingojsonall() { & kubectl get ingress -o=json --all-namespaces $args }
function kcgcmojsonall() { & kubectl get configmap -o=json --all-namespaces $args }
function kcgsecojsonall() { & kubectl get secret -o=json --all-namespaces $args }
function kcgnsojsonall() { & kubectl get namespaces -o=json --all-namespaces $args }
function kcgallojson() { & kubectl get --all-namespaces -o=json $args }
function kcgpoallojson() { & kubectl get pods --all-namespaces -o=json $args }
function kcgdepallojson() { & kubectl get deployment --all-namespaces -o=json $args }
function kcgsvcallojson() { & kubectl get service --all-namespaces -o=json $args }
function kcgingallojson() { & kubectl get ingress --all-namespaces -o=json $args }
function kcgcmallojson() { & kubectl get configmap --all-namespaces -o=json $args }
function kcgsecallojson() { & kubectl get secret --all-namespaces -o=json $args }
function kcgnsallojson() { & kubectl get namespaces --all-namespaces -o=json $args }
function kcgwojson() { & kubectl get --watch -o=json $args }
function kcsysgwojson() { & kubectl --namespace=kube-system get --watch -o=json $args }
function kcgpowojson() { & kubectl get pods --watch -o=json $args }
function kcsysgpowojson() { & kubectl --namespace=kube-system get pods --watch -o=json $args }
function kcgdepwojson() { & kubectl get deployment --watch -o=json $args }
function kcsysgdepwojson() { & kubectl --namespace=kube-system get deployment --watch -o=json $args }
function kcgsvcwojson() { & kubectl get service --watch -o=json $args }
function kcsysgsvcwojson() { & kubectl --namespace=kube-system get service --watch -o=json $args }
function kcgingwojson() { & kubectl get ingress --watch -o=json $args }
function kcsysgingwojson() { & kubectl --namespace=kube-system get ingress --watch -o=json $args }
function kcgcmwojson() { & kubectl get configmap --watch -o=json $args }
function kcsysgcmwojson() { & kubectl --namespace=kube-system get configmap --watch -o=json $args }
function kcgsecwojson() { & kubectl get secret --watch -o=json $args }
function kcsysgsecwojson() { & kubectl --namespace=kube-system get secret --watch -o=json $args }
function kcgnowojson() { & kubectl get nodes --watch -o=json $args }
function kcgnswojson() { & kubectl get namespaces --watch -o=json $args }
function kcgallsl() { & kubectl get --all-namespaces --show-labels $args }
function kcgpoallsl() { & kubectl get pods --all-namespaces --show-labels $args }
function kcgdepallsl() { & kubectl get deployment --all-namespaces --show-labels $args }
function kcgslall() { & kubectl get --show-labels --all-namespaces $args }
function kcgposlall() { & kubectl get pods --show-labels --all-namespaces $args }
function kcgdepslall() { & kubectl get deployment --show-labels --all-namespaces $args }
function kcgallw() { & kubectl get --all-namespaces --watch $args }
function kcgpoallw() { & kubectl get pods --all-namespaces --watch $args }
function kcgdepallw() { & kubectl get deployment --all-namespaces --watch $args }
function kcgsvcallw() { & kubectl get service --all-namespaces --watch $args }
function kcgingallw() { & kubectl get ingress --all-namespaces --watch $args }
function kcgcmallw() { & kubectl get configmap --all-namespaces --watch $args }
function kcgsecallw() { & kubectl get secret --all-namespaces --watch $args }
function kcgnsallw() { & kubectl get namespaces --all-namespaces --watch $args }
function kcgwall() { & kubectl get --watch --all-namespaces $args }
function kcgpowall() { & kubectl get pods --watch --all-namespaces $args }
function kcgdepwall() { & kubectl get deployment --watch --all-namespaces $args }
function kcgsvcwall() { & kubectl get service --watch --all-namespaces $args }
function kcgingwall() { & kubectl get ingress --watch --all-namespaces $args }
function kcgcmwall() { & kubectl get configmap --watch --all-namespaces $args }
function kcgsecwall() { & kubectl get secret --watch --all-namespaces $args }
function kcgnswall() { & kubectl get namespaces --watch --all-namespaces $args }
function kcgslw() { & kubectl get --show-labels --watch $args }
function kcsysgslw() { & kubectl --namespace=kube-system get --show-labels --watch $args }
function kcgposlw() { & kubectl get pods --show-labels --watch $args }
function kcsysgposlw() { & kubectl --namespace=kube-system get pods --show-labels --watch $args }
function kcgdepslw() { & kubectl get deployment --show-labels --watch $args }
function kcsysgdepslw() { & kubectl --namespace=kube-system get deployment --show-labels --watch $args }
function kcgwsl() { & kubectl get --watch --show-labels $args }
function kcsysgwsl() { & kubectl --namespace=kube-system get --watch --show-labels $args }
function kcgpowsl() { & kubectl get pods --watch --show-labels $args }
function kcsysgpowsl() { & kubectl --namespace=kube-system get pods --watch --show-labels $args }
function kcgdepwsl() { & kubectl get deployment --watch --show-labels $args }
function kcsysgdepwsl() { & kubectl --namespace=kube-system get deployment --watch --show-labels $args }
function kcgallwoyaml() { & kubectl get --all-namespaces --watch -o=yaml $args }
function kcgpoallwoyaml() { & kubectl get pods --all-namespaces --watch -o=yaml $args }
function kcgdepallwoyaml() { & kubectl get deployment --all-namespaces --watch -o=yaml $args }
function kcgsvcallwoyaml() { & kubectl get service --all-namespaces --watch -o=yaml $args }
function kcgingallwoyaml() { & kubectl get ingress --all-namespaces --watch -o=yaml $args }
function kcgcmallwoyaml() { & kubectl get configmap --all-namespaces --watch -o=yaml $args }
function kcgsecallwoyaml() { & kubectl get secret --all-namespaces --watch -o=yaml $args }
function kcgnsallwoyaml() { & kubectl get namespaces --all-namespaces --watch -o=yaml $args }
function kcgwoyamlall() { & kubectl get --watch -o=yaml --all-namespaces $args }
function kcgpowoyamlall() { & kubectl get pods --watch -o=yaml --all-namespaces $args }
function kcgdepwoyamlall() { & kubectl get deployment --watch -o=yaml --all-namespaces $args }
function kcgsvcwoyamlall() { & kubectl get service --watch -o=yaml --all-namespaces $args }
function kcgingwoyamlall() { & kubectl get ingress --watch -o=yaml --all-namespaces $args }
function kcgcmwoyamlall() { & kubectl get configmap --watch -o=yaml --all-namespaces $args }
function kcgsecwoyamlall() { & kubectl get secret --watch -o=yaml --all-namespaces $args }
function kcgnswoyamlall() { & kubectl get namespaces --watch -o=yaml --all-namespaces $args }
function kcgwalloyaml() { & kubectl get --watch --all-namespaces -o=yaml $args }
function kcgpowalloyaml() { & kubectl get pods --watch --all-namespaces -o=yaml $args }
function kcgdepwalloyaml() { & kubectl get deployment --watch --all-namespaces -o=yaml $args }
function kcgsvcwalloyaml() { & kubectl get service --watch --all-namespaces -o=yaml $args }
function kcgingwalloyaml() { & kubectl get ingress --watch --all-namespaces -o=yaml $args }
function kcgcmwalloyaml() { & kubectl get configmap --watch --all-namespaces -o=yaml $args }
function kcgsecwalloyaml() { & kubectl get secret --watch --all-namespaces -o=yaml $args }
function kcgnswalloyaml() { & kubectl get namespaces --watch --all-namespaces -o=yaml $args }
function kcgowideallsl() { & kubectl get -o=wide --all-namespaces --show-labels $args }
function kcgpoowideallsl() { & kubectl get pods -o=wide --all-namespaces --show-labels $args }
function kcgdepowideallsl() { & kubectl get deployment -o=wide --all-namespaces --show-labels $args }
function kcgowideslall() { & kubectl get -o=wide --show-labels --all-namespaces $args }
function kcgpoowideslall() { & kubectl get pods -o=wide --show-labels --all-namespaces $args }
function kcgdepowideslall() { & kubectl get deployment -o=wide --show-labels --all-namespaces $args }
function kcgallowidesl() { & kubectl get --all-namespaces -o=wide --show-labels $args }
function kcgpoallowidesl() { & kubectl get pods --all-namespaces -o=wide --show-labels $args }
function kcgdepallowidesl() { & kubectl get deployment --all-namespaces -o=wide --show-labels $args }
function kcgallslowide() { & kubectl get --all-namespaces --show-labels -o=wide $args }
function kcgpoallslowide() { & kubectl get pods --all-namespaces --show-labels -o=wide $args }
function kcgdepallslowide() { & kubectl get deployment --all-namespaces --show-labels -o=wide $args }
function kcgslowideall() { & kubectl get --show-labels -o=wide --all-namespaces $args }
function kcgposlowideall() { & kubectl get pods --show-labels -o=wide --all-namespaces $args }
function kcgdepslowideall() { & kubectl get deployment --show-labels -o=wide --all-namespaces $args }
function kcgslallowide() { & kubectl get --show-labels --all-namespaces -o=wide $args }
function kcgposlallowide() { & kubectl get pods --show-labels --all-namespaces -o=wide $args }
function kcgdepslallowide() { & kubectl get deployment --show-labels --all-namespaces -o=wide $args }
function kcgallwowide() { & kubectl get --all-namespaces --watch -o=wide $args }
function kcgpoallwowide() { & kubectl get pods --all-namespaces --watch -o=wide $args }
function kcgdepallwowide() { & kubectl get deployment --all-namespaces --watch -o=wide $args }
function kcgsvcallwowide() { & kubectl get service --all-namespaces --watch -o=wide $args }
function kcgingallwowide() { & kubectl get ingress --all-namespaces --watch -o=wide $args }
function kcgcmallwowide() { & kubectl get configmap --all-namespaces --watch -o=wide $args }
function kcgsecallwowide() { & kubectl get secret --all-namespaces --watch -o=wide $args }
function kcgnsallwowide() { & kubectl get namespaces --all-namespaces --watch -o=wide $args }
function kcgwowideall() { & kubectl get --watch -o=wide --all-namespaces $args }
function kcgpowowideall() { & kubectl get pods --watch -o=wide --all-namespaces $args }
function kcgdepwowideall() { & kubectl get deployment --watch -o=wide --all-namespaces $args }
function kcgsvcwowideall() { & kubectl get service --watch -o=wide --all-namespaces $args }
function kcgingwowideall() { & kubectl get ingress --watch -o=wide --all-namespaces $args }
function kcgcmwowideall() { & kubectl get configmap --watch -o=wide --all-namespaces $args }
function kcgsecwowideall() { & kubectl get secret --watch -o=wide --all-namespaces $args }
function kcgnswowideall() { & kubectl get namespaces --watch -o=wide --all-namespaces $args }
function kcgwallowide() { & kubectl get --watch --all-namespaces -o=wide $args }
function kcgpowallowide() { & kubectl get pods --watch --all-namespaces -o=wide $args }
function kcgdepwallowide() { & kubectl get deployment --watch --all-namespaces -o=wide $args }
function kcgsvcwallowide() { & kubectl get service --watch --all-namespaces -o=wide $args }
function kcgingwallowide() { & kubectl get ingress --watch --all-namespaces -o=wide $args }
function kcgcmwallowide() { & kubectl get configmap --watch --all-namespaces -o=wide $args }
function kcgsecwallowide() { & kubectl get secret --watch --all-namespaces -o=wide $args }
function kcgnswallowide() { & kubectl get namespaces --watch --all-namespaces -o=wide $args }
function kcgslwowide() { & kubectl get --show-labels --watch -o=wide $args }
function kcsysgslwowide() { & kubectl --namespace=kube-system get --show-labels --watch -o=wide $args }
function kcgposlwowide() { & kubectl get pods --show-labels --watch -o=wide $args }
function kcsysgposlwowide() { & kubectl --namespace=kube-system get pods --show-labels --watch -o=wide $args }
function kcgdepslwowide() { & kubectl get deployment --show-labels --watch -o=wide $args }
function kcsysgdepslwowide() { & kubectl --namespace=kube-system get deployment --show-labels --watch -o=wide $args }
function kcgwowidesl() { & kubectl get --watch -o=wide --show-labels $args }
function kcsysgwowidesl() { & kubectl --namespace=kube-system get --watch -o=wide --show-labels $args }
function kcgpowowidesl() { & kubectl get pods --watch -o=wide --show-labels $args }
function kcsysgpowowidesl() { & kubectl --namespace=kube-system get pods --watch -o=wide --show-labels $args }
function kcgdepwowidesl() { & kubectl get deployment --watch -o=wide --show-labels $args }
function kcsysgdepwowidesl() { & kubectl --namespace=kube-system get deployment --watch -o=wide --show-labels $args }
function kcgwslowide() { & kubectl get --watch --show-labels -o=wide $args }
function kcsysgwslowide() { & kubectl --namespace=kube-system get --watch --show-labels -o=wide $args }
function kcgpowslowide() { & kubectl get pods --watch --show-labels -o=wide $args }
function kcsysgpowslowide() { & kubectl --namespace=kube-system get pods --watch --show-labels -o=wide $args }
function kcgdepwslowide() { & kubectl get deployment --watch --show-labels -o=wide $args }
function kcsysgdepwslowide() { & kubectl --namespace=kube-system get deployment --watch --show-labels -o=wide $args }
function kcgallwojson() { & kubectl get --all-namespaces --watch -o=json $args }
function kcgpoallwojson() { & kubectl get pods --all-namespaces --watch -o=json $args }
function kcgdepallwojson() { & kubectl get deployment --all-namespaces --watch -o=json $args }
function kcgsvcallwojson() { & kubectl get service --all-namespaces --watch -o=json $args }
function kcgingallwojson() { & kubectl get ingress --all-namespaces --watch -o=json $args }
function kcgcmallwojson() { & kubectl get configmap --all-namespaces --watch -o=json $args }
function kcgsecallwojson() { & kubectl get secret --all-namespaces --watch -o=json $args }
function kcgnsallwojson() { & kubectl get namespaces --all-namespaces --watch -o=json $args }
function kcgwojsonall() { & kubectl get --watch -o=json --all-namespaces $args }
function kcgpowojsonall() { & kubectl get pods --watch -o=json --all-namespaces $args }
function kcgdepwojsonall() { & kubectl get deployment --watch -o=json --all-namespaces $args }
function kcgsvcwojsonall() { & kubectl get service --watch -o=json --all-namespaces $args }
function kcgingwojsonall() { & kubectl get ingress --watch -o=json --all-namespaces $args }
function kcgcmwojsonall() { & kubectl get configmap --watch -o=json --all-namespaces $args }
function kcgsecwojsonall() { & kubectl get secret --watch -o=json --all-namespaces $args }
function kcgnswojsonall() { & kubectl get namespaces --watch -o=json --all-namespaces $args }
function kcgwallojson() { & kubectl get --watch --all-namespaces -o=json $args }
function kcgpowallojson() { & kubectl get pods --watch --all-namespaces -o=json $args }
function kcgdepwallojson() { & kubectl get deployment --watch --all-namespaces -o=json $args }
function kcgsvcwallojson() { & kubectl get service --watch --all-namespaces -o=json $args }
function kcgingwallojson() { & kubectl get ingress --watch --all-namespaces -o=json $args }
function kcgcmwallojson() { & kubectl get configmap --watch --all-namespaces -o=json $args }
function kcgsecwallojson() { & kubectl get secret --watch --all-namespaces -o=json $args }
function kcgnswallojson() { & kubectl get namespaces --watch --all-namespaces -o=json $args }
function kcgallslw() { & kubectl get --all-namespaces --show-labels --watch $args }
function kcgpoallslw() { & kubectl get pods --all-namespaces --show-labels --watch $args }
function kcgdepallslw() { & kubectl get deployment --all-namespaces --show-labels --watch $args }
function kcgallwsl() { & kubectl get --all-namespaces --watch --show-labels $args }
function kcgpoallwsl() { & kubectl get pods --all-namespaces --watch --show-labels $args }
function kcgdepallwsl() { & kubectl get deployment --all-namespaces --watch --show-labels $args }
function kcgslallw() { & kubectl get --show-labels --all-namespaces --watch $args }
function kcgposlallw() { & kubectl get pods --show-labels --all-namespaces --watch $args }
function kcgdepslallw() { & kubectl get deployment --show-labels --all-namespaces --watch $args }
function kcgslwall() { & kubectl get --show-labels --watch --all-namespaces $args }
function kcgposlwall() { & kubectl get pods --show-labels --watch --all-namespaces $args }
function kcgdepslwall() { & kubectl get deployment --show-labels --watch --all-namespaces $args }
function kcgwallsl() { & kubectl get --watch --all-namespaces --show-labels $args }
function kcgpowallsl() { & kubectl get pods --watch --all-namespaces --show-labels $args }
function kcgdepwallsl() { & kubectl get deployment --watch --all-namespaces --show-labels $args }
function kcgwslall() { & kubectl get --watch --show-labels --all-namespaces $args }
function kcgpowslall() { & kubectl get pods --watch --show-labels --all-namespaces $args }
function kcgdepwslall() { & kubectl get deployment --watch --show-labels --all-namespaces $args }
function kcgallslwowide() { & kubectl get --all-namespaces --show-labels --watch -o=wide $args }
function kcgpoallslwowide() { & kubectl get pods --all-namespaces --show-labels --watch -o=wide $args }
function kcgdepallslwowide() { & kubectl get deployment --all-namespaces --show-labels --watch -o=wide $args }
function kcgallwowidesl() { & kubectl get --all-namespaces --watch -o=wide --show-labels $args }
function kcgpoallwowidesl() { & kubectl get pods --all-namespaces --watch -o=wide --show-labels $args }
function kcgdepallwowidesl() { & kubectl get deployment --all-namespaces --watch -o=wide --show-labels $args }
function kcgallwslowide() { & kubectl get --all-namespaces --watch --show-labels -o=wide $args }
function kcgpoallwslowide() { & kubectl get pods --all-namespaces --watch --show-labels -o=wide $args }
function kcgdepallwslowide() { & kubectl get deployment --all-namespaces --watch --show-labels -o=wide $args }
function kcgslallwowide() { & kubectl get --show-labels --all-namespaces --watch -o=wide $args }
function kcgposlallwowide() { & kubectl get pods --show-labels --all-namespaces --watch -o=wide $args }
function kcgdepslallwowide() { & kubectl get deployment --show-labels --all-namespaces --watch -o=wide $args }
function kcgslwowideall() { & kubectl get --show-labels --watch -o=wide --all-namespaces $args }
function kcgposlwowideall() { & kubectl get pods --show-labels --watch -o=wide --all-namespaces $args }
function kcgdepslwowideall() { & kubectl get deployment --show-labels --watch -o=wide --all-namespaces $args }
function kcgslwallowide() { & kubectl get --show-labels --watch --all-namespaces -o=wide $args }
function kcgposlwallowide() { & kubectl get pods --show-labels --watch --all-namespaces -o=wide $args }
function kcgdepslwallowide() { & kubectl get deployment --show-labels --watch --all-namespaces -o=wide $args }
function kcgwowideallsl() { & kubectl get --watch -o=wide --all-namespaces --show-labels $args }
function kcgpowowideallsl() { & kubectl get pods --watch -o=wide --all-namespaces --show-labels $args }
function kcgdepwowideallsl() { & kubectl get deployment --watch -o=wide --all-namespaces --show-labels $args }
function kcgwowideslall() { & kubectl get --watch -o=wide --show-labels --all-namespaces $args }
function kcgpowowideslall() { & kubectl get pods --watch -o=wide --show-labels --all-namespaces $args }
function kcgdepwowideslall() { & kubectl get deployment --watch -o=wide --show-labels --all-namespaces $args }
function kcgwallowidesl() { & kubectl get --watch --all-namespaces -o=wide --show-labels $args }
function kcgpowallowidesl() { & kubectl get pods --watch --all-namespaces -o=wide --show-labels $args }
function kcgdepwallowidesl() { & kubectl get deployment --watch --all-namespaces -o=wide --show-labels $args }
function kcgwallslowide() { & kubectl get --watch --all-namespaces --show-labels -o=wide $args }
function kcgpowallslowide() { & kubectl get pods --watch --all-namespaces --show-labels -o=wide $args }
function kcgdepwallslowide() { & kubectl get deployment --watch --all-namespaces --show-labels -o=wide $args }
function kcgwslowideall() { & kubectl get --watch --show-labels -o=wide --all-namespaces $args }
function kcgpowslowideall() { & kubectl get pods --watch --show-labels -o=wide --all-namespaces $args }
function kcgdepwslowideall() { & kubectl get deployment --watch --show-labels -o=wide --all-namespaces $args }
function kcgwslallowide() { & kubectl get --watch --show-labels --all-namespaces -o=wide $args }
function kcgpowslallowide() { & kubectl get pods --watch --show-labels --all-namespaces -o=wide $args }
function kcgdepwslallowide() { & kubectl get deployment --watch --show-labels --all-namespaces -o=wide $args }
function kcgf() { & kubectl get --recursive -f $args }
function kcdf() { & kubectl describe --recursive -f $args }
function kcrmf() { & kubectl delete --recursive -f $args }
function kcgoyamlf() { & kubectl get -o=yaml --recursive -f $args }
function kcgowidef() { & kubectl get -o=wide --recursive -f $args }
function kcgojsonf() { & kubectl get -o=json --recursive -f $args }
function kcgslf() { & kubectl get --show-labels --recursive -f $args }
function kcgwf() { & kubectl get --watch --recursive -f $args }
function kcgwoyamlf() { & kubectl get --watch -o=yaml --recursive -f $args }
function kcgowideslf() { & kubectl get -o=wide --show-labels --recursive -f $args }
function kcgslowidef() { & kubectl get --show-labels -o=wide --recursive -f $args }
function kcgwowidef() { & kubectl get --watch -o=wide --recursive -f $args }
function kcgwojsonf() { & kubectl get --watch -o=json --recursive -f $args }
function kcgslwf() { & kubectl get --show-labels --watch --recursive -f $args }
function kcgwslf() { & kubectl get --watch --show-labels --recursive -f $args }
function kcgslwowidef() { & kubectl get --show-labels --watch -o=wide --recursive -f $args }
function kcgwowideslf() { & kubectl get --watch -o=wide --show-labels --recursive -f $args }
function kcgwslowidef() { & kubectl get --watch --show-labels -o=wide --recursive -f $args }
function kcgl() { & kubectl get -l $args }
function kcsysgl() { & kubectl --namespace=kube-system get -l $args }
function kcdl() { & kubectl describe -l $args }
function kcsysdl() { & kubectl --namespace=kube-system describe -l $args }
function kcrml() { & kubectl delete -l $args }
function kcsysrml() { & kubectl --namespace=kube-system delete -l $args }
function kcgpol() { & kubectl get pods -l $args }
function kcsysgpol() { & kubectl --namespace=kube-system get pods -l $args }
function kcdpol() { & kubectl describe pods -l $args }
function kcsysdpol() { & kubectl --namespace=kube-system describe pods -l $args }
function kcrmpol() { & kubectl delete pods -l $args }
function kcsysrmpol() { & kubectl --namespace=kube-system delete pods -l $args }
function kcgdepl() { & kubectl get deployment -l $args }
function kcsysgdepl() { & kubectl --namespace=kube-system get deployment -l $args }
function kcddepl() { & kubectl describe deployment -l $args }
function kcsysddepl() { & kubectl --namespace=kube-system describe deployment -l $args }
function kcrmdepl() { & kubectl delete deployment -l $args }
function kcsysrmdepl() { & kubectl --namespace=kube-system delete deployment -l $args }
function kcgsvcl() { & kubectl get service -l $args }
function kcsysgsvcl() { & kubectl --namespace=kube-system get service -l $args }
function kcdsvcl() { & kubectl describe service -l $args }
function kcsysdsvcl() { & kubectl --namespace=kube-system describe service -l $args }
function kcrmsvcl() { & kubectl delete service -l $args }
function kcsysrmsvcl() { & kubectl --namespace=kube-system delete service -l $args }
function kcgingl() { & kubectl get ingress -l $args }
function kcsysgingl() { & kubectl --namespace=kube-system get ingress -l $args }
function kcdingl() { & kubectl describe ingress -l $args }
function kcsysdingl() { & kubectl --namespace=kube-system describe ingress -l $args }
function kcrmingl() { & kubectl delete ingress -l $args }
function kcsysrmingl() { & kubectl --namespace=kube-system delete ingress -l $args }
function kcgcml() { & kubectl get configmap -l $args }
function kcsysgcml() { & kubectl --namespace=kube-system get configmap -l $args }
function kcdcml() { & kubectl describe configmap -l $args }
function kcsysdcml() { & kubectl --namespace=kube-system describe configmap -l $args }
function kcrmcml() { & kubectl delete configmap -l $args }
function kcsysrmcml() { & kubectl --namespace=kube-system delete configmap -l $args }
function kcgsecl() { & kubectl get secret -l $args }
function kcsysgsecl() { & kubectl --namespace=kube-system get secret -l $args }
function kcdsecl() { & kubectl describe secret -l $args }
function kcsysdsecl() { & kubectl --namespace=kube-system describe secret -l $args }
function kcrmsecl() { & kubectl delete secret -l $args }
function kcsysrmsecl() { & kubectl --namespace=kube-system delete secret -l $args }
function kcgnol() { & kubectl get nodes -l $args }
function kcdnol() { & kubectl describe nodes -l $args }
function kcgnsl() { & kubectl get namespaces -l $args }
function kcdnsl() { & kubectl describe namespaces -l $args }
function kcrmnsl() { & kubectl delete namespaces -l $args }
function kcgoyamll() { & kubectl get -o=yaml -l $args }
function kcsysgoyamll() { & kubectl --namespace=kube-system get -o=yaml -l $args }
function kcgpooyamll() { & kubectl get pods -o=yaml -l $args }
function kcsysgpooyamll() { & kubectl --namespace=kube-system get pods -o=yaml -l $args }
function kcgdepoyamll() { & kubectl get deployment -o=yaml -l $args }
function kcsysgdepoyamll() { & kubectl --namespace=kube-system get deployment -o=yaml -l $args }
function kcgsvcoyamll() { & kubectl get service -o=yaml -l $args }
function kcsysgsvcoyamll() { & kubectl --namespace=kube-system get service -o=yaml -l $args }
function kcgingoyamll() { & kubectl get ingress -o=yaml -l $args }
function kcsysgingoyamll() { & kubectl --namespace=kube-system get ingress -o=yaml -l $args }
function kcgcmoyamll() { & kubectl get configmap -o=yaml -l $args }
function kcsysgcmoyamll() { & kubectl --namespace=kube-system get configmap -o=yaml -l $args }
function kcgsecoyamll() { & kubectl get secret -o=yaml -l $args }
function kcsysgsecoyamll() { & kubectl --namespace=kube-system get secret -o=yaml -l $args }
function kcgnooyamll() { & kubectl get nodes -o=yaml -l $args }
function kcgnsoyamll() { & kubectl get namespaces -o=yaml -l $args }
function kcgowidel() { & kubectl get -o=wide -l $args }
function kcsysgowidel() { & kubectl --namespace=kube-system get -o=wide -l $args }
function kcgpoowidel() { & kubectl get pods -o=wide -l $args }
function kcsysgpoowidel() { & kubectl --namespace=kube-system get pods -o=wide -l $args }
function kcgdepowidel() { & kubectl get deployment -o=wide -l $args }
function kcsysgdepowidel() { & kubectl --namespace=kube-system get deployment -o=wide -l $args }
function kcgsvcowidel() { & kubectl get service -o=wide -l $args }
function kcsysgsvcowidel() { & kubectl --namespace=kube-system get service -o=wide -l $args }
function kcgingowidel() { & kubectl get ingress -o=wide -l $args }
function kcsysgingowidel() { & kubectl --namespace=kube-system get ingress -o=wide -l $args }
function kcgcmowidel() { & kubectl get configmap -o=wide -l $args }
function kcsysgcmowidel() { & kubectl --namespace=kube-system get configmap -o=wide -l $args }
function kcgsecowidel() { & kubectl get secret -o=wide -l $args }
function kcsysgsecowidel() { & kubectl --namespace=kube-system get secret -o=wide -l $args }
function kcgnoowidel() { & kubectl get nodes -o=wide -l $args }
function kcgnsowidel() { & kubectl get namespaces -o=wide -l $args }
function kcgojsonl() { & kubectl get -o=json -l $args }
function kcsysgojsonl() { & kubectl --namespace=kube-system get -o=json -l $args }
function kcgpoojsonl() { & kubectl get pods -o=json -l $args }
function kcsysgpoojsonl() { & kubectl --namespace=kube-system get pods -o=json -l $args }
function kcgdepojsonl() { & kubectl get deployment -o=json -l $args }
function kcsysgdepojsonl() { & kubectl --namespace=kube-system get deployment -o=json -l $args }
function kcgsvcojsonl() { & kubectl get service -o=json -l $args }
function kcsysgsvcojsonl() { & kubectl --namespace=kube-system get service -o=json -l $args }
function kcgingojsonl() { & kubectl get ingress -o=json -l $args }
function kcsysgingojsonl() { & kubectl --namespace=kube-system get ingress -o=json -l $args }
function kcgcmojsonl() { & kubectl get configmap -o=json -l $args }
function kcsysgcmojsonl() { & kubectl --namespace=kube-system get configmap -o=json -l $args }
function kcgsecojsonl() { & kubectl get secret -o=json -l $args }
function kcsysgsecojsonl() { & kubectl --namespace=kube-system get secret -o=json -l $args }
function kcgnoojsonl() { & kubectl get nodes -o=json -l $args }
function kcgnsojsonl() { & kubectl get namespaces -o=json -l $args }
function kcgsll() { & kubectl get --show-labels -l $args }
function kcsysgsll() { & kubectl --namespace=kube-system get --show-labels -l $args }
function kcgposll() { & kubectl get pods --show-labels -l $args }
function kcsysgposll() { & kubectl --namespace=kube-system get pods --show-labels -l $args }
function kcgdepsll() { & kubectl get deployment --show-labels -l $args }
function kcsysgdepsll() { & kubectl --namespace=kube-system get deployment --show-labels -l $args }
function kcgwl() { & kubectl get --watch -l $args }
function kcsysgwl() { & kubectl --namespace=kube-system get --watch -l $args }
function kcgpowl() { & kubectl get pods --watch -l $args }
function kcsysgpowl() { & kubectl --namespace=kube-system get pods --watch -l $args }
function kcgdepwl() { & kubectl get deployment --watch -l $args }
function kcsysgdepwl() { & kubectl --namespace=kube-system get deployment --watch -l $args }
function kcgsvcwl() { & kubectl get service --watch -l $args }
function kcsysgsvcwl() { & kubectl --namespace=kube-system get service --watch -l $args }
function kcgingwl() { & kubectl get ingress --watch -l $args }
function kcsysgingwl() { & kubectl --namespace=kube-system get ingress --watch -l $args }
function kcgcmwl() { & kubectl get configmap --watch -l $args }
function kcsysgcmwl() { & kubectl --namespace=kube-system get configmap --watch -l $args }
function kcgsecwl() { & kubectl get secret --watch -l $args }
function kcsysgsecwl() { & kubectl --namespace=kube-system get secret --watch -l $args }
function kcgnowl() { & kubectl get nodes --watch -l $args }
function kcgnswl() { & kubectl get namespaces --watch -l $args }
function kcgwoyamll() { & kubectl get --watch -o=yaml -l $args }
function kcsysgwoyamll() { & kubectl --namespace=kube-system get --watch -o=yaml -l $args }
function kcgpowoyamll() { & kubectl get pods --watch -o=yaml -l $args }
function kcsysgpowoyamll() { & kubectl --namespace=kube-system get pods --watch -o=yaml -l $args }
function kcgdepwoyamll() { & kubectl get deployment --watch -o=yaml -l $args }
function kcsysgdepwoyamll() { & kubectl --namespace=kube-system get deployment --watch -o=yaml -l $args }
function kcgsvcwoyamll() { & kubectl get service --watch -o=yaml -l $args }
function kcsysgsvcwoyamll() { & kubectl --namespace=kube-system get service --watch -o=yaml -l $args }
function kcgingwoyamll() { & kubectl get ingress --watch -o=yaml -l $args }
function kcsysgingwoyamll() { & kubectl --namespace=kube-system get ingress --watch -o=yaml -l $args }
function kcgcmwoyamll() { & kubectl get configmap --watch -o=yaml -l $args }
function kcsysgcmwoyamll() { & kubectl --namespace=kube-system get configmap --watch -o=yaml -l $args }
function kcgsecwoyamll() { & kubectl get secret --watch -o=yaml -l $args }
function kcsysgsecwoyamll() { & kubectl --namespace=kube-system get secret --watch -o=yaml -l $args }
function kcgnowoyamll() { & kubectl get nodes --watch -o=yaml -l $args }
function kcgnswoyamll() { & kubectl get namespaces --watch -o=yaml -l $args }
function kcgowidesll() { & kubectl get -o=wide --show-labels -l $args }
function kcsysgowidesll() { & kubectl --namespace=kube-system get -o=wide --show-labels -l $args }
function kcgpoowidesll() { & kubectl get pods -o=wide --show-labels -l $args }
function kcsysgpoowidesll() { & kubectl --namespace=kube-system get pods -o=wide --show-labels -l $args }
function kcgdepowidesll() { & kubectl get deployment -o=wide --show-labels -l $args }
function kcsysgdepowidesll() { & kubectl --namespace=kube-system get deployment -o=wide --show-labels -l $args }
function kcgslowidel() { & kubectl get --show-labels -o=wide -l $args }
function kcsysgslowidel() { & kubectl --namespace=kube-system get --show-labels -o=wide -l $args }
function kcgposlowidel() { & kubectl get pods --show-labels -o=wide -l $args }
function kcsysgposlowidel() { & kubectl --namespace=kube-system get pods --show-labels -o=wide -l $args }
function kcgdepslowidel() { & kubectl get deployment --show-labels -o=wide -l $args }
function kcsysgdepslowidel() { & kubectl --namespace=kube-system get deployment --show-labels -o=wide -l $args }
function kcgwowidel() { & kubectl get --watch -o=wide -l $args }
function kcsysgwowidel() { & kubectl --namespace=kube-system get --watch -o=wide -l $args }
function kcgpowowidel() { & kubectl get pods --watch -o=wide -l $args }
function kcsysgpowowidel() { & kubectl --namespace=kube-system get pods --watch -o=wide -l $args }
function kcgdepwowidel() { & kubectl get deployment --watch -o=wide -l $args }
function kcsysgdepwowidel() { & kubectl --namespace=kube-system get deployment --watch -o=wide -l $args }
function kcgsvcwowidel() { & kubectl get service --watch -o=wide -l $args }
function kcsysgsvcwowidel() { & kubectl --namespace=kube-system get service --watch -o=wide -l $args }
function kcgingwowidel() { & kubectl get ingress --watch -o=wide -l $args }
function kcsysgingwowidel() { & kubectl --namespace=kube-system get ingress --watch -o=wide -l $args }
function kcgcmwowidel() { & kubectl get configmap --watch -o=wide -l $args }
function kcsysgcmwowidel() { & kubectl --namespace=kube-system get configmap --watch -o=wide -l $args }
function kcgsecwowidel() { & kubectl get secret --watch -o=wide -l $args }
function kcsysgsecwowidel() { & kubectl --namespace=kube-system get secret --watch -o=wide -l $args }
function kcgnowowidel() { & kubectl get nodes --watch -o=wide -l $args }
function kcgnswowidel() { & kubectl get namespaces --watch -o=wide -l $args }
function kcgwojsonl() { & kubectl get --watch -o=json -l $args }
function kcsysgwojsonl() { & kubectl --namespace=kube-system get --watch -o=json -l $args }
function kcgpowojsonl() { & kubectl get pods --watch -o=json -l $args }
function kcsysgpowojsonl() { & kubectl --namespace=kube-system get pods --watch -o=json -l $args }
function kcgdepwojsonl() { & kubectl get deployment --watch -o=json -l $args }
function kcsysgdepwojsonl() { & kubectl --namespace=kube-system get deployment --watch -o=json -l $args }
function kcgsvcwojsonl() { & kubectl get service --watch -o=json -l $args }
function kcsysgsvcwojsonl() { & kubectl --namespace=kube-system get service --watch -o=json -l $args }
function kcgingwojsonl() { & kubectl get ingress --watch -o=json -l $args }
function kcsysgingwojsonl() { & kubectl --namespace=kube-system get ingress --watch -o=json -l $args }
function kcgcmwojsonl() { & kubectl get configmap --watch -o=json -l $args }
function kcsysgcmwojsonl() { & kubectl --namespace=kube-system get configmap --watch -o=json -l $args }
function kcgsecwojsonl() { & kubectl get secret --watch -o=json -l $args }
function kcsysgsecwojsonl() { & kubectl --namespace=kube-system get secret --watch -o=json -l $args }
function kcgnowojsonl() { & kubectl get nodes --watch -o=json -l $args }
function kcgnswojsonl() { & kubectl get namespaces --watch -o=json -l $args }
function kcgslwl() { & kubectl get --show-labels --watch -l $args }
function kcsysgslwl() { & kubectl --namespace=kube-system get --show-labels --watch -l $args }
function kcgposlwl() { & kubectl get pods --show-labels --watch -l $args }
function kcsysgposlwl() { & kubectl --namespace=kube-system get pods --show-labels --watch -l $args }
function kcgdepslwl() { & kubectl get deployment --show-labels --watch -l $args }
function kcsysgdepslwl() { & kubectl --namespace=kube-system get deployment --show-labels --watch -l $args }
function kcgwsll() { & kubectl get --watch --show-labels -l $args }
function kcsysgwsll() { & kubectl --namespace=kube-system get --watch --show-labels -l $args }
function kcgpowsll() { & kubectl get pods --watch --show-labels -l $args }
function kcsysgpowsll() { & kubectl --namespace=kube-system get pods --watch --show-labels -l $args }
function kcgdepwsll() { & kubectl get deployment --watch --show-labels -l $args }
function kcsysgdepwsll() { & kubectl --namespace=kube-system get deployment --watch --show-labels -l $args }
function kcgslwowidel() { & kubectl get --show-labels --watch -o=wide -l $args }
function kcsysgslwowidel() { & kubectl --namespace=kube-system get --show-labels --watch -o=wide -l $args }
function kcgposlwowidel() { & kubectl get pods --show-labels --watch -o=wide -l $args }
function kcsysgposlwowidel() { & kubectl --namespace=kube-system get pods --show-labels --watch -o=wide -l $args }
function kcgdepslwowidel() { & kubectl get deployment --show-labels --watch -o=wide -l $args }
function kcsysgdepslwowidel() { & kubectl --namespace=kube-system get deployment --show-labels --watch -o=wide -l $args }
function kcgwowidesll() { & kubectl get --watch -o=wide --show-labels -l $args }
function kcsysgwowidesll() { & kubectl --namespace=kube-system get --watch -o=wide --show-labels -l $args }
function kcgpowowidesll() { & kubectl get pods --watch -o=wide --show-labels -l $args }
function kcsysgpowowidesll() { & kubectl --namespace=kube-system get pods --watch -o=wide --show-labels -l $args }
function kcgdepwowidesll() { & kubectl get deployment --watch -o=wide --show-labels -l $args }
function kcsysgdepwowidesll() { & kubectl --namespace=kube-system get deployment --watch -o=wide --show-labels -l $args }
function kcgwslowidel() { & kubectl get --watch --show-labels -o=wide -l $args }
function kcsysgwslowidel() { & kubectl --namespace=kube-system get --watch --show-labels -o=wide -l $args }
function kcgpowslowidel() { & kubectl get pods --watch --show-labels -o=wide -l $args }
function kcsysgpowslowidel() { & kubectl --namespace=kube-system get pods --watch --show-labels -o=wide -l $args }
function kcgdepwslowidel() { & kubectl get deployment --watch --show-labels -o=wide -l $args }
function kcsysgdepwslowidel() { & kubectl --namespace=kube-system get deployment --watch --show-labels -o=wide -l $args }
function kcexn() { & kubectl exec -i -t --namespace $args }
function kclon() { & kubectl logs -f --namespace $args }
function kcpfn() { & kubectl port-forward --namespace $args }
function kcgn() { & kubectl get --namespace $args }
function kcdn() { & kubectl describe --namespace $args }
function kcrmn() { & kubectl delete --namespace $args }
function kcgpon() { & kubectl get pods --namespace $args }
function kcdpon() { & kubectl describe pods --namespace $args }
function kcrmpon() { & kubectl delete pods --namespace $args }
function kcgdepn() { & kubectl get deployment --namespace $args }
function kcddepn() { & kubectl describe deployment --namespace $args }
function kcrmdepn() { & kubectl delete deployment --namespace $args }
function kcgsvcn() { & kubectl get service --namespace $args }
function kcdsvcn() { & kubectl describe service --namespace $args }
function kcrmsvcn() { & kubectl delete service --namespace $args }
function kcgingn() { & kubectl get ingress --namespace $args }
function kcdingn() { & kubectl describe ingress --namespace $args }
function kcrmingn() { & kubectl delete ingress --namespace $args }
function kcgcmn() { & kubectl get configmap --namespace $args }
function kcdcmn() { & kubectl describe configmap --namespace $args }
function kcrmcmn() { & kubectl delete configmap --namespace $args }
function kcgsecn() { & kubectl get secret --namespace $args }
function kcdsecn() { & kubectl describe secret --namespace $args }
function kcrmsecn() { & kubectl delete secret --namespace $args }
function kcgoyamln() { & kubectl get -o=yaml --namespace $args }
function kcgpooyamln() { & kubectl get pods -o=yaml --namespace $args }
function kcgdepoyamln() { & kubectl get deployment -o=yaml --namespace $args }
function kcgsvcoyamln() { & kubectl get service -o=yaml --namespace $args }
function kcgingoyamln() { & kubectl get ingress -o=yaml --namespace $args }
function kcgcmoyamln() { & kubectl get configmap -o=yaml --namespace $args }
function kcgsecoyamln() { & kubectl get secret -o=yaml --namespace $args }
function kcgowiden() { & kubectl get -o=wide --namespace $args }
function kcgpoowiden() { & kubectl get pods -o=wide --namespace $args }
function kcgdepowiden() { & kubectl get deployment -o=wide --namespace $args }
function kcgsvcowiden() { & kubectl get service -o=wide --namespace $args }
function kcgingowiden() { & kubectl get ingress -o=wide --namespace $args }
function kcgcmowiden() { & kubectl get configmap -o=wide --namespace $args }
function kcgsecowiden() { & kubectl get secret -o=wide --namespace $args }
function kcgojsonn() { & kubectl get -o=json --namespace $args }
function kcgpoojsonn() { & kubectl get pods -o=json --namespace $args }
function kcgdepojsonn() { & kubectl get deployment -o=json --namespace $args }
function kcgsvcojsonn() { & kubectl get service -o=json --namespace $args }
function kcgingojsonn() { & kubectl get ingress -o=json --namespace $args }
function kcgcmojsonn() { & kubectl get configmap -o=json --namespace $args }
function kcgsecojsonn() { & kubectl get secret -o=json --namespace $args }
function kcgsln() { & kubectl get --show-labels --namespace $args }
function kcgposln() { & kubectl get pods --show-labels --namespace $args }
function kcgdepsln() { & kubectl get deployment --show-labels --namespace $args }
function kcgwn() { & kubectl get --watch --namespace $args }
function kcgpown() { & kubectl get pods --watch --namespace $args }
function kcgdepwn() { & kubectl get deployment --watch --namespace $args }
function kcgsvcwn() { & kubectl get service --watch --namespace $args }
function kcgingwn() { & kubectl get ingress --watch --namespace $args }
function kcgcmwn() { & kubectl get configmap --watch --namespace $args }
function kcgsecwn() { & kubectl get secret --watch --namespace $args }
function kcgwoyamln() { & kubectl get --watch -o=yaml --namespace $args }
function kcgpowoyamln() { & kubectl get pods --watch -o=yaml --namespace $args }
function kcgdepwoyamln() { & kubectl get deployment --watch -o=yaml --namespace $args }
function kcgsvcwoyamln() { & kubectl get service --watch -o=yaml --namespace $args }
function kcgingwoyamln() { & kubectl get ingress --watch -o=yaml --namespace $args }
function kcgcmwoyamln() { & kubectl get configmap --watch -o=yaml --namespace $args }
function kcgsecwoyamln() { & kubectl get secret --watch -o=yaml --namespace $args }
function kcgowidesln() { & kubectl get -o=wide --show-labels --namespace $args }
function kcgpoowidesln() { & kubectl get pods -o=wide --show-labels --namespace $args }
function kcgdepowidesln() { & kubectl get deployment -o=wide --show-labels --namespace $args }
function kcgslowiden() { & kubectl get --show-labels -o=wide --namespace $args }
function kcgposlowiden() { & kubectl get pods --show-labels -o=wide --namespace $args }
function kcgdepslowiden() { & kubectl get deployment --show-labels -o=wide --namespace $args }
function kcgwowiden() { & kubectl get --watch -o=wide --namespace $args }
function kcgpowowiden() { & kubectl get pods --watch -o=wide --namespace $args }
function kcgdepwowiden() { & kubectl get deployment --watch -o=wide --namespace $args }
function kcgsvcwowiden() { & kubectl get service --watch -o=wide --namespace $args }
function kcgingwowiden() { & kubectl get ingress --watch -o=wide --namespace $args }
function kcgcmwowiden() { & kubectl get configmap --watch -o=wide --namespace $args }
function kcgsecwowiden() { & kubectl get secret --watch -o=wide --namespace $args }
function kcgwojsonn() { & kubectl get --watch -o=json --namespace $args }
function kcgpowojsonn() { & kubectl get pods --watch -o=json --namespace $args }
function kcgdepwojsonn() { & kubectl get deployment --watch -o=json --namespace $args }
function kcgsvcwojsonn() { & kubectl get service --watch -o=json --namespace $args }
function kcgingwojsonn() { & kubectl get ingress --watch -o=json --namespace $args }
function kcgcmwojsonn() { & kubectl get configmap --watch -o=json --namespace $args }
function kcgsecwojsonn() { & kubectl get secret --watch -o=json --namespace $args }
function kcgslwn() { & kubectl get --show-labels --watch --namespace $args }
function kcgposlwn() { & kubectl get pods --show-labels --watch --namespace $args }
function kcgdepslwn() { & kubectl get deployment --show-labels --watch --namespace $args }
function kcgwsln() { & kubectl get --watch --show-labels --namespace $args }
function kcgpowsln() { & kubectl get pods --watch --show-labels --namespace $args }
function kcgdepwsln() { & kubectl get deployment --watch --show-labels --namespace $args }
function kcgslwowiden() { & kubectl get --show-labels --watch -o=wide --namespace $args }
function kcgposlwowiden() { & kubectl get pods --show-labels --watch -o=wide --namespace $args }
function kcgdepslwowiden() { & kubectl get deployment --show-labels --watch -o=wide --namespace $args }
function kcgwowidesln() { & kubectl get --watch -o=wide --show-labels --namespace $args }
function kcgpowowidesln() { & kubectl get pods --watch -o=wide --show-labels --namespace $args }
function kcgdepwowidesln() { & kubectl get deployment --watch -o=wide --show-labels --namespace $args }
function kcgwslowiden() { & kubectl get --watch --show-labels -o=wide --namespace $args }
function kcgpowslowiden() { & kubectl get pods --watch --show-labels -o=wide --namespace $args }
function kcgdepwslowiden() { & kubectl get deployment --watch --show-labels -o=wide --namespace $args }

# e.g. kc create deploy nginx --image=nginx doy
function doy { --dry-run=client -o=yaml } 
# e.g. kc delete pod x now
function now { --force --grace-period 0 }

Set-Location ~/Workspace
Clear-Host
