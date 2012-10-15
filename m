From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Panu Matilainen <pmatilai@laiskiainen.org>
CC: "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "Ware, Ryan R"
	<ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: RE: First attempt for the patch on extending the plugin interface
 for rpm
Date: Mon, 15 Oct 2012 12:18:32 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B1944C1BE@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
 <5073D8D8.2010602@laiskiainen.org>
 <2236FBA76BA1254E88B949DDB74E612B1944A502@IRSMSX102.ger.corp.intel.com>
 <5075845F.9020102@laiskiainen.org>
In-Reply-To: <5075845F.9020102@laiskiainen.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0005_01CDAAE8.56223770"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_NextPart_000_0005_01CDAAE8.56223770
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

After reading your responses I think we indeed need to break this patch into
at least two or three parts. It would help us to concentrate on one set of
the hooks at the time and integrate them separately in steps.
You mentioned that pre/post tsm/psm hooks are pretty much fine, so we can
start from them. I would propose to add to them a security plugin loading
function and macros. Also, if there are no objections I would add here a
ScriptSetup hook (it is rather simple one and outside of other hooks). This
can be the first bunch that we can bring into shape to be acceptable for
merge. 
Then after the above is hopefully merged I will start attacking the
file-related hooks (I have already made a number of changes and will look
into improving them further based on your comments). And at the end we can
talk about how to integrate the rest.

I will post the first bunch shortly if there are no objections. 
 
Further comments are inline: 

>Actually, the ability to sanely disable these things from cli and API is in
practise a hard requirement. The reason is that rpm is used in a large
variety of situations beyond the basic "system package management" 
>task: creation of chroot (build-)environments that are nothing like what
the system might be running, install/live images, certain per-user tasks,
workarounds for weird setups etc. Plus all the things we never even imagined
- by now I hope to have learned (the hard way) that no matter how unlikely
it >seems, the unforeseen oddball (yet legal) cases always exist :)

>I do realize that needs on an embedded / handheld systems can be
drastically different from  a general purpose system. How to support "full
lockdown" where needed but allow disabling for other uses is something to
think about.

Hm.. This isn't easy indeed. Can we make a security plugin a special case
regarding to the cli? Meaning that if the rpm is compiled with
"ENFORCE_SECURITY", then it isn't possible to disable the security plugin
from cli and if loading/expanding of security plugin fails, then rpm stops.
Providing cli or API option to disable additional security enforced by the
plugin(s) even if security have been compiled in sounds scary for me....

>What I was thinking was more in the direction of "if plugin X returned
failure, should we even call the other hooks" (such as falling back to
something else if one of the involved filesystem doesn't support feature Y),
but this is now something that neither the plugin or rpm has any way of
actually knowing. 
>The point perhaps being, the exact semantics for the plugin hooks needs to
be far more clearly defined sooner or later.

I think even if plugin X returns failure on hook Z, we need to call the hook
Z for all other plugins, because this will make sure that all plugins have
the same set of hooks that got executed during the rpm transaction. Also, it
would be up to each plugin to be prepared that rpm transaction can stop and
fail outside of the plugin (inside rpm itself or inside of other plugins)
and then be ready that only cleanup hook is called. So, for example, plugin
might have pre tsm/psm hooks called and they go fine, but then some other
plugin returns a failure on prepsm hook, so whole transaction goes to
failure and plugin gets cleanup hook called even if from its point of view
everything went fine. 

>FWIW, I've been considering exporting the fd digest API for quite some 
>time. That stuff probably needs a bit of polishing/sanitizing before 
>exporting, but I'm not at all opposed to doing it.

Yes, I think this would be good and then it can be cleaner from plugin side
to get digest calculated. 

>For now, go for the absolute minimum exposure of rpm "objects". The 
>problem here is different from the other internals (such as fsm in the 
>previous versions) exposure, the issue here is that it exposes a ad-hoc 
>set of things that rpm currently happens to internally use to handle 
>this stuff. Which is not entirely unlike Lucas Arts adventure games of 
>old: you have a rope, two bananas and a fish, and you need to somehow 
>use those to cross the ravine to get the umbrella from the other side 
>that you need to... :)

