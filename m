Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA1H9CW3003380
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2012 13:09:12 -0400
From: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
To: Paul Moore <paul@paul-moore.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Thu, 1 Nov 2012 13:09:02 -0400
Subject: Re: Question about SELinux capability
Message-ID: <CCB8247D.243B%thomas.moyer@ll.mit.edu>
In-Reply-To: <3608707.WxASRDOVXr@sifl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="B_3434620142_4449914"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--B_3434620142_4449914
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit

On 11/1/12 11:58 AM, "Paul Moore" <paul@paul-moore.com> wrote:


>On Wednesday, October 31, 2012 08:24:21 AM Moyer, Thomas - 0668 - MITLL
>wrote:
>> Yes. That is correct. What I am looking at though is a piece of hardware
>> that does not use IP (or TCP and UDP for that matter). Instead, they
>> implement their own protocol at the IP layer. So any traffic coming from
>> the hardware (to the system that I am writing policy for) and any
>>traffic
>> being sent to that machine uses a raw socket to communicate (no IP at
>> all). I briefly looked at ebtables, but it doesn't appear to have the
>>same
>> type of SECMARK support that I would use with iptables.
>
>I think I misunderstood your original question; I thought you were
>interested 
>in labeling the ethernet frames on the wire while it sounds like you are
>only 
>interested in assigning labels to the network traffic once it has been
>received by the system - yes?

Correct.

>
>> I think the best solution that I have come up with is to label the
>>network
>> interface used to communicate with the hardware, and then only allow the
>> domain being confined to create sockets and bind to that interface.
>
>I assume you are talking about the ingress/egress controls?

Also correct.

>
>If so, a word of caution, they *may* not catch non-IP traffic due to they
>way 
>they are hooked into the network stack.  I'd be interested in hearing
>what 
>happens in your case.

We are trying to ensure that only specific applications running on the
system can communicate with the embedded hardware. One way to do this is
to filter network traffic. At least the "easiest" that I could identify.

>
>> >On Friday, October 26, 2012 04:08:15 PM Moyer, Thomas - 0668 - MITLL
>> >
>> >wrote:
>> >> I am working with a piece of embedded hardware that uses raw ethernet
>> >> frames to communicate with another (standard PC). Is it possible to
>>apply
>> >> SELinux labels to those ethernet frames like you can with IP packets
>> >> using iptables and SECMARK?
>> >
>> >The secmark/iptables labels never leave the local system, they are
>> >maintained only within the kernel and do not travel out over the wire.
>> If
>> >you are interested in communicating security label over the network
>>your
>> >only options at present require an IP header at the very least.
>
>-- 
>paul moore
>www.paul-moore.com
>
-- 
Thomas Moyer, Technical Staff	voice: (781) 981-1374
Cyber Systems Technology Group		mobile: (857) 268-0493
MIT Lincoln Laboratory			email: thomas.moyer@ll.mit.edu
244 Wood Street
Lexington, MA 02420

