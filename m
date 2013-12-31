Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBV7XTgf001338
 for <selinux@tycho.nsa.gov>; Tue, 31 Dec 2013 02:33:29 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so12379283pbc.13
 for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2013 23:33:26 -0800 (PST)
Received: from [192.168.0.6] (ip24-253-3-239.lv.lv.cox.net. [24.253.3.239])
 by mx.google.com with ESMTPSA id sg1sm86308681pbb.16.2013.12.30.23.33.24
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 30 Dec 2013 23:33:25 -0800 (PST)
Message-ID: <52C27333.3060801@networkcrypt.com>
Date: Mon, 30 Dec 2013 23:33:07 -0800
From: Francis Cunnane <frankc@networkcrypt.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org>
In-Reply-To: <52C235CA.2010607@mthode.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha1; boundary="------------ms020109050808000204050504"
Reply-To: frankc@networkcrypt.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a cryptographically signed message in MIME format.

--------------ms020109050808000204050504
Content-Type: multipart/alternative;
 boundary="------------080305030102020503050505"

This is a multi-part message in MIME format.
--------------080305030102020503050505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

What do you propose....  This is free software.... Don't be a Jew.

   On 12/30/2013 7:11 PM, Matthew Thode wrote:
> On 12/30/2013 10:11 AM, Stephen Smalley wrote:
>> Calling *setfilecon() with a NULL context is a bug in the caller, just=

>> like calling strlen() with a NULL string.
>> Fix the callers, please.
>>
>> On Wed, Dec 25, 2013 at 9:36 AM, Nicolas Iooss <nicolas.iooss@m4x.org>=
 wrote:
>>> 2013/12/23 Daniel J Walsh wrote:
>>>> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
>>>>> My first message was not so clear. The check in
>>>>> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
>>>>> selinux_trans_to_raw_context(context, &rcontext) returns 0 and sets=

>>>>> rcontext to NULL. This is why I'm asking to change the return value=
 to
>>>>> something else if you want "cp -a" working. This fix is not to intr=
oduce a
>>>>> new feature but to fix an existing one.
>>>>>
>>>>> Nicolas
>>>>>
>>>> How about if we add a check on lsetfilecon_raw?  Changing the behavi=
our on
>>>> selinux_trans_to_raw_context might cause other problems.
>>> I agree. I've found
>>> http://selinuxproject.org/page/LibselinuxAPISummary which says
>>> precisely for selinux_trans_to_raw_context: "If passed NULL, sets the=

>>> returned context to NULL and returns 0." As this feature is
>>> documented, callers may rely on it and changing this behavior is
>>> likely to break things.
>>>
>>> Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-pointe=
r
>>> dereference issue. Do these functions need a patch too?
>>>
>>> By the way, other callers of selinux_trans_to_raw_context may also
>>> share this bug: avc_context_to_sid, security_canonicalize_context,
>>> security_check_context, etc. Is doing a segmentation fault the
>>> expected way to tell the caller it used a NULL pointer and should hav=
e
>>> manually checked every parameter before calling any libselinux
>>> function?
>>>
>>> Thanks and merry Christmas!
>>>
>>> Nicolas
>>>
>>>>
>>>> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilec=
on.c
>>>> index 461e3f7..af3775e 100644
>>>> - --- a/libselinux/src/lsetfilecon.c
>>>> +++ b/libselinux/src/lsetfilecon.c
>>>> @@ -9,6 +9,10 @@
>>>>
>>>>   int lsetfilecon_raw(const char *path, const security_context_t con=
text)
>>>>   {
>>>> +       if (! context) {
>>>> +               errno=3DEINVAL;
>>>> +               return -1;
>>>> +       }
>>>>          return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(=
context) + 1
>>>>                           0);
>>>>   }
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho=
=2Ensa.gov.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
>>
> I think I may have hit this bug as well.
>
> https://bugs.gentoo.org/show_bug.cgi?id=3D495274
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.


--------------080305030102020503050505
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">What do you propose....&nbsp; This is =
free
      software.... Don't be a Jew.<br>
      <br>
      &nbsp; On 12/30/2013 7:11 PM, Matthew Thode wrote:<br>
    </div>
    <blockquote cite=3D"mid:52C235CA.2010607@mthode.org" type=3D"cite">
      <pre wrap=3D"">On 12/30/2013 10:11 AM, Stephen Smalley wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Calling *setfilecon() with a NULL context is a bug=
 in the caller, just
