Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBPEpUB7006584
 for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2013 09:51:30 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so7378635pbc.24
 for <selinux@tycho.nsa.gov>; Wed, 25 Dec 2013 06:51:27 -0800 (PST)
Received: from [192.168.0.6] (ip24-253-3-239.lv.lv.cox.net. [24.253.3.239])
 by mx.google.com with ESMTPSA id gg10sm48816040pbc.46.2013.12.25.06.51.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 25 Dec 2013 06:51:26 -0800 (PST)
Message-ID: <52BAF0EA.3080606@networkcrypt.com>
Date: Wed, 25 Dec 2013 06:51:22 -0800
From: Francis Cunnane <frankc@networkcrypt.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
In-Reply-To: <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha1; boundary="------------ms040900020103000600090508"
Reply-To: frankc@networkcrypt.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a cryptographically signed message in MIME format.

--------------ms040900020103000600090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Merry Christmas!

On 12/25/2013 6:36 AM, Nicolas Iooss wrote:
> 2013/12/23 Daniel J Walsh wrote:
>> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
>>> My first message was not so clear. The check in
>>> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
>>> selinux_trans_to_raw_context(context, &rcontext) returns 0 and sets
>>> rcontext to NULL. This is why I'm asking to change the return value t=
o
>>> something else if you want "cp -a" working. This fix is not to introd=
uce a
>>> new feature but to fix an existing one.
>>>
>>> Nicolas
>>>
>> How about if we add a check on lsetfilecon_raw?  Changing the behaviou=
r on
>> selinux_trans_to_raw_context might cause other problems.
> I agree. I've found
> http://selinuxproject.org/page/LibselinuxAPISummary which says
> precisely for selinux_trans_to_raw_context: "If passed NULL, sets the
> returned context to NULL and returns 0." As this feature is
> documented, callers may rely on it and changing this behavior is
> likely to break things.
>
> Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-pointer
> dereference issue. Do these functions need a patch too?
>
> By the way, other callers of selinux_trans_to_raw_context may also
> share this bug: avc_context_to_sid, security_canonicalize_context,
> security_check_context, etc. Is doing a segmentation fault the
> expected way to tell the caller it used a NULL pointer and should have
> manually checked every parameter before calling any libselinux
> function?
>
> Thanks and merry Christmas!
>
> Nicolas
>
>>
>> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon=
=2Ec
>> index 461e3f7..af3775e 100644
>> - --- a/libselinux/src/lsetfilecon.c
>> +++ b/libselinux/src/lsetfilecon.c
>> @@ -9,6 +9,10 @@
>>
>>   int lsetfilecon_raw(const char *path, const security_context_t conte=
xt)
>>   {
>> +       if (! context) {
>> +               errno=3DEINVAL;
>> +               return -1;
>> +       }
>>          return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(co=
ntext) + 1
>>                           0);
>>   }
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.



