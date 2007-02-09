Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19LVGHU008321
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 16:31:16 -0500
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l19LWQ8v018794
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 21:32:26 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l19LWQ8D022767
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 16:32:26 -0500
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id EA2B4BEFB
	for <selinux@tycho.nsa.gov>; Fri,  9 Feb 2007 16:32:25 -0500 (EST)
From: bsniffen@mitre.org (Brian T. Sniffen)
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: MITRE releases Polgen 1.4
References: <1169394672.10741.2.camel@zeroKnowledge>
	<m2lkj8tdn2.fsf@dreaming.mitre.org>
	<45CC87EE.9020407@mentalrootkit.com>
Date: Fri, 09 Feb 2007 16:31:23 -0500
In-Reply-To: <45CC87EE.9020407@mentalrootkit.com> (Karl MacMillan's message of
	"Fri\, 09 Feb 2007 09\:40\:46 -0500")
Message-ID: <m2k5yrrpas.fsf@dreaming.mitre.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="----6EBB909E55085E26A03BEAF0BB42327A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an S/MIME signed message

------6EBB909E55085E26A03BEAF0BB42327A
Content-Transfer-Encoding: quoted-printable

Karl MacMillan <kmacmillan@mentalrootkit.com> writes:

> Brian T. Sniffen wrote:
>>
>> Polgen handles the modularity of reference policy by searching through
>> .if files to find interfaces that will handle access requirements of
>> the program under analysis.  The technique used appears complementary
>> to Karl MacMillan's Madison library.
>
> Can you point me to the implementation inside of polgen? It would seem
> to be nice to merge this functionality into a single upstream
> implementation. Do you have any interest in pursuing this?

Absolutely.  The implementor, David Harris, is out on leave
for the next few weeks.  I believe the analogous code is in
polgen/src/patterns/{extract_ifs,refpol}.py.  We don't do everything
Sepolgen does, but we do generate new types.  I'd love to see these
capabilities merged.

=2DBrian

=2D-=20
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

------6EBB909E55085E26A03BEAF0BB42327A
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIFYQYJKoZIhvcNAQcCoIIFUjCCBU4CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCA2wwggNoMIICUKADAgECAgIENzANBgkqhkiG9w0BAQUFADBdMRIwEAYD
VQQKEwltaXRyZS5vcmcxHjAcBgNVBAsTFUNlcnRpZmljYXRlIEF1dGhvcml0eTEn
MCUGA1UEAxMeTUlUUkUgQ29ycG9yYXRpb24gUHJpbWFyeSBDQS0xMB4XDTA2MTIx
NDEzMjYwM1oXDTA4MDYwNjEzMjYwM1owWjESMBAGA1UEChMJbWl0cmUub3JnMQ8w
DQYDVQQLEwZwZW9wbGUxGDAWBgoJkiaJk/IsZAEBEwhic25pZmZlbjEZMBcGA1UE
AxMQU25pZmZlbiBCcmlhbiBULjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
tnPU2qs2ff7PV5jqHpvUqG7hvIGt+F5zeBpdtciS1eFLk04IcHTx8yHifJLX1DyX
oIDQxoD5J+mFTPvnvbA4dEJGuar+bGLrRLr0RgTS6gBVYoioZjLHVflUvHCbLv7J
elMahQUgvSP3oAcDjAFwyazd/UBPqdbSyr9hyef4kC8CAwEAAaOBuDCBtTAOBgNV
HQ8BAf8EBAMCBeAwHQYDVR0OBBYEFK9yv5EUgPtSCC1Z6FTpUkwz7YlQMB8GA1Ud
IwQYMBaAFIe0D0iNYjNCwS1RGkgewp67CrGtMEQGA1UdHwQ9MDswOaA3oDWGM2h0
dHA6Ly93d3cubWl0cmUub3JnL3RlY2gvbWlpL3BraS9jYTFfbWl0cmVfb3JnLmNy
bDAdBgNVHREEFjAUgRJic25pZmZlbkBtaXRyZS5vcmcwDQYJKoZIhvcNAQEFBQAD
ggEBABu07JqWEauvq7sxDeTbtUxEF/cYPueEhD6xAyYKZFncKE0rrcooBsPfYUF1
Ay6XgTRWwSzoGlsl03oCBooVGRM36mQW933BDJS5iaAQdXSoRRFhkAOV0I+zRVsX
nmG+B+r4XZchouf/a3oX/2QD2ptT5d/qCPquQ8B363a4BHVu9GLA1liJH9XpWxCC
z8dJNqxvfozySfq44C1hhSyjs91ywM4Z/qubfdWxBrPEsObIABoVRz5bpi3Ma3CM
r64jMSn5ApZ24T44STw2c2uyAwj3ubfRk55ytsCadthnlGCbcFdIYK8aeizm+FZ+
EAaJwjKkICIvBarZJN2h6xg0iVYxggG9MIIBuQIBATBjMF0xEjAQBgNVBAoTCW1p
dHJlLm9yZzEeMBwGA1UECxMVQ2VydGlmaWNhdGUgQXV0aG9yaXR5MScwJQYDVQQD
Ex5NSVRSRSBDb3Jwb3JhdGlvbiBQcmltYXJ5IENBLTECAgQ3MAkGBSsOAwIaBQCg
gbEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDcw
MjA5MjEzMTIzWjAjBgkqhkiG9w0BCQQxFgQUrTdC3y6EkupyKlflntW2VyOQQ3ow
UgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEB
BQAEgYAfR5e/C+K7y4Kv43OwkuaJPjX+JB154foLDFG62XFHGQc7bGcT6AN4MBRI
6MTu2iY/Lf/iG1NZQnKVG+pi9Rn6loOXHfiavS4lFJhJfi+dWBdPxCmls7xKsxXy
1oFONkUEH1qWtn86YPgF7V52msNB6fJclZ1WhLXipppJeeMhJw==

------6EBB909E55085E26A03BEAF0BB42327A--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
