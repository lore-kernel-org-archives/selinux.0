Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8THtarT017697
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 13:55:36 -0400 (EDT)
Received: from smtp809.mail.sc5.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i8THtYjQ020327
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 17:55:34 GMT
Mime-Version: 1.0 (Apple Message framework v619)
To: SELinux Mail List <selinux@tycho.nsa.gov>
Message-Id: <C21693A0-1240-11D9-B045-000A95EED7F6@nall.com>
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-61732176; protocol="application/pkcs7-signature"
From: Joe Nall <joe@nall.com>
Subject: Representing releasibilities in SELinux
Date: Wed, 29 Sep 2004 12:55:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-1-61732176
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

We have an application that we are considering porting from a
Compartmented Mode Workstation (like Trusted Solaris) to SELinux. One of
the issues we need to address is representing releasability information.
We have a significant amount of data that is current marked with
variations of 'releasable to country1, country2 and country3'. Data
marked like this is releasable to any permutation of the countries
involved. There are a few hundred countries, so any approach needs
to scale to that level.
Any recommendations on representation or pointers to reference material
would be appreciated.

Joe Nall


--Apple-Mail-1-61732176
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGDDCCAsUw
ggIuoAMCAQICAwuWwjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDQwMTI4MjA0ODM1WhcNMDUwMTI3MjA0ODM1WjA+MR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMRswGQYJKoZIhvcNAQkBFgxqb2VAbmFsbC5jb20wggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDoOXvXIlSn5zdVWgcqjYChh6HxediQSToZIkZZ
CINioJiBln5P+BZ4G0cIQiu5PsQSzGtuGexUgk6ltdnz6GmVixpOXB/Qrl9OpmVY0sYZK4x5JcPf
3zGvgHTK/mZlwaJjys0IO7O8ML0Bixm+jfKXrlbQ3VwCOMfbXFBpqPLhls7g0b+p01GcvAztGbk8
Va3tG1CLADS/4ET8oQAMsaDL5Mt8i6SGQZE2OnBp4Rg48IAspgiM5vV5cPU//KFE3elgWTago3i7
kiMv4i+iPcq3IegsN0GXSm8HhObfLaFZl2G3R4OuSfBkOR/GAjNK+n6aa4FtOpCxvHe8ff53O5MR
AgMBAAGjKTAnMBcGA1UdEQQQMA6BDGpvZUBuYWxsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3
DQEBBAUAA4GBALaOqOFCpgvdc8/Z8xT/3gI56DKK5w+XkLcTodkDEv7vTNU7YVgnS7CWbR2op4Qe
+LryLoQQSsjKnUfBAuCq0bNki9NdIU7l/6bcCzecbBTE3Uxm1Yntm3RrOKHpb+/JZvwhxnKm1Gqo
/V4iDY1NRVICZ1OWEl+F69IMehYXFApZMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB
0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3du
MRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2
aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJ
KoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoX
DTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31
W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3
PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIG
A1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29t
L1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAc
MRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswN
o2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/
XV9lTzGCAucwggLjAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5n
IENBAgMLlsIwCQYFKw4DAhoFAKCCAVMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMDQwOTI5MTc1NTI0WjAjBgkqhkiG9w0BCQQxFgQUb2nHnE1ueB0eMbJK2Lox5yhf
3DYweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0ECAwuWwjB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVl
bWFpbCBJc3N1aW5nIENBAgMLlsIwDQYJKoZIhvcNAQEBBQAEggEAYIvEvK7NX6IZd1OdmU/70jEt
+X8vt3pHjFecVl7yoRGMmF0M5xHV8PWjZ0dpdjORVw7C1j9smIeDpE2zBcwJsm4FMQtr5oRDNgyK
yFROyCtFATPOf7ho6xhHoFUmUcYF6AqqI4D5foPZGDvPostJ1HA14uHVPEDT540CEO+/w8CnQP00
jrcoc61DhC+EeORQOEG+/KWFUVRLYUeL3Ob/9oFFECMT/nZ+Mo0LM8oOUWsS8nqVa3MA5xl8ZrbI
s66XwPt5J8mrKYtbvghKulvncLIVsN2nOUUDqVGF9F32RjbYOFEGAulayAQd116lUmJ9gI8YWJKP
TsxUQXz/gsBlLwAAAAAAAA==

--Apple-Mail-1-61732176--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
