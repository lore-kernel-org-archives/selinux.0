Subject: Re: semanage: is __default__ login map required?
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <fe3cac69-be05-984f-7a71-28989b3ef93b@mail.mil>
 <1493838844.15269.16.camel@tycho.nsa.gov>
 <1493840196.15269.18.camel@tycho.nsa.gov>
From: "Arnold, Paul C CTR USARMY PEO STRI (US)" <paul.c.arnold4.ctr@mail.mil>
Message-ID: <d3c1ae40-55c9-6744-ffe5-e59e9ecff451@mail.mil>
Date: Wed, 3 May 2017 15:47:46 -0400
MIME-Version: 1.0
In-Reply-To: <1493840196.15269.18.camel@tycho.nsa.gov>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms080207020304080908080505"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a cryptographically signed message in MIME format.

--------------ms080207020304080908080505
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 03:32 PM, Stephen Smalley wrote:
> On Wed, 2017-05-03 at 15:14 -0400, Stephen Smalley wrote:
>> On Wed, 2017-05-03 at 13:36 -0400, Arnold, Paul C CTR USARMY PEO STRI
>> (US) wrote:
>>> I have been having problems mapping logins since removing
>>> __default__
>>> from the policy.  Is the __default__ login map required in order
>>> for
>>> semanage to set a new mapping?
>>>
>>> The error, specifically:
>>>
>>> $ sudo semanage login -a -s existing_u existing_login
>>> libsemanage.dbase_llist_query: could not query record value
>>> semanage: Could not query user for existing_login
>>>
>>>
>>> Policy is based upon refpolicy, but all utils are RHEL6 dist.
>> Not sure what is in RHEL6, but upstream it looks like the code tries
>> to
>> look up the old login/user information before making the change so
>> that
>>   it can audit the old and new values.  Probably ought to be handling
>> an
>> exception there and recovering cleanly.
>>
>> Caution-https://github.com/SELinuxProject/selinux/blob/master/python/s=
emanage
>> /seobject.py#L537
>>
>> Caution-https://github.com/SELinuxProject/selinux/commit/a0e538c208e5a=
f07fecb
>> 8c045e6341397d0df44a
> That said, maybe the first question is why do you want to remove the
> __default__ mapping.  Not sure that is even supported via semanage
> login -d, and you're likely to end up having it get regenerated
> automatically on any subsequent semodule/semanage commands even if you
> manually remove it (unless you removed it from the source policy before=

> building in the first place).
>
> Just set it to the most restrictive values possible, like user_u, s0 or=

> guest_u, s0.
>

Thanks Stephen.  As for why, this is for a high assurance solution for=20
which I do not make the requirements.


__default__ is removed from source policy.  I don't think semanage can=20
remove logins defined in base policy, and I wouldn't want to due to=20
regeneration concerns you already mentioned.

Thank you for the commit reference; that makes it much clearer for me. =20
I'll do some testing, perhaps just write another python script to add=20
new mappings if I absolutely cannot have __default__ defined.



Regards,

--=20
Paul Arnold, CISSP
Cole Engineering Services, Inc.