--B_3434620142_4449914
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIUEgYJKoZIhvcNAQcCoIIUAzCCE/8CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
EfUwggTUMIIDvKADAgECAgpbnpTCAAAAAE9nMA0GCSqGSIb3DQEBCwUAMFExCzAJBgNVBAYT
AlVTMR8wHQYDVQQKExZNSVQgTGluY29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLEwNQS0kxEzAR
BgNVBAMTCk1JVExMIENBLTIwHhcNMTIwODI0MTMzNzMyWhcNMTMwODI0MTMzNzMyWjBhMQsw
CQYDVQQGEwJVUzEfMB0GA1UEChMWTUlUIExpbmNvbG4gTGFib3JhdG9yeTEPMA0GA1UECxMG
UGVvcGxlMSAwHgYDVQQDExdNb3llci5UaG9tYXMuTS41MDAxMjcxNTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAN2kzL21gle2n6FJ68b7s6rhJUZWK4zTnKN9TD7tGS1mLNuD
kO55g8tKHf8g+TM5nK89anV960D+4cwbWK4sbs9pQcrrSlzhQJhsZ4QSqMWsT9Gzq2qucaSw
Tge3LuySmA/8JPbVa3c+sSQNYc6qkbGKg97WYA+CP/CKknN8yS14S2OX1W27GJsTzF4c84Ya
B1qRBAwfBQMFbd51AfZ5j0c6isk0ov8kJkyYrqHKj4qbOG8WjvmSkPA+pXcbwUEnWXJLtCZZ
4+aZIQ2Sv7DE35urlrzYjrY6ENUzDV5dy86oFKjf8nJFiIV6NtYVSkRVOK2e5KqsGpIdcAOp
TJus/y8CAwEAAaOCAZwwggGYMB0GA1UdDgQWBBQVe66M3+xu+px9yukwqwj+SAbDUTAOBgNV
HQ8BAf8EBAMCBsAwHwYDVR0jBBgwFoAUjkp9iaFjFxyBiDRXNyZFXhmKfiQwMwYDVR0fBCww
KjAooCagJIYiaHR0cDovL2NybC5sbC5taXQuZWR1L2dldGNybC9MTENBMjBiBggrBgEFBQcB
AQRWMFQwLQYIKwYBBQUHMAKGIWh0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXR0by9MTENBMjAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3AubGwubWl0LmVkdS8wDAYDVR0TAQH/BAIwADA9Bgkr
BgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiDg+Udh+ynZoathxWD6vBFhbahHx2Fy94yh/+KcwIB
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
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAInOjv4PcQYSwcse3b/iU13ufWpydhGF1zKyWx6V
xn7EhTdIiVqRZSWEEhUN54ZZvcNCjJigjNc92nS7/DZ6QzHTDuWlIvgi76xgl8bbK6oCKEv8
0+LBZKd4w3O8G0D3JakwveWWT1jZJXRG0QT6y9Xy4ENiWleon60UAKD5frJtnNu3AH8ElATk
uh5iPyMzvvZ+dthAeVjyOnYiRTI3/z+8nWrY2Yxd5dumg8YuGP4Xg24lhSzxRFluqflWytRy
jOabskU4bjjW9MTMhLXDR5P1UG1ilkCG1CK883No8b4QguQhMTCPv4/3vta3E2V3m1APGCJf
n9GNXaJTi4/369ECAwEAAaOCAZ8wggGbMB0GA1UdDgQWBBQ/lnMko0FQsFkSo7eGshVplcTt
nDAOBgNVHQ8BAf8EBAMCBSAwHwYDVR0jBBgwFoAUjkp9iaFjFxyBiDRXNyZFXhmKfiQwMwYD
VR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5sbC5taXQuZWR1L2dldGNybC9MTENBMjBiBggr
BgEFBQcBAQRWMFQwLQYIKwYBBQUHMAKGIWh0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXR0by9M
TENBMjAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AubGwubWl0LmVkdS8wDAYDVR0TAQH/BAIw
ADA9BgkrBgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiDg+Udh+ynZoathxWD6vBFhbahHx2F69Bw
g+vtIAIBZAIBBDAlBgNVHSUEHjAcBgRVHSUABggrBgEFBQcDBAYKKwYBBAGCNwoDBDAYBgNV
HSAEETAPMA0GCyqGSIb3EgIBAwEIMCIGA1UdEQQbMBmBF3Rob21hcy5tb3llckBsbC5taXQu
ZWR1MA0GCSqGSIb3DQEBCwUAA4IBAQBwwPS4BoKbBymCVEqjxedOV4E5Fru8DwWklJ3GD7C+
wttuGXTKfy51Jdb2fySXLKSrhXZ0hM4c8gdUpOZN8SShDXFFdHt3pc5k4ZW2JBvkTv3MYDr3
UIJqQMpuKx5S/yZjOgcsIuDHzwa6Wh+YwlEa1eiJJ3KYdqKQiKUht0ogXAJK/UfbUraLTKBr
HYFAzDC5a2bgDjS4yDGfx7M1hWHAXYEqNcXp9MTPhCayleDpFAeBsNdihvFzuQfXJioY3hHl
Tf36w7GE4RMfnEHvrZzVvfZ4kDkN0Eta85cj8Oc/YtYN/j9RaFkZzw+MsygDhUDMPuyBVvdn
P6L1gdK5yCyCMYIB5TCCAeECAQEwXzBRMQswCQYDVQQGEwJVUzEfMB0GA1UEChMWTUlUIExp
bmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECxMDUEtJMRMwEQYDVQQDEwpNSVRMTCBDQS0yAgpb
npTCAAAAAE9nMAkGBSsOAwIaBQCgXTAjBgkqhkiG9w0BCQQxFgQUgb2r+yoEc4AkGjd7HeE3
Y2u1M98wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTIxMTAx
MTcwOTAyWjANBgkqhkiG9w0BAQEFAASCAQCwsBC8zGPEUDmFM1nfB5eeVW+0vSaKBmstC8jI
G2v9GA3jnTqxTzkHcl2LyPcKpOO2OLX3YTEyw/kBI1/pWY0Bsxx48SS5dBuBAQdfSgkXCGMK
fP1bklcvBeMzAsgyVZseRinHDb2vicGXPxxp/i9oTZZIl1w88+50m2PbZKRAZgkcu6efT+N1
EzniysERZXpODJQDHmLScn7zOqRrKDuRdeyxKXBGWZhunuJYxf75Y3qL4BJgjf5G961T6nzW
p39DP4R1d8/QcQ5Ulnd4PWmiMRpPzhH7r6V0FA38fDEdOIqq57SfJL2Y31pUm47YF6XGGYKG
Mt/zHh6MM5TZKRQ6

--B_3434620142_4449914--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
