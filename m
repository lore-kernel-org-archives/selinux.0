Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q99DrnP2017567
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2012 09:53:49 -0400
Received: from moss-pluto.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-pluto.epoch.ncsc.mil (8.14.5/8.14.5) with ESMTP id q99Dr0su015641
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2012 09:53:00 -0400
Received: (from sds@localhost)
	by moss-pluto.epoch.ncsc.mil (8.14.5/8.14.5/Submit) id q99Dr0BK015640
	for selinux@tycho.nsa.gov; Tue, 9 Oct 2012 09:53:00 -0400
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Panu Matilainen <pmatilai@laiskiainen.org>
CC: "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "Ware, Ryan R"
	<ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: RE: First attempt for the patch on extending the plugin interface
 for rpm
Date: Tue, 9 Oct 2012 12:26:29 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B1944A502@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
 <5073D8D8.2010602@laiskiainen.org>
In-Reply-To: <5073D8D8.2010602@laiskiainen.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0061_01CDA632.73B352C0"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_NextPart_000_0061_01CDA632.73B352C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Panu, 

Thank you for such fast reply given that you are so busy!
My comments are below. 

>Note that the existing hooks are by no means "sacred" for other than
documenting the needs of the SELinux collection. AFAIK the collections
aren't actually being used anywhere yet (its still marked experimental), and
the interfaces are internal-only so if there's something that needs/wants to
be changed, >they can be changed.

Sure, I was first planning to substitute the OpenTE hook with generic pre
transaction hook, 
but then I started to think that there is not enough reasons to touch the
collections hooks because they are making sense 
for collections and there is even a collection plugin defined as a special
plugin case. Also, the hooks that I try to introduce 
are not conflicting with collection hooks, so I didn't touch them so far. 

>Macros the means through which rpm is generally configured, and that kind
of approach should make it reasonably simple to allow selective
enabling/disabling of them from cli (annoying but inevitable necessity). 
>Might be more annoying for other API users - currently disabling SELinux is
a simple matter of setting RPMTRANS_FLAG_NOCONTEXTS flag for the
transaction, with plugins it would be something ... quite different.

Yes, it would be different and I think it is good not to allow to disable
the security plugin simply from command line for some transaction. This
would allow the distribution to specify and control what kind of rpm
plugins must be present.

>I think this was one of the prime reasons I had that look into the
"security manager" object thingie: to avoid having to pass the transaction
set to places where it really does not belong to.
>OTOH it would seem to me (most of) the places could simply be passed a
handle to the plugins instead of ts, as the ts is pretty much only used for
ts->plugins.

True, I think this is that I will do: it still requires adding the plugins
as parameter to functions, but avoids adding  ts_internal and ts itself. I
will change my patch. 

>...and this is related to what was one of the issues the "security manager"
thing ran into. Assuming there can be more than one present: 
>how to meaningfully deal with errors? Returning an error if one or more of
them failed is a simple answer, but whether that's sufficient for the
>callee(s) I dont know, I seem to recall some things wanting a better idea
of what failed and how (but that might well be just from staring too much at
the way things are currently done)

Currently I am just returning an error is any of the plugins have returned
an error. This is quite typical approach for security, when multi-layer
security modules are present. 
I think in this case it would be a responsibility of the plugin to indicate
why an error condition was returned. For MSM plugin an error with
explanation will be printed when smth fails due to plugin. 
It might not be the same thing as returning a concrete error, but there is
no way to generalize the errors for different types of plugins (even
security) that it actually makes much more sense. 

> +
> +        /* Run file updated hook for all plugins */
> +        rc = rpmpluginsCallFileUpdated(ts->plugins, fsm->path, 
> + fsm->buf,
> len);

>Hmm. Looking at the MSM plugin (from
>git://github.com/ereshetova/rpm.git), this is primarily used for
calculating yet another digest for the file being processed. This should be
avoidable, the rpmio FD_t type supports calculating more than one on the
digest on the fly, only the interfaces to use it are currently buried in
rpmio/rpmio_internal.h >(but not actually hidden from ABI).

Yes, it can be used to calculate any digest or hash for the file to be
installed and then used for example to calculate the RSA signature over the
hash and write it to the xattrs for IMA. I will take a look if I can redo
this part with the interface you mentioned. 


>   		    rc = fsmSetSELabel(sehandle, dn, mode);
> -
> +                    if (!rc)
> +                        rc = rpmpluginsCallDirCreated(ts->plugins, 
> + dn,
> mode);

>This is a pretty ugly special case hack :) Part of the reason for
>fsmSetSELabel() was to isolate the whole labeling thing into something
fairly generic that could be as well in a plugin. So this should be more of
a "post file/dir-creation hook" I think . Also access to such a thing (or a
way to avoid the need there completely...) would be needed in
>rpmdbMoveDatabase() too.

Yes, special case hack indeed :) Actually I was thinking of simply calling
the FILE_CLOSED hook (and maybe renaming it to smth better in this case) at
this point, but then I guess I would need to add a special argument to
indicate that this was for dir that wasn't included in the package (it is
important to distinguish this for security reasons since you would likely
label such directory in a different way). I will address this in the next
patch version, too. 