--------------ms080207020304080908080505
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
HkFSTk9MRC5QQVVMLkNIQVJMRVMuMTQxMDc2NzI1OTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAOttH+7UV7C0XtejWuVYbAoWr1XMy8Drd/8PO+zYrq0iiHyYgCMvMeybqxV5
nYZ0q1/wL5GyqKmxflsEYRMOpRSPr8Ys/vgHRIvPQHLgiaFzpB/Q7ocw+c1FR7GdhCeElqdf
Hy906s0dbGpi8X+TfD0HmXqRxBtTiqvKm61DEScgqfk91XzyzvoJEmtUjgF8Ys2xMi+Gmgc4
yfE+lxvt43ugsZPEI6GLbfhTB2N+XYPkJfaqvBI+//F6/v+r/jxIz+b8Jg15fDnK8irx0NWE
SQzLl1+V/EpK6cOxnyBPPjADG1+h4fpKJzSvE0iUwtgJLpCv6dThuYHLrnpe3i8a4gsCAwEA
AaOCAa8wggGrMB8GA1UdIwQYMBaAFA+GWX7j+ucT+zE7wTkMfGCLQMLdMDoGA1UdHwQzMDEw
L6AtoCuGKWh0dHA6Ly9jcmwuZGlzYS5taWwvY3JsL0RPREVNQUlMQ0FfMzQuY3JsMA4GA1Ud
DwEB/wQEAwIGwDAjBgNVHSAEHDAaMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxMwHQYDVR0O
BBYEFCVC9iLRRRfBP1NAHmgBi/rPi506MGgGCCsGAQUFBwEBBFwwWjA2BggrBgEFBQcwAoYq
aHR0cDovL2NybC5kaXNhLm1pbC9zaWduL0RPREVNQUlMQ0FfMzQuY2VyMCAGCCsGAQUFBzAB
hhRodHRwOi8vb2NzcC5kaXNhLm1pbDBGBgNVHREEPzA9gRtwYXVsLmMuYXJub2xkNC5jdHJA
bWFpbC5taWygHgYKKwYBBAGCNxQCA6AQDA4xNDEwNzY3MjU5QG1pbDAbBgNVHQkEFDASMBAG
CCsGAQUFBwkEMQQTAlVTMCkGA1UdJQQiMCAGCisGAQQBgjcUAgIGCCsGAQUFBwMCBggrBgEF
BQcDBDANBgkqhkiG9w0BAQUFAAOCAQEAOVy11EvO7C36FJFzsSm4spdOdj/HfPgMo2tTzy/b
Ffk4iaXeCraj2a03B5/jRVya6ZiBfqeAiR7y3Bbb7UTiL/2er0aejkPM6G1QuV8u5HisQJic
Q+a2N4o+5J54DkY67WPzbRiD0EHesbSeUjB709PoU1SWfsnIBbAavurNdbaWSVUb43TSw21g
QC1lHGJg0fmiw3DHb4v7bKol+0fLUeehibpudedEWIo+aWrt9mzFeIkHeUnYLv4e2UBW419x
xUjOs8aae3eOLKp+Ze+MXtBlWrkhmk3BHa5cB7kzlgqV++TWBlqpaL9WC20PwDk23PqkXCSu
iX+flniUgvOdDTGCA1YwggNSAgEBMGQwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBF
TUFJTCBDQS0zNAIDDNzaMA0GCWCGSAFlAwQCAQUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA1MDMxOTQ3NDZaMC8GCSqGSIb3DQEJBDEiBCDy
aLQxUDah7CxPD4TUG6YDQxIxGiTC5FL8pQKN812KvDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHMGCSsGAQQBgjcQBDFmMGQwXTEL
MAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQww
CgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zNAIDDNzbMHUGCyqGSIb3DQEJ
EAILMWagZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYD
VQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTM0AgMM3Nsw
DQYJKoZIhvcNAQEBBQAEggEAVHAu46YPGaT5sCpkvBL9ebW4gUjrszSpG6becSH/RM4buZjy
XfpTKWysv2gNJJgFzMjWJ7ZWCHyc+XoKxkh4/eQW9vlAJHXgK6M/EwmnrCU+HYBDvsrcC2Oe
HSUgX58eb6HJKnngxalRiJNpCBXSD9HnMosSI1EG3rxgkaY2nVg2FgoLaU0WcisMiqN2bvgu
Dfeiz3605AjW74H60Et3ZnyTrdKD142HnkMZErejSpfE1aSO/+fv0SEtX9V4l9pe9ooZ4732
Q4JsdCvPww/AiW3EIjBgkjynuL5ztquoVOoJvuxHmV5yzhX9Y3tHVLiqTbRDCMLaMqFo/L/q
EUIwIwAAAAAAAA==
--------------ms080207020304080908080505--
