Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PN7MrT025248
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 19:07:22 -0400 (EDT)
Received: from smtp802.mail.sc5.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i8PN6Ksn005387
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 23:06:21 GMT
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <1096052356.9895.25.camel@selinux>
References: <200409211526.37810.russell@coker.com.au> <200409250105.40796.russell@coker.com.au> <1096048244.9895.4.camel@selinux> <200409250427.49189.russell@coker.com.au> <1096052356.9895.25.camel@selinux>
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-3--265181088; protocol="application/pkcs7-signature"
Message-Id: <9A993228-0F47-11D9-80EA-000A95EED7F6@nall.com>
From: Joe Nall <joe@nall.com>
Subject: Re: Remove unrestricted_admin
Date: Sat, 25 Sep 2004 18:06:59 -0500
To: SELinux Mail List <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-3--265181088
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Sep 24, 2004, at 1:59 PM, Christopher J. PeBenito wrote:

> On Sat, 2004-09-25 at 04:27 +1000, Russell Coker wrote:
>> On Sat, 25 Sep 2004 03:50, "Christopher J. PeBenito" 
>> <cpebenito@tresys.com>
>> wrote:
>>> On Sat, 2004-09-25 at 01:05 +1000, Russell Coker wrote:
>>>> -allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
>>>>
>>>> I think that perhaps we should add that line back.
>>>>
>>>> Of the times that I temporarily enable permissive mode to execute a
>>>> command, in 99% of them it's because of access to a fixed disk.
>>>
>>> Why would you need to directly access the disk as sysadm_t?  All the
>>> applicable tools should be transitioning to fsadm_t.
>>
>> dd if=/dev/hda of=/dev/hdb
>>
>> file -s /dev/hda
>>
>> Using an LVM snapshot to backup a disk onto a DVD.
>
> Yes these are reasons; however, this is supposed to be the strict
> policy, and these are not compelling enough to loosen the policy this
> way, in my opinion.

dd has other options (seek, skip, count) that allow arbitrary editing of
a raw disk. If you can dd (or write in general) the root raw disk 
partition,
you can do anything.

joe


--Apple-Mail-3--265181088
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
9w0BCQUxDxcNMDQwOTI1MjMwNjU5WjAjBgkqhkiG9w0BCQQxFgQUnZt2eG8dK89pl3esJLym6It+
LVQweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0ECAwuWwjB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVl
bWFpbCBJc3N1aW5nIENBAgMLlsIwDQYJKoZIhvcNAQEBBQAEggEAlkjylElbK9perXR+ByHCDDW1
oJQjOt5CMirDALHCPk/XXsBPzm1Q/MUnS908fGdGMIQnCI1G7wr+S9lxW4rNL0JGF7l/CrL8TlzH
sKz74hds2lvXbIG8ABZPtpM36ls2d30C8yYy79leeUcS/QRu/I5/7I8XbU398RhtmiktGue4R0cK
yjZsNKm80a9R1Zcfdk2k/47ia8LsrbaTjnjN2b0ipgNxqeQQ+l3iwBEDdSe5uopjBzaNHtbCIU31
Mk9nuzdUKa8YXg4cSI4xWrUVRoXJMtl8G+rrifWNKA6RuJAY3O5hDwhDrjcPHWbWU8cgFo+dvzRd
cCBeB5eSfyzRRgAAAAAAAA==

--Apple-Mail-3--265181088--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
