Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3LIQIZT014387
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 14:26:18 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3LIQIjj020619
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 18:26:18 GMT
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-Id: <E3090001-08DB-4A01-B568-5BD356F4686D@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1208793850.15796.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; boundary=Apple-Mail-65-714320030; micalg=sha1; protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: avc_init & avc_open
Date: Mon, 21 Apr 2008 13:24:29 -0500
References: <7A092CE0-19C7-4686-96CF-698A69267BBA@nall.com> <1208785055.15796.40.camel@moss-spartans.epoch.ncsc.mil> <75F5689B-C03A-4840-A560-B77AF2DCBDFB@nall.com> <1208793850.15796.63.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-65-714320030
Content-Type: text/plain;
	charset=WINDOWS-1252;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable


On Apr 21, 2008, at 11:04 AM, Stephen Smalley wrote:

>
> On Mon, 2008-04-21 at 10:47 -0500, Joe Nall wrote:
>> On Apr 21, 2008, at 8:37 AM, Stephen Smalley wrote:
>>
>>>
>>> On Mon, 2008-04-21 at 08:21 -0500, Joe Nall wrote:
>>>> I have a userspace object manager that I would like to specify the
>>>> log
>>>> callback and the enforcing mode for simultaneously. The enforcing
>>>> mode
>>>> can be set with avc_open (no man page) and the callbacks with
>>>> avc_init(3). What is the best strategy?
>>>
>>> avc_init() was the old interface.
>>> selinux_set_callback() + avc_open() is the new interface.
>>
>> Do you know what rawhide rpm SELABEL_CB_LOG and friends might be in?
>> They are not in <selinux/selinux.h> or in /usr/include on a current
>> rawhide with libselinux-devel.
>
> Looks like the man page is wrong - it is SELINUX_CB_LOG, not SELABEL_


I'm confused by the syntax. The following is extracted from my C++ =20
code that is calling avc_open.

int avc_log(int ltype, const char *fmt, ...)
{
va_list ap;
va_start(ap, fmt);
...
}
...
static struct avc_entry_ref avcref;
if (!avc_initialized)
    {
    struct selinux_opt opts[] =3D { { AVC_OPT_SETENFORCE, (char *)1 } };
    if (avc_open(opts, 1) < 0)
        ...
    avc_entry_ref_init(&avcref);
    selinux_set_callback(SELINUX_CB_LOG, (selinux_callback)&avc_log);
    avc_initialized =3D 1;
    }

Context.C: In member function =91int Context::operator>=3D(const =
Context&)=92:
Context.C:317: error: no matching function for call to =20
=91selinux_callback::selinux_callback(int (&)(int, const char*, ...))=92
/usr/include/selinux/selinux.h:142: note: candidates are: =20
selinux_callback::selinux_callback()
/usr/include/selinux/selinux.h:142: note:                 =20
selinux_callback::selinux_callback(const selinux_callback&)
Context.C:318: error: conversion from =91int (*)(int, const char*, ...)=92=
 =20
to non-scalar type =91selinux_callback=92 requested

What is the right syntax? Got a good example of selinux_set_callback =20
usage?

joe