>   	if (xx == 0) {
> -	    xx = execv(argv[0], argv);
> +                /* Run script exec hook for all plugins */
> +                if (rpmpluginsCallScriptExec(ts->plugins, argv) !=
> RPMRC_FAIL) {
> +		        xx = execv(argv[0], argv);
> +                }

>Ah, this is one of the places where I remember pondering over with the
"security manager" experiment: my idea was to bury the execv() call itself
into the manager so it could be execv(), rpm_execcon() or whatever depending
on the manager type/what's loaded, but that didn't fly at all :) This seems
like a >much more feasible approach, but the hook name wants clarification
as the hook MUST NOT actually perform the exec, only setup any preliminaries
it wants for the exec (eg
>setexeccon() in case of selinux)

Yes, this is what I had in mind now when I wrote this patch. I have noticed
that actually executing the script in plugin won't be possible unless you
want your scripts to be executed n times :) The purpose of the hook now is
only to setup the security context. 
I will rename it in the next version to avoid confusion. 


> @@ -409,6 +411,9 @@ static void handleInstInstalledFile(const rpmts 
> ts, rpmte p, rpmfi fi, int fx,
>   	if (rpmtsFilterFlags(ts) & RPMPROB_FILTER_REPLACEOLDFILES)
>   	    rConflicts = 0;
>
> +        /* run file conflict hook for all plugins */
> +        rpmpluginsCallFileConflict(ts->plugins, ts, p, fi, otherFi,
> otherHeader);
> +

>This wont work in rpm >= 4.10 which no longer uses the rpmfi
"self-iterator" here - random access to the file info sets is needed and it
can even end up accessing the same file info set at two places
simultaneously (its possible for a package to have file conflicts within
itself via directory symlinks). So you'd >have to actually pass indexes for
both fi and otherFi, but then the indexed accessors to rpmfi aren't exported
in the API currently and...

Ok, sorry that I have missed this from the latest release. I will take a
look on this and try to think what can be done. As minimum we would need
just to know the path of conflicting file and previous package name that
have installed this file. 

>Overall I'm still not really comfortable of letting plugins mess around
with such a core functionality of rpm (I do remember the previous discussion
around this though)

In previous discussion you have mentioned that plugins should not get any
rpm internal data structs when it can be avoided (like fsm and etc.) and I
have tried to address this. I am also willing to work further on this unless
it becomes acceptable for upstream. The actual reason why a security plugin
needs all these hooks is to get enough control over the installation
process. 
Like being able to control if a certain file can be substituted from another
package or if a certain package signed with a certain key should get
installed and obtain all requested resources. It is very hard to address any
of these things through rpm itself without starting to ugly strip and add
the code here and there or arrange a bunch of ifdefs. And this of course
makes the maintenance of rpm for a distribution with strict security
requirements a nightmare :( 

I understand that for the PC world with root given to the user these things
aren't really that needed.  But then you take a look on cases in mobile or
IVI (In-vehicle-infotainment), they are not only applicable, but required by
operators, car manufacturers and even safety requirements. How do we prevent
a user from installing a new cool release of Angry Birds (that just happens
to be malicious) that actually substitutes some of our system binaries,
makes the car to lose the reversing back video stream and makes the user to
reverse over the neighbour's dog? Maybe a bit too harsh example, but with
modern systems it might be possible soon unless we put proper security
mechanisms in place :(

Best Regards,
Elena.

------=_NextPart_000_0061_01CDA632.73B352C0
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjEwMDkxMjI2MjhaMCMGCSqG
SIb3DQEJBDEWBBSfop7SgPwVasSkk7dMnyADPh7UfDBzBgkrBgEEAYI3EAQxZjBkMFYxCzAJBgNV
BAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJu
YWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK2UbgABAABw3jB1BgsqhkiG9w0BCRACCzFmoGQwVjEL
MAkGA1UEBhMCVVMxGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBF
eHRlcm5hbCBCYXNpYyBJc3N1aW5nIENBIDNCAgoUrZRuAAEAAHDeMIGrBgkqhkiG9w0BCQ8xgZ0w
gZowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYI
KoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBAH7/Xnh8gtST6e9Iojn86neLSMRDIvHdJHm8Rliw30HLyRTHw2Aon9lzW5LOvukWafzUs2pU
sGF/Mg6SOWJaMZstZXeLMFYmw/FbvH28VF8DwMrk5GswbvF9sR2Efp61C3U4b/CIKjsyKPN20EDO
ACw+0wC1HNbzseZAkliPstHloTwgA17us8NzFWkQUMO5zp/JbbR2rpzLHMkZaTX8DzRuRajCsfxK
mkrFXGWVqyJanW7Yj3Mi9Ku/OdTLB81XnojRze30g/8ZgnRa/13FqzOuxWj9nI5rGzrflyoemx4F
rv7tbLvHaliQ7nh/hMisaFwHPOQIgdEiWxdGN90rTsAAAAAAAAA=

------=_NextPart_000_0061_01CDA632.73B352C0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