--------------ms040900020103000600090508
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKUjCC
BRowggQCoAMCAQICEG0Z6qcZT2ozIuYiMnqqcd4wDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3Qu
Y29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
RW1haWwwHhcNMTEwNDI4MDAwMDAwWhcNMjAwNTMwMTA0ODM4WjCBkzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAJKEhFtLV5jUXi+LpOFAyKNTWF9mZfEyTvefMn1V0HhMVbdClOD5J3EHxcZppLkyxPFA
GpDMJ1Zifxe1cWmu5SAb5MtjXmDKokH2auGj/7jfH0htZUOMKi4rYzh337EXrMLaggLW1DJq
1GdvIBOPXDX65VSAr9hxCh03CgJQU2yVHakQFLSZlVkSMf8JotJM3FLb3uJAAVtIaN3FSrTg
7SQfOq9xXwfjrL8UO7AlcWg99A/WF1hGFYE8aIuLgw9teiFX5jSw2zJ+40rhpVJyZCaRTqWS
D//gsWD9Gm9oUZljjRqLpcxCm5t9ImPTqaD8zp6Q30QZ9FxbNboW86eb/8ECAwEAAaOCAUsw
ggFHMB8GA1UdIwQYMBaAFImCZ33EnSZwAEu0UEh83j2uBG59MB0GA1UdDgQWBBR6E04AdFvG
eGNkJ8Ev4qBbvHnFezAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNV
HSAECjAIMAYGBFUdIAAwWAYDVR0fBFEwTzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3Qu
Y29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwdAYI
KwYBBQUHAQEEaDBmMD0GCCsGAQUFBzAChjFodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVRO
QWRkVHJ1c3RDbGllbnRfQ0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1
c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCF1r54V1VtM39EUv5C1QaoAQOAivsNsv1Kv/av
QUn1G1rF0q0bc24+6SZ85kyYwTAo38v7QjyhJT4KddbQPTmGZtGhm7VNm2+vKGwdr+XqdFqo
2rHA8XV6L566k3nK/uKRHlZ0sviN0+BDchvtj/1gOSBH+4uvOmVIPJg9pSW/ve9g4EnlFsjr
P0OD8ODuDcHTzTNfm9C9YGqzO/761Mk6PB/tm/+bSTO+Qik5g+4zaS6CnUVNqGnagBsePdIa
XXxHmaWbCG0SmYbWXVcHG6cwvktJRLiQfsrReTjrtDP6oDpdJlieYVUYtCHVmdXgQ0BCML7q
peeU0rD+83X5f27nMIIFMDCCBBigAwIBAgIRAOEtgEtOQn3CQDAg7XarCEcwDQYJKoZIhvcN
AQEFBQAwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMTkwNwYDVQQDEzBD
T01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTMw
ODI0MDAwMDAwWhcNMTQwODI0MjM1OTU5WjAoMSYwJAYJKoZIhvcNAQkBFhdmcmFua2NAbmV0
d29ya2NyeXB0LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMAeIDcQUaZ7
PNQnapzhdKSlZ/AwhZsa+bZUkz9PH8SfzpUYHrLOlEaT0G0r78I8PYFpnIdeicQVwceTphBw
kOfKrWTJKvacxP9QhfnmLFVjLSraSdnQsZZMsugDdImmfWF7xx1w3Zij/7tSbuAkx8S0hekg
xxbI+jgTb4Wg0LRlyH4clZs31/Xju/WT0mOJ6ykLLgxE1jose1tjIoWvipCR6+Rx6Z4OH7Du
hXhVf95E96FsdErTGlxTTtsWEfVLU0h2ytX1UILG1BqX9D+L3PPdbi/myOGnmRmSJ0f7Q+4H
pSci5l/SfrFMZcnl0eVGYRJfx2O8nLMg1r4dnGDYZKUCAwEAAaOCAecwggHjMB8GA1UdIwQY
MBaAFHoTTgB0W8Z4Y2QnwS/ioFu8ecV7MB0GA1UdDgQWBBSItP/9ZiynH7iNipGrLSRDTik7
YjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYL
KwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQEC
AQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFcGA1Ud
HwRQME4wTKBKoEiGRmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET0NsaWVudEF1dGhl
bnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYgGCCsGAQUFBwEBBHwwejBSBggrBgEF
BQcwAoZGaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCIGA1UdEQQbMBmBF2ZyYW5rY0BuZXR3b3JrY3J5cHQuY29tMA0GCSqGSIb3DQEB
BQUAA4IBAQAzWNJ9HY0CfcYtnshAOBHgkfhJsiBO4Np6aYj3UZCmEIiQq8x0u+rxTcMgs2dm
Lp5Rx17MQ3qQVZxQWpjLt5+2vCV3mS1EPwrd9KUuuVT6br3ymKLC5v5SvLqsMv6q1ze3XPej
UO8QM+6BIm9KajrVbB8ND2EcAZwCLr4aUQ5eKMxcZCVgR1ZMXH++so3hYAjTtWiPhYkTJyml
E2FTx+fdvH8tOkZalgIzxKlBEXStdXzuzNySz8qMN5Efqbh+6RyhzfdtshWYC1J1i8WtpY+e
wSLMqMFVVcu96n6I3oW2jUMAaZG3Ur+pw5qNEupxIeLOVZaqLXgezbJvPN4F43w8MYIEHDCC
BBgCAQEwgakwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMTkwNwYDVQQD
EzBDT01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDh
LYBLTkJ9wkAwIO12qwhHMAkGBSsOAwIaBQCgggJHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTEzMTIyNTE0NTEyMlowIwYJKoZIhvcNAQkEMRYEFPglfsXS
dVlopjxGGY6iC29n3+vMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4D
AgcwDQYIKoZIhvcNAwICASgwgboGCSsGAQQBgjcQBDGBrDCBqTCBkzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAOEtgEtOQn3CQDAg7XarCEcwgbwGCyqGSIb3
DQEJEAILMYGsoIGpMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
AhEA4S2AS05CfcJAMCDtdqsIRzANBgkqhkiG9w0BAQEFAASCAQA/aWVdx7aHlQbn7jzr2TXV
qILmJkrDz/Tkf/unvwVuM1OcbmHPrVs4MGASUrsbsjSMsgVUmdzsTVPMeH+Fcr+nVvXNInY3
qZvG+z6eeeSN5VEXND8HuNOKTQqwVqYFiI0fUAK9N+qWyEFnPPXxRmbhBPtPxqLWFIvyt4QB
WvbD8SwiF0vhHiu5tctDz2/PgWy2NhWz0vOo27DKIBWN0jaO0PV+GSZeQh051+WTVF9BhU8i
5NuMRLBxkliKD8kAOFzyXU/yFNAgVG/dNU7yKdNEAdpjtQIE4QXsl2nu8mVlpLlLnC3D3akF
YNWuwDAUiZ8rdroPvn3Wn7pdJ1eoHM1IAAAAAAAA
--------------ms040900020103000600090508--
