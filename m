From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Panu Matilainen <pmatilai@laiskiainen.org>,
        "tero.aho@nixu.com"
	<tero.aho@nixu.com>
CC: "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "Ware, Ryan R"
	<ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: RE: First attempt for the patch on extending the plugin interface
 for rpm
Date: Tue, 16 Oct 2012 16:31:02 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B1944CA4E@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
 <5073D8D8.2010602@laiskiainen.org>
 <2236FBA76BA1254E88B949DDB74E612B1944A502@IRSMSX102.ger.corp.intel.com>
 <5075845F.9020102@laiskiainen.org>
 <2236FBA76BA1254E88B949DDB74E612B1944C1BE@IRSMSX102.ger.corp.intel.com>
 <507D3F47.4090100@laiskiainen.org>
In-Reply-To: <507D3F47.4090100@laiskiainen.org>
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0031_01CDABD4.C5F1D870"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_NextPart_000_0031_01CDABD4.C5F1D870
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

>Obviously there needs to be some way of loading the plugins... What kinda 
>bothers me here is the notion of "security plugin" - except for perhaps the 
>signature/conflict hooks, there's nothing inherently security-specific here.

>The two immediate candidates *are* security-oriented, but they're very, very 
>different in what they do and how they affect the system. Eg if you disable 
>SELinux labeling on a system where SELinux is enabled, you'll pretty much 
>just shoot yourself in the foot (by ending up with a rather screwed up 
>system) >rather than fundametally bypass system security.
>"Transaction plugin" or something to that effect would seem to be more 
>appropriate as these hooks could be used for all sorts of purposes 
>(additional logging / interaction with other systems like dbus notifications 
>for somebody ... whatever).

Ok, let's call it indeed a "transaction plugin" because security plugin can be 
considered as a particular case of transaction plugin. I will rename it.

>The script setup hook is fairly obvious too, just forgot to mention it.
>The one question with that is (again) the argument(s) it receives:
>currently its ARGV_t, but does it actually need the entire argv or would just 
>the actual executable path suffice for the setup?

I am fine with just the path, but looking to SELinux code, the rpm_execcon() 
func needs the whole argv struct.

@ Stephen, do you know how mandatory for SELinux is to have the whole argv 
struct? Is it just because of rpm_execcon() API or?

>Another possibility might be passing an rpmScript "object" (which would need 
>exporting and probably added interfaces, but that's kinda in the plans anyway 
>at some point). But perhaps that's best left for later.

Yes, I guess there is always a possibility  to change these things when better 
objects/structs are available. I am quite sure I can make these changes later 
since I will be responsible for introducing these hooks at the first place :) 
I don't just plan to dump this on you once and go away!

>I dunno... There are soooo many different options and API flags that affect 
>these things, attempting to enforce things from the inside of rpm seems 
>hopelessly futile: practically every aspect of rpm's behavior is overridable 
>via cli, API and configuration. Including the paths where rpm loads its 
>configuration >from. You'd need to have a hard-wired list of mandatory 
>plugins and theirr non-macro paths compiled rpm to enforce anything at all. 
>And even then, if you have cli access as root, what's to prevent the user 
>from just replacing the executable/libraries with something that doesn't 
>enforce anything?

We can prevent user or malicious app from modifying the rpm itself, its 
plugins, configuration files by using the MAC (as selinux or smack) in 
run-time and integrity protection (as IMA/EVM) for offline protection. Using 
librpm directly by user or program actually should be quite safe, because user 
or malicious app won't get any powerful permissions in the most restrictive 
setup (no classical root, no posix capabilities). There normally would be some 
higher level package manager on top of rpm that would have needed permissions 
and would execute rpm (which would inherit the permissions in this case) with 
a proper set of cli arguments and environment. If everything goes well, then 
we don't need to worry that rpm would install smth without a plugin being run. 
But what if the system gets damaged somehow (not even necessary attacked) and 
plugin binary happen to disappear? In this case given that we are relying on 
additional checks for the plugin, it is a very bad idea to proceed without it. 
It would indeed make the whole system unsecure and in addition also unusable, 
and this is all even without user understanding that system got corrupted. So, 
this was the idea behind having this "plugin present" check and stop if failed 
in place.  I was looking at it as some kind of analogy to sysinit that can 
make checks during the boot process that needed services (example from 
security: device lock daemon) are up and if they aren't up, then it can stop 
the boot and actually go to some recovery mode.
Does this explanation makes a bit more sense?


>Yes, its indeed what the MSM hook does, rather than the hook itself, that 
>bothers me. And more generally, the fact that such things become possible 
>with plugins. I guess its not possible to really prevent, given sufficiently 
>powerful plugin interface, but if nothing else the interfaces should 
>encourage the >"correct" usage and discourage working behind rpms back. 
>Whatever that means - I do realize I'm just waving hands again :)

>> I am quite sure I can change it in the plugin itself.

>Ok, that'd be good. I was actually wondering why its done the way it is now - 
>if there is an actual reason (such insufficient information available at that 
>point), I'd like to understand it.

My understanding before was that in the current implementation you are able to 
skip the installation of conflicting files without failing the whole package, 
but now when I think of this it doesn't seem like a right thing to do.  I have 
"inherited" these hooks from Tero (in CC now) and while I have done quite some 
changes to them (some I actually still need to sync to open repo that you get 
to see them too), I haven't touched the conflict hook at all.

@Tero, do you still remember the reason why the conflict hook was done in this 
way? Why wasn't it better to check the conflicts before the transaction and 
fail the whole transaction if conflicts are seen?

Best Regards,
Elena.




------=_NextPart_000_0031_01CDABD4.C5F1D870
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjEwMTYxNjMxMDBaMCMGCSqG
SIb3DQEJBDEWBBQDTzhLZoqr4eAKnNkMHMbjV+iTqDBzBgkrBgEEAYI3EAQxZjBkMFYxCzAJBgNV
BAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJu
YWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK2UbgABAABw3jB1BgsqhkiG9w0BCRACCzFmoGQwVjEL
MAkGA1UEBhMCVVMxGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBF
eHRlcm5hbCBCYXNpYyBJc3N1aW5nIENBIDNCAgoUrZRuAAEAAHDeMIGrBgkqhkiG9w0BCQ8xgZ0w
gZowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYI
KoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBAGutYskdqOw5+SeE3FlbPwCY9q+VNaPhqd4CxPu8iQRb+gz2hxfIk7UGPJmTiq4U4CptTmfH
GfrmyHbV9r564LrMhQ7xlIW2qP4sDeecSMyrS1DaynopbIUGl9PY+KzeHXW1gh9pyYgT6v9ZZyF9
6hx/1kUy0JIKH42QMzgeqWvQMF9AUH5fU0s/HnQtghNk0EG/IeUoJBT8XZUWcK4c4gvGHu4uKJB2
TeGDDkUdB7x+dH3scQbjOUGx1RXyUM1CX5TJqGcPYC1KZ8zX//mILg7WZJQlp1pFijS/LPM4kfSH
Jf4ulQ+qdPX+HnOyI/qLIEr/901iGG5py/NU+gOkKQ8AAAAAAAA=

------=_NextPart_000_0031_01CDABD4.C5F1D870--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