like calling strlen() with a NULL string.
Fix the callers, please.

On Wed, Dec 25, 2013 at 9:36 AM, Nicolas Iooss <a class=3D"moz-txt-link-r=
fc2396E" href=3D"mailto:nicolas.iooss@m4x.org">&lt;nicolas.iooss@m4x.org&=
gt;</a> wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">2013/12/23 Daniel J Walsh wrote:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">
On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
</pre>
            <blockquote type=3D"cite">
              <pre wrap=3D"">My first message was not so clear. The check=
 in
libselinux/src/lsetfilecon.c line 35 [1] doesn't work because
selinux_trans_to_raw_context(context, &amp;rcontext) returns 0 and sets
rcontext to NULL. This is why I'm asking to change the return value to
something else if you want "cp -a" working. This fix is not to introduce =
a
new feature but to fix an existing one.

Nicolas

</pre>
            </blockquote>
            <pre wrap=3D"">
How about if we add a check on lsetfilecon_raw?  Changing the behaviour o=
n
selinux_trans_to_raw_context might cause other problems.
</pre>
          </blockquote>
          <pre wrap=3D"">
I agree. I've found
<a class=3D"moz-txt-link-freetext" href=3D"http://selinuxproject.org/page=
/LibselinuxAPISummary">http://selinuxproject.org/page/LibselinuxAPISummar=
y</a> which says
precisely for selinux_trans_to_raw_context: "If passed NULL, sets the
returned context to NULL and returns 0." As this feature is
documented, callers may rely on it and changing this behavior is
likely to break things.

Moreover setfilecon_raw and fsetfilecon_raw have the same NULL-pointer
dereference issue. Do these functions need a patch too?

By the way, other callers of selinux_trans_to_raw_context may also
share this bug: avc_context_to_sid, security_canonicalize_context,
security_check_context, etc. Is doing a segmentation fault the
expected way to tell the caller it used a NULL pointer and should have
manually checked every parameter before calling any libselinux
function?

Thanks and merry Christmas!

Nicolas

</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">

diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index 461e3f7..af3775e 100644
- --- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -9,6 +9,10 @@

 int lsetfilecon_raw(const char *path, const security_context_t context)
 {
+       if (! context) {
+               errno=3DEINVAL;
+               return -1;
+       }
        return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(contex=
t) + 1
                         0);
 }
</pre>
          </blockquote>
          <pre wrap=3D"">
_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.
</pre>
        </blockquote>
        <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.

</pre>
      </blockquote>
      <pre wrap=3D"">I think I may have hit this bug as well.

<a class=3D"moz-txt-link-freetext" href=3D"https://bugs.gentoo.org/show_b=
ug.cgi?id=3D495274">https://bugs.gentoo.org/show_bug.cgi?id=3D495274</a>

</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080305030102020503050505--

--------------ms020109050808000204050504
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
BwEwHAYJKoZIhvcNAQkFMQ8XDTEzMTIzMTA3MzMwN1owIwYJKoZIhvcNAQkEMRYEFCjBwB/m
BK+dFt+LV+Ou97mq1mZNMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4D
AgcwDQYIKoZIhvcNAwICASgwgboGCSsGAQQBgjcQBDGBrDCBqTCBkzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAOEtgEtOQn3CQDAg7XarCEcwgbwGCyqGSIb3
DQEJEAILMYGsoIGpMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
AhEA4S2AS05CfcJAMCDtdqsIRzANBgkqhkiG9w0BAQEFAASCAQC8Kb8FTCymxDFdAOq5hf99
jFYtayQO2r4dIKwLEybpoY5/m1zxqESMyJqPhFEfU5SOvLmfSOBEfkHEhVfetpNy6KG08UwT
JBc+VOcS4dVhdwK8eXeq+pn9WBK29XBszFEtLWSQ+RW17VouNYrFqVGI3wqwfLZmhZJR/m2x
j/WDPFJPBKPE0XWxsUeG71T494Dzk1CPdPyEWqXx3daBFG678cyc9pv1emVbcKGcfSLT3ZS5
L//aa3vVwLIVYIbgYj980cerQm5ue2T5fENWIa3LQ/qn0m5tgIiUcbE6zl5+/TahO/D8zmUE
HKOK9DRgDoaaQqwd2gEdn6iAc30L1cmaAAAAAAAA
--------------ms020109050808000204050504--
