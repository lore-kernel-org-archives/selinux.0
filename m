Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r66KrftE014650
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2013 16:53:41 -0400
Received: by mail-gg0-f173.google.com with SMTP id k3so1140135ggn.4
        for <selinux@tycho.nsa.gov>; Sat, 06 Jul 2013 13:53:38 -0700 (PDT)
Content-Type: multipart/signed; boundary="Apple-Mail=_5F89C143-C9E8-4E50-820C-491C9331EDEC"; protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: Labeled IPSec trying to match policy for peer label?
From: Joe Nall <joe@nall.com>
In-Reply-To: <20130706192147.GA23809@siphos.be>
Date: Sat, 6 Jul 2013 15:53:31 -0500
Cc: Chad Hanson <dahchanson@gmail.com>, Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@tycho.nsa.gov>
Message-Id: <42AECD22-D169-4977-A6CB-334495C0F801@nall.com>
References: <20130705183902.GA26996@siphos.be> <2894544.bL1dEvHUlK@sifl> <20130706063952.GA29221@siphos.be> <CAPzO=NxsvuEjfd8G4MVzRu=s=N39JifP-Kr-zowvKxq4Tt+Sqw@mail.gmail.com> <CAOFCXec9Lox=mkSpzmkF+LCsFBWVcRfL3E8u5yM4nYBHveORNA@mail.gmail.com> <20130706192147.GA23809@siphos.be>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail=_5F89C143-C9E8-4E50-820C-491C9331EDEC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

We use transport instead of tunnel, but this is out of a working mls =
client configuration script:

CLEARANCE=3Ds15:c0.c1023
...
spdadd ${LOCAL_IP} ${REMOTE_IP} any -ctx 1 1 =
"system_u:object_r:ipsec_spd_t:s0-${CLEARANCE}" -P out ipsec =
esp/transport//require;
spdadd ${REMOTE_IP} ${LOCAL_IP} any -ctx 1 1 =
"system_u:object_r:ipsec_spd_t:s0-${CLEARANCE}" -P in  ipsec =
esp/transport//require;

The environment is RHEL 6.2 with racoon (not openswan). racoon.conf:
...
sainfo anonymous
{
    lifetime time 36 hours ;
    encryption_algorithm aes ;
    authentication_algorithm hmac_sha1 ;
    compression_algorithm deflate ;
}

remote anonymous
{
    dpd_delay 10;
    exchange_mode main,base;
    lifetime time 36 hours ;
    proposal {
        encryption_algorithm aes;
        hash_algorithm sha1;
        authentication_method pre_shared_key;
        dh_group 1;
    }
}
---
joe

On Jul 6, 2013, at 2:21 PM, Sven Vermeulen <sven.vermeulen@siphos.be> =
wrote:

> On Sat, Jul 06, 2013 at 11:40:46AM -0400, Chad Hanson wrote:
>> Are you running with MLS policy? I am curious since the last output
>> showed: system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023. I would expect
>> the following SPD context for MLS:
>> system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023.  If not using MLS,  =
you
>> would always fail in within_range()  at
>>=20
>> if (!mls_ready)    /*mls may not be enabled */
>>           return 0
>>=20
>> There should be a log message at the startup of racoon if MLS is
>> disabled. I didn't originally notice your original SPD context wasn't
>> ranged: system_u:object_r:ipsec_spd_t:s0. This typically would be
>> system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023 on a MLS system.
>=20
> I'm running an MLS-enabled policy (but its MCS, so only a single =
sensitivity
> level but multiple categories). I was thinking about the range as =
well, but
> that doesn't seem to help.
>=20
> Right now, my spdadd statements include the c0.c1023 range, and I'm =
trying
> to generate communication through both a s0:c0.c1023-ranged process as =
well as
> "just" s0 to see what happens. Still no luck.
>=20
> spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
>  "system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023" -P out ipsec
>  esp/tunnel/192.168.100.152-192.168.100.153/require;
>=20
> spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
>  "system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023" -P in ipsec
>  esp/tunnel/192.168.100.153-192.168.100.152/require;
>=20
> There is no logging related to MLS.
>=20
> I also changed SELinux from enforcing to permissive but that didn't =
change
> the behavior here. I'm going to start inserting the necessary print
> statements in the code to see when (and why) the association isn't set =
up.
>=20
> Wkr,
> 	Sven Vermeulen
>=20
> --
> This message was distributed to subscribers of the selinux mailing =
list.
> If you no longer wish to subscribe, send mail to =
majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--Apple-Mail=_5F89C143-C9E8-4E50-820C-491C9331EDEC
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUXTCCBK8w
ggOXoAMCAQICAwsdXTANBgkqhkiG9w0BAQUFADBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5T
LiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVN
QUlMIENBLTMwMB4XDTEyMDQxOTAwMDAwMFoXDTEzMTExNzIzNTk1OVowfjELMAkGA1UEBhMCVVMx
GDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxEzAR
BgNVBAsTCkNPTlRSQUNUT1IxJDAiBgNVBAMTG05BTEwuSk9TRVBILkQuSlIuMTI2NTA4MjA1NjCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK9UfTpN8DDS7gHdbjfZA+Y5L3sC5azXj8LA
XYkLeQSfluMGkmO2UiKhU0JqgOg4aL5+y7EVYMFsqlnXhV6rGXNyvw79zoM/NATbbkWhig8F+0SG
j91lGy+BhXkcgEp7ksv+uCrx21WfO7s70ezoZdFpmflibCboaM4Bh0E8+9U8//lA2CHEnA6IPOtw
RxzK/YGI0FCTUNP9evR8LOxz5paZpzthoRXERMn8kwBNBC1k8dvhE6gIzT8oSGeteJD+sxTPO9fi
jn40iZJ2rq6Y24ATSCIQ1VvCXd44shi7ivARDaJlwNwc1KGN5JAJoVjESUtEuxzLPv2ilCPzJCka
xbkCAwEAAaOCAVUwggFRMB8GA1UdIwQYMBaAFDVhZigJvFYlW4vMv4FeYSwwOdMhMDoGA1UdHwQz
MDEwL6AtoCuGKWh0dHA6Ly9jcmwuZGlzYS5taWwvY3JsL0RPREVNQUlMQ0FfMzAuY3JsMA4GA1Ud
DwEB/wQEAwIFIDAjBgNVHSAEHDAaMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxMwHQYDVR0OBBYE
FOMoRTDPWoa5YyqfdfOkdytpq/mIMGgGCCsGAQUFBwEBBFwwWjA2BggrBgEFBQcwAoYqaHR0cDov
L2NybC5kaXNhLm1pbC9zaWduL0RPREVNQUlMQ0FfMzAuY2VyMCAGCCsGAQUFBzABhhRodHRwOi8v
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
A1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAOYpItQUJtGYGlJexYSDc37BYLOz0JS+/RyUVb/2hCyb
ycB0c+/MwpnymcltyhTTdP++EPL3Lb/Luwaj7phQQWUB4VcstsvkyhysflI0DrGOByY+MjWvo2EK
xeUIthJ5jFTBeunxUB9dgzpnMLMp2x06TDkhUNgYLI0Gde5jcnhorWKcdaSUBtMyaxKvBgcpvhOg
wKfwJU+3/h+3V+AYEo0hahW5WlT7d2XYTD/1ujzAN+EGfsK+niOMKNGa18ZnONdzyb0HHYVv1ZUK
mtzaOk4o8KXrCd/l2wvNR6+KzbtvlEDjWZxQn8kOqXECudzpaYA6iTtFBSIYBYS1EvA8wIECAwEA
AaOCAhwwggIYMA4GA1UdDwEB/wQEAwIBhjAfBgNVHSMEGDAWgBRJdLsMXrp6/gJU73ugxpXGCYBw
ljAdBgNVHQ4EFgQUNWFmKAm8ViVbi8y/gV5hLDA50yEwEgYDVR0TAQH/BAgwBgEB/wIBADAMBgNV
HSQEBTADgAEAMGYGA1UdIARfMF0wCwYJYIZIAWUCAQsFMAsGCWCGSAFlAgELCTALBglghkgBZQIB
CxEwCwYJYIZIAWUCAQsSMAsGCWCGSAFlAgELEzAMBgpghkgBZQMCAQMaMAwGCmCGSAFlAwIBAxsw
NwYDVR0fBDAwLjAsoCqgKIYmaHR0cDovL2NybC5kaXNhLm1pbC9jcmwvRE9EUk9PVENBMi5jcmww
ggEBBggrBgEFBQcBAQSB9DCB8TA6BggrBgEFBQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1
ZWR0by9ET0RST09UQ0EyX0lULnA3YzAgBggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWww
gZAGCCsGAQUFBzAChoGDbGRhcDovL2NybC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIw
Q0ElMjAyJTJjb3UlM2RQS0klMmNvdSUzZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2Ml
M2RVUz9jcm9zc0NlcnRpZmljYXRlUGFpcjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAqIVhyl
VyZaYst10N2GxVLiL/O8EWQ/jC8+EfyYYEDygA0ogppo/uBISyfTOgp7lfYDDIEUkUI6YGziK1Mt
7N8RrvVUF/AB+ZcHp5urC9usl4kJxu/5BzQWAKh+EVOefC+hOKKZeTk0QW59uFgwVoie5KpkRdmg
RGI6t+Ux05GA8RsQsmdw1VurWbRaSBZCxAJM2mxoylAdMb43mcfPU8xCKVbDnRfKA+cQWvE5PBzM
+xuXCibzMd/gq1wknZ7eOH0CUWdG+ZNwhe0KVcL0wWhanwjJHXubdtxU7zmMGOUMRO73BrIf9cvm
Dr3Uof/U+ZEHIlJ5t8D97LL4hfRE+1wwggVSMIIEOqADAgECAgIBuTANBgkqhkiG9w0BAQUFADBb
MQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAK
BgNVBAsTA1BLSTEWMBQGA1UEAxMNRG9EIFJvb3QgQ0EgMjAeFw0xMTA5MDgxNjAzMDhaFw0xNzA5
MDgxNjAzMDhaMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNV
BAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzAwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmKSLUFCbRmBpSXsWEg3N+wWCzs9CUvv0clFW/9oQsm8nA
dHPvzMKZ8pnJbcoU03T/vhDy9y2/y7sGo+6YUEFlAeFXLLbL5MocrH5SNA6xjgcmPjI1r6NhCsXl
CLYSeYxUwXrp8VAfXYM6ZzCzKdsdOkw5IVDYGCyNBnXuY3J4aK1inHWklAbTMmsSrwYHKb4ToMCn
8CVPt/4ft1fgGBKNIWoVuVpU+3dl2Ew/9bo8wDfhBn7Cvp4jjCjRmtfGZzjXc8m9Bx2Fb9WVCprc
2jpOKPCl6wnf5dsLzUevis27b5RA41mcUJ/JDqlxArnc6WmAOok7RQUiGAWEtRLwPMCBAgMBAAGj
ggIcMIICGDAOBgNVHQ8BAf8EBAMCAYYwHwYDVR0jBBgwFoAUSXS7DF66ev4CVO97oMaVxgmAcJYw
HQYDVR0OBBYEFDVhZigJvFYlW4vMv4FeYSwwOdMhMBIGA1UdEwEB/wQIMAYBAf8CAQAwDAYDVR0k
BAUwA4ABADBmBgNVHSAEXzBdMAsGCWCGSAFlAgELBTALBglghkgBZQIBCwkwCwYJYIZIAWUCAQsR
MAsGCWCGSAFlAgELEjALBglghkgBZQIBCxMwDAYKYIZIAWUDAgEDGjAMBgpghkgBZQMCAQMbMDcG
A1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuZGlzYS5taWwvY3JsL0RPRFJPT1RDQTIuY3JsMIIB
AQYIKwYBBQUHAQEEgfQwgfEwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5taWwvaXNzdWVk
dG8vRE9EUk9PVENBMl9JVC5wN2MwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3NwLmRpc2EubWlsMIGQ
BggrBgEFBQcwAoaBg2xkYXA6Ly9jcmwuZ2RzLmRpc2EubWlsL2NuJTNkRG9EJTIwUm9vdCUyMENB
JTIwMiUyY291JTNkUEtJJTJjb3UlM2REb0QlMmNvJTNkVS5TLiUyMEdvdmVybm1lbnQlMmNjJTNk
VVM/Y3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA0GCSqGSIb3DQEBBQUAA4IBAQAKiFYcpVcm
WmLLddDdhsVS4i/zvBFkP4wvPhH8mGBA8oANKIKaaP7gSEsn0zoKe5X2AwyBFJFCOmBs4itTLezf
Ea71VBfwAfmXB6ebqwvbrJeJCcbv+Qc0FgCofhFTnnwvoTiimXk5NEFufbhYMFaInuSqZEXZoERi
OrflMdORgPEbELJncNVbq1m0WkgWQsQCTNpsaMpQHTG+N5nHz1PMQilWw50XygPnEFrxOTwczPsb
lwom8zHf4KtcJJ2e3jh9AlFnRvmTcIXtClXC9MFoWp8IyR17m3bcVO85jBjlDETu9wayH/XL5g69
1KH/1PmRByJSebfA/eyy+IX0RPtcMYIC2DCCAtQCAQEwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UE
ChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMP
RE9EIEVNQUlMIENBLTMwAgMLHVswCQYFKw4DAhoFAKCCAUkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTMwNzA2MjA1MzMzWjAjBgkqhkiG9w0BCQQxFgQU+bgVylKY
bctTzeu8TeAAjIlbIuAwcwYJKwYBBAGCNxAEMWYwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMP
VS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9E
IEVNQUlMIENBLTMwAgMLHV0wdQYLKoZIhvcNAQkQAgsxZqBkMF0xCzAJBgNVBAYTAlVTMRgwFgYD
VQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQD
Ew9ET0QgRU1BSUwgQ0EtMzACAwsdXTANBgkqhkiG9w0BAQEFAASCAQAHtXUmscubIqOVmn6WSw7E
FhqHkGzJ1XXNvPO8B7Jg3S4fnTkiA920mFKwnvgYFF96GrWVKbeGTchIjaw1u4JkR4mas8mQuqLZ
sL2Zrw4Hkz37IZYR1unBiB948Vse4QqzX7Xf0OhqR1gxSqUnAqjYpYDqUoIAAHpiVv19rQRFirKu
ESH67lToup2HDPBrzuWdHWaXZUSyuxbfHu1VE2erzFsCkmJAHSmHvN3E5PCVsiDehdIkD1dOeqlx
Z5FhGbdMwr9ilVfEl7ol+U1PBdYw+jGc0/0nvo84pqiYTNB4ZMrcsnjGZn9nKGGsA9M6cRodUfsk
9fxxeto0NRqrVDb/AAAAAAAA

--Apple-Mail=_5F89C143-C9E8-4E50-820C-491C9331EDEC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