>The fact that the hook breaks in rpm >= 4.10 despite arguments remaining 
>the same kinda underlines the issue. Rpm internals are going through 
>some pretty fundamental changes at the moment, and this is one of the 
>places that will hopefully become saner when its all done (my wishful 
>thinking is to have at least the basics around in rpm 4.11 already). 
>When that happens we can export more, but right now its better to keep 
>things to minimum you can get by with.

Agree, I will take a stronger attempt to reduce the arguments to the actual
needed once 
for all the file hooks. I guess the conflict one is the most heavy one at
the moment, so 
I will try to address it properly next time I post the patch for file hooks.


>The signature verification hook is another place where some weird 
>internal bits and pieces get passed around. That might be unavoidable, 
>dunno... but then (and I think I've said this before), signature 
>enforcing mechanism should really be in rpm core (and is sorely missed 
>currently). Plugins might further enhance / implement policy around 
>that, or something. Oh and I know this is hand-wavy and vague :-/

Yes, I think it would be good to think more on this. I understood how you
would like
 to have it now and agree that this would be an ideal case. I will put this
on my todo list
to see how this can be done in a better way. 

>What I referred to above is specifically the file conflict resolution 
>thing (and our previous discussion about that). Eg looking at the MSM 
>plugin, AFAICT it can let conflicts pass at this point, yet deny it deep 
>down from inside when the transaction is already in progress. There 
>always will be cases where a failure cannot be detected before actually 
>trying to install (ie, in fsm), but that should be the absolute last 
>resort, not something you'd ever see in "normal" operation.

Sure, I guess this problem is about the actual hook content, not necessary
the hook itself. I guess the hook should be redone to not simply log the
conflict case and decide on it later, but actually decide before starting a
transaction. 
I am quite sure I can change it in the plugin itself. 

Best Regards,
Elena. 


------=_NextPart_000_0005_01CDAAE8.56223770
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIYcDCCAyAw
ggKJoAMCAQICBDXe9M8wDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0Vx
dWlmYXgxLTArBgNVBAsTJEVxdWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw05
ODA4MjIxNjQxNTFaFw0xODA4MjIxNjQxNTFaME4xCzAJBgNVBAYTAlVTMRAwDgYDVQQKEwdFcXVp
ZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3VyZSBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJ
KoZIhvcNAQEBBQADgY0AMIGJAoGBAMFdsVhnCGLuoJotHwhtkRRomAoe/toEbxOEYiHD0XzOnwXg
uAHwTjTs4oqVBGSs8WtTXwWzy2eAv0ICjv7dAQns4QAUT/z78AzdQ7pbK+EfgHCZFVeTFvEPl2q3
wmgjHMxNWTCsUR47ryvW7mNFe8XZX1DS41APOojnvxT94Me5AgMBAAGjggEJMIIBBTBwBgNVHR8E
aTBnMGWgY6BhpF8wXTELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx
dWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTENMAsGA1UEAxMEQ1JMMTAaBgNVHRAE
EzARgQ8yMDE4MDgyMjE2NDE1MVowCwYDVR0PBAQDAgEGMB8GA1UdIwQYMBaAFEjmaPkr0rKV10fY
IyAQTzOYkJ/UMB0GA1UdDgQWBBRI5mj5K9KylddH2CMgEE8zmJCf1DAMBgNVHRMEBTADAQH/MBoG
CSqGSIb2fQdBAAQNMAsbBVYzLjBjAwIGwDANBgkqhkiG9w0BAQUFAAOBgQBYzinq/Pfetc4CuRe1
hdG54+CVzCUxDQCmkm5/tpJjnlCV0Zpv5BHeY4VumO6o/1rI01WyZnFX3sAh6z0qpyNJAQSGQnv8
7n+iFlK1Z2fTQNs7JliyKHc9rhR3Ydb6KmYnoA36p3Nc6nDxlCFlRF/6/O8paKmih3nvee9PrAd3
ODCCAz0wggKmoAMCAQICAwWw/zANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJVUzEQMA4GA1UE
ChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
MB4XDTA2MDIxNjE4MDEzMFoXDTE2MDIxOTE4MDEzMFowUjELMAkGA1UEBhMCVVMxGjAYBgNVBAoT
EUludGVsIENvcnBvcmF0aW9uMScwJQYDVQQDEx5JbnRlbCBFeHRlcm5hbCBCYXNpYyBQb2xpY3kg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBpd/XOb9QVqEZ8mQ1042TdOIq3ATD
IsV2xDyt30yLyMR5Wjtus0bn3B+he89BiNO/LP6+rFzEwlD55PlX+HLGIKeNNG97dqyc30FElEUj
ZzTZFq2N4e3kVJ/XAEEgANzV8v9qp7qWwxugPgfc3z9BkYot+CifozexHLb/hEZj+yISCU61kRZv
uSQ0E11yYL4dRgcglJeaHo3oX57rvIckaLsYV5/1Aj+R8DM1Ppk965XQAKsHfnyT7C4S50T4lVn4
lz36wOdNZn/zegG1zp41lnoTFfT4KuKVJH5x7YD1p6KbgJCKLovnujGuohquBNfdXKpZkvz6pGv+
iC1HawJdAgMBAAGjgaAwgZ0wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQaxgxKxEdvqNutK/D0
Vgaj7TdUDDA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmdlb3RydXN0LmNvbS9jcmxzL3Nl
Y3VyZWNhLmNybDAfBgNVHSMEGDAWgBRI5mj5K9KylddH2CMgEE8zmJCf1DAPBgNVHRMBAf8EBTAD
AQH/MA0GCSqGSIb3DQEBBQUAA4GBABMQOK2kVKVIlUWwLTdywJ+e2O+PC/uQltK2F3lRyrPfBn69
tOkIP4SgDJOfsxyobIrPLe75kBLw+Dom13OBDp/EMZJZ1CglQfVV8co9mT3aZMjSGGQiMgkJLR3j
Mfr900fXZKj5XeqCJ+JP0mEhJGEdVCY+FFlksJjV86fDrq1QMIIFijCCBHKgAwIBAgIKYSCKYgAA
AAAACDANBgkqhkiG9w0BAQUFADBSMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9y
YXRpb24xJzAlBgNVBAMTHkludGVsIEV4dGVybmFsIEJhc2ljIFBvbGljeSBDQTAeFw0wOTA1MTUx
OTI3MjZaFw0xNTA1MTUxOTM3MjZaMFYxCzAJBgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jw
b3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQjCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKQEM1Wn9TU9vc9C+/Tc7KB+eiYElmrcEWE32WUd
HvWG+IcQHVQsikTmMyKKojNLw2B5s6Iekc8ivDo/wCfjZzX9JyftMnc+AArc0la87Olybzm8K9jX
EfTBvTnUSFSiI9ZYefITdiUgqlAFuljFZEHYKYtLuhrRacpmQfP4mV63NKdc2bT804HRf6YptZFa
4k6YN94zlrGNrBuQQ74WFzz/jLBusbUpEkro6Mu/ZYFOFWQrV9lBhF9Ruk8yN+3N6n9fUo/qBigi
F2kEn9xVh1ykl7SCGL2jBUkXx4qgV27a6Si8lRRdgrHGtN/HWnSWlLXTH5l575H4Lq++77OFv38C
AwEAAaOCAlwwggJYMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFA7GKvdZsggQkCVvw939imYx
MCvFMAsGA1UdDwQEAwIBhjASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQ5oFY2
ekKQ/5Ktim+VdMeSWb4QWTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAfBgNVHSMEGDAWgBQa
xgxKxEdvqNutK/D0Vgaj7TdUDDCBvQYDVR0fBIG1MIGyMIGvoIGsoIGphk5odHRwOi8vd3d3Lmlu
dGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBQb2xpY3kl
MjBDQS5jcmyGV2h0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0lu
dGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNybDCB4wYIKwYBBQUHAQEEgdYw
gdMwYwYIKwYBBQUHMAKGV2h0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNh
dGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNydDBsBggrBgEFBQcw
AoZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwUG9saWN5JTIwQ0EuY3J0MA0GCSqGSIb3DQEBBQUA
A4IBAQCxtQEHchVQhXyjEqtMVUMe6gkmPsIczHxSeqNbo9dsD+6xbT65JT+oYgpIAtfEsYXeUJu1
cChqpb22U5bMAz7eaQcW5bzefufWvA6lg2048B8oczBj/q+5P5NpYrUO8jOmN4jTjfJq3ElZ7yFW
py7rB3Vm/aN6ATYqWfMbS/xfh+JCxmH3droUmMJI0/aZJHsLtjbjFnNsHDNrJZX1vxlM78Lb1hjs
kTENPmhbVbfTj5i/ZGnhv4tmI8QZPCNtcegXJrfhRl2D9bWpdTOPrWiLDUqzy1Z6KL7TcOS/PCl8
RHCJXkPau/thTQCpIoDa2+c+3XA++gRTfAQ4svTO260NMIIGFzCCBP+gAwIBAgIKFK5E0wABAABw
3zANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRp
b24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgM0IwHhcNMTEwNjIy
MDc0NTU3WhcNMTQwNjA2MDc0NTU3WjBFMRkwFwYDVQQDExBSZXNoZXRvdmEsIEVsZW5hMSgwJgYJ
KoZIhvcNAQkBFhllbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkJBksYl07CDjgHAP6wh1fGfcyo781oAHbErHy7PTDenky7LA1Eh/xFEGSWGT
CgkDw0zIn6ks/P5eFFU/vAkHe0mbMt7vyV9naFDjzbaGXNxob4wHZ7gi1kLSKTUKJ65QDPemIMIl
HL9QUQNAUx/YGLcbJzEc14Oy3e5JFBq9MF3y+PnZNbKHZUHcbET7MTxfyIYCfpZkb7M5qn3w9k4h
V7JRB+9yjYU9YtSzU1Ta3o8qpvr8R5lEnfkX8vuO4UXj6L58Zkh4g6ziOHNp4r7L7LVGU+Wzl2rW
EX5vIeQdAtobnETi8/5MtAM7mE2wP8MN/h53kCZ2DKYDjsMFo36zYwIDAQABo4IC9jCCAvIwCwYD
VR0PBAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJ
Z4HevTmV8EMCAWQCAQgwHQYDVR0OBBYEFJuyxFahPWHR2D/W/zaCv7xOGAKuMB8GA1UdIwQYMBaA
FA7GKvdZsggQkCVvw939imYxMCvFMIHPBgNVHR8EgccwgcQwgcGggb6ggbuGV2h0dHA6Ly93d3cu
aW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3Vp
bmclMjBDQSUyMDNCKDEpLmNybIZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3Np
dG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0IoMSku
Y3JsMIH1BggrBgEFBQcBAQSB6DCB5TBsBggrBgEFBQcwAoZgaHR0cDovL3d3dy5pbnRlbC5jb20v
cmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwM0IoMSkuY3J0MHUGCCsGAQUFBzAChmlodHRwOi8vY2VydGlmaWNhdGVzLmludGVs
LmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJ
c3N1aW5nJTIwQ0ElMjAzQigxKS5jcnQwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwww
KQYJKwYBBAGCNxUKBBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMME8GA1UdEQRIMEagKQYK
KwYBBAGCNxQCA6AbDBllbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tgRllbGVuYS5yZXNoZXRvdmFA
aW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCS9KPzLdkyXSfW4t23uCaLiX3KDGl1hLtJeArD
BH8DP3sQXzgCIl7ThVjLOZALz5dkuSVkbnN+zrsTsVzKeJMgjOAkkRbOISPE/OxCi/m8jWGW5STb
tvpmZxReDRWBdlBMM+CBA+6PZivDPEAOeXIy5E5rlh6hvpXSLrllbDVmvF3MvsxKdoa5AKaCJ+Kd
mCQkmS+zuzcoRnZs1jMc1/Sj6GEHhCoCNxxaey7WXTv2o3FNZgp/ey2aocpSQdYmNCl51BRACc7k
xZEPU7/yDYgBgmD+yq6SrDWWO4/3EA40s4NeG7P3uMUFK0c8U00gGAch5mXO76laZ7dQtvfqhC4F
MIIGXjCCBUagAwIBAgIKFK2UbgABAABw3jANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEa
MBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2lj
IElzc3VpbmcgQ0EgM0IwHhcNMTEwNjIyMDc0NTEwWhcNMTQwNjA2MDc0NTEwWjBFMRkwFwYDVQQD
ExBSZXNoZXRvdmEsIEVsZW5hMSgwJgYJKoZIhvcNAQkBFhllbGVuYS5yZXNoZXRvdmFAaW50ZWwu
Y29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1J1LJZazMfHPPgGKE7jqHsih1UY
a1oR82+Mi+ZOlgAnRG71m/pn8nvwjDDHclvFnrsTHVzpym24AxqZs86GQ7qLfx95opPji90dbhRO
82glMVJt0zzVl7RnmB0nRpumK/NWija7/gO95TyrdpYlujGCiuISNKI9tPa7ZWVjvUsaKqeZU0gO
3eiP8NdRHzGKNSw2q2SMpt32sgmUquS1Rnb43JOKsaa0v/hhuhDjFLSIoURJQ75eiH4hm+gKKq6G
ygGXYDTA3O2WIAyAZjv0jJ3kqAq1BiTWu+NjptGmCYMMyyRtkEyesbkLH5nS/fV+VWG5ATJnwHea
qXZtF9O9CQIDAQABo4IDPTCCAzkwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQB
gjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgEMMEQGCSqGSIb3DQEJDwQ3MDUw
DgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNV
HQ4EFgQUdgb4/btn47AP1ZPTlBKvHCCQxWEwHwYDVR0jBBgwFoAUDsYq91myCBCQJW/D3f2KZjEw
K8Uwgc8GA1UdHwSBxzCBxDCBwaCBvqCBu4ZXaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0IoMSkuY3Js
hmBodHRwOi8vY2VydGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4
dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcmwwgfUGCCsGAQUFBwEBBIHo
MIHlMGwGCCsGAQUFBzAChmBodHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmlj
YXRlcy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcnQw
dQYIKwYBBQUHMAKGaWh0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2Vy
dGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDNCKDEp
LmNydDAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoG
CCsGAQUFBwMEMAwGCisGAQQBgjcKAwQwTwYDVR0RBEgwRqApBgorBgEEAYI3FAIDoBsMGWVsZW5h
LnJlc2hldG92YUBpbnRlbC5jb22BGWVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20wDQYJKoZIhvcN
AQEFBQADggEBAErbqIMGr07dFTHfcifpkF3yklZqYlSi3kJVQLcef8e6SEyurN+9wBZbheJEo/lg
N53Hjmt9hyLHjnsHNQQ1XIGV3SIO0nS6Vf0scWhUyI95cLxDw1zsbNJdRtcF9HgeqDeio8jXuA+c
9HUXIxClFsVwa9w9504bElE8IHGdq+AwAziUZEZaV6v9IaEefZWDO7onthD1Ff1ZyIfc6fnhVmIZ
1hUUty5xfeBXmnulvDEiHNpUnz8XjUF+K4kYQs0hMEwNHjf3wArRDYjbomysBnkrAIZgZGw2S4uU
uLeIu5H0kuLCP5808v8UPke1oCp5v2T91unfvm+IXDSMUXnqLLUxggOGMIIDggIBATBkMFYxCzAJ
BgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0
ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK5E0wABAABw3zAJBgUrDgMCGgUAoIIB9zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjEwMTUxMjE4MzFaMCMGCSqG
SIb3DQEJBDEWBBSlfsVpnnBQEtZ/zvLwfrCHYcPomTBzBgkrBgEEAYI3EAQxZjBkMFYxCzAJBgNV
BAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJu
YWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK2UbgABAABw3jB1BgsqhkiG9w0BCRACCzFmoGQwVjEL
MAkGA1UEBhMCVVMxGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBF
eHRlcm5hbCBCYXNpYyBJc3N1aW5nIENBIDNCAgoUrZRuAAEAAHDeMIGrBgkqhkiG9w0BCQ8xgZ0w
gZowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYI
KoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBADxdBPWYDBYASnvb4Y7ntVy3Bx0uot7ZdrXeHt1G0VlQbWhqdyZY1MWBCe3sEI0VIhCL8BPS
NBzRee+wlfXSjQ9fgkjbDHgxlUCtzbM1gqAVGk02edjpW0+Etc1IcG955gWa4SuD/eKRTo38skaY
eiaL9ylTp/IWzYeidVA0chMkbuofAUmXcPCz/TolJ3vF7OcbdaQj4N7gMJ4Sw9f7APJ5ORt/fpVc
gUfNl11qWJfdbkuL//1YDwypHxbD4MZxaLBqMzlI8ZONj4onL+7cufrTX7eMM0SaGTHULTzFgdIe
HbwFOOOY3m5qJLX/lvt2eecfW8ntbZ97MEJpeJ8w5uUAAAAAAAA=

------=_NextPart_000_0005_01CDAAE8.56223770--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