--Apple-Mail-65-714320030
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIqzCCBDIw
ggMaoAMCAQICAR0wDQYJKoZIhvcNAQEFBQAwWzELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxFjAUBgNVBAMTDURvRCBSb290
IENBIDIwHhcNMDYwNjE0MTcwNDAzWhcNMTIwNjE0MTYwNDAzWjBdMQswCQYDVQQGEwJVUzEYMBYG
A1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UE
AxMPRE9EIEVNQUlMIENBLTE2MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDhLwdkjsbyObA
y1xFSIN58Ffu5Uvt8Fvnf/2kW27pjGkSnkoOH0Y0/xJFJcS5bDDb//kz3eojDlhn906fVccBuoZ7
mWLptyXcPRIfFDzdykorWcdHn8+EKSD80ylXnsjxVPpFm6qio9GvHFK8ceMXGbnXBDlrDZMiICQl
m84kTwIDAQABo4IBgTCCAX0wDgYDVR0PAQH/BAQDAgGGMB8GA1UdIwQYMBaAFEl0uwxeunr+AlTv
e6DGlcYJgHCWMB0GA1UdDgQWBBRHk8ejIzy0Me7MQnzdaBPLAZqPLTAMBgNVHSQEBTADgAEAMA8G
A1UdEwEB/wQFMAMBAf8wMAYDVR0gBCkwJzALBglghkgBZQIBCwUwCwYJYIZIAWUCAQsJMAsGCWCG
SAFlAgELCjCB2QYDVR0fBIHRMIHOMDigNqA0hjJodHRwOi8vY3JsLmdkcy5kaXNhLm1pbC9nZXRj
cmw/RG9EJTIwUm9vdCUyMENBJTIwMjCBkaCBjqCBi4aBiGxkYXA6Ly9jcmwuZ2RzLmRpc2EubWls
L2NuJTNkRG9EJTIwUm9vdCUyMENBJTIwMiUyY291JTNkUEtJJTJjb3UlM2REb0QlMmNvJTNkVS5T
LiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdDtiaW5hcnkw
DQYJKoZIhvcNAQEFBQADggEBAAZhhKwoETryrmbMiJj6Tr6XxadbI42CLQEnkTDqxiLJVzQ6h/n4
Blv6Zm2xie3Tm0NigASlKlNoWNRrVojLahSiTn10G2c6iwe1LOSgICe/SGfo8+nJaZ9/AUhh+8En
d3uPvq7SQtEMMSQmndcakfONrP5vky3gHk/HOQR/cR8up8nnP+hx3iq30KwRC27qizWjdZU9rmcI
F92GGPpIkhsALmEXqWxURGlJIBctWQqbAepDRKDnV9JUhBcT400kANiueiDX40qPN8R/vLGhgyF+
c3E3aJHbReL/2BrtEGBauWHMwAA8pW3MuZz+xp3HGp7AcE2CwTn4hsrBoA/Q+ekwggRxMIID2qAD
AgECAgMJCIswDQYJKoZIhvcNAQEFBQAwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292
ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBD
QS0xNjAeFw0wNzA1MjEwMDAwMDBaFw0wOTAxMzEyMzU5NTlaMHsxCzAJBgNVBAYTAlVTMRgwFgYD
VQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRMwEQYDVQQL
EwpDT05UUkFDVE9SMSEwHwYDVQQDExhOQUxMLkpPU0VQSC5ELjEyNjUwODIwNTYwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAIQaYg7wCON3AccvTUkzRHFGkA7lrHchWPxvsIhLwXvku/a0ltwk
eQJMomHL/3GQQ/Y3eEPTklFQyGoJkx6uaQu6v6eOlWqzf4RnOpoR57LHZpE50evy0RnZfEepSRzW
K4uL5tp0k/sTcuESdyt7g4hhob1DBdOntehdBcRm3Hl3AgMBAAGjggIfMIICGzAOBgNVHQ8BAf8E
BAMCBsAwHwYDVR0jBBgwFoAUR5PHoyM8tDHuzEJ83WgTywGajy0wHQYDVR0OBBYEFB+HBoRJ6sDm
KYkyzdyMq1dRO3ZWMBYGA1UdIAQPMA0wCwYJYIZIAWUCAQsJMIHZBgNVHR8EgdEwgc4wOKA2oDSG
Mmh0dHA6Ly9jcmwuZ2RzLmRpc2EubWlsL2dldGNybD9ET0QlMjBFTUFJTCUyMENBLTE2MIGRoIGO
oIGLhoGIbGRhcDovL2NybC5nZHMuZGlzYS5taWwvY24lM2RET0QlMjBFTUFJTCUyMENBLTE2JTJj
b3UlM2RQS0klMmNvdSUzZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jZXJ0
aWZpY2F0ZVJldm9jYXRpb25MaXN0O2JpbmFyeTApBgNVHSUEIjAgBgorBgEEAYI3FAICBggrBgEF
BQcDBAYIKwYBBQUHAwIwNwYDVR0RBDAwLoEMam9lQG5hbGwuY29toB4GCisGAQQBgjcUAgOgEAwO
MTI2NTA4MjA1NkBtaWwwcQYIKwYBBQUHAQEEZTBjMD8GCCsGAQUFBzAChjNodHRwOi8vY3JsLmdk
cy5kaXNhLm1pbC9nZXRzaWduP0RPRCUyMEVNQUlMJTIwQ0EtMTYwIAYIKwYBBQUHMAGGFGh0dHA6
Ly9vY3NwLmRpc2EubWlsMA0GCSqGSIb3DQEBBQUAA4GBAGyIAqWQ5N0DQL4HRnIZsZohhrq//qdz
XLVCRjLMQuWIGzuZheD6fvksx+dcDdPu8vcJLUUis2Kp8cGATA3dmXWI018hv534HvJnKtHvizpe
PIxHmZAacVhBV//BBJU8h3E2lKRkUuyKtAYgpXWy73UhcUoIKAPmGFgpKGQNJVSJMYICVzCCAlMC
AQEwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNE
b0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswCQYFKw4DAhoF
AKCCAUkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDgwNDIxMTgy
NDMwWjAjBgkqhkiG9w0BCQQxFgQUeskDLSsHkoUcqhCltNtRoAibU3UwcwYJKwYBBAGCNxAEMWYw
ZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0Qx
DDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswdQYLKoZIhvcNAQkQ
AgsxZqBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsT
A0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMTYCAwkIizANBgkqhkiG
9w0BAQEFAASBgDAjMCiC7n7nV+We0Lmqktkh/amMKMmE0DUkjjtnkvXHdGQxZ8FxfQfiC97sWFDf
D5Z8NhgmkBo9neP/7CyvD1Fzlhw3hQE5HGRQscU8yidH5qaJzGyMJ/OT8yGJJ0QzkD8kAY/eWPAo
2yTe0XniSzqaX3g7g5kkokgBON6UHMkXAAAAAAAA

--Apple-Mail-65-714320030--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
