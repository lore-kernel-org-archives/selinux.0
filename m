Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00918
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 11:27:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA29065
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 16:26:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA29061 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 16:26:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Squid policy for SE Linux
Date: Wed, 6 Mar 2002 17:27:25 +0100
Cc: miquels@cistron.nl
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PD8K6ON3OWPGL4QVTYJG"
Message-Id: <20020306162726.12F7E1EEA2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_PD8K6ON3OWPGL4QVTYJG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached my squid.te file.

Here's the relevant parts of my file_contexts file:
/var/cache/squid(|/.*)          system_u:object_r:httpd_cache_t
/usr/lib/squid                  system_u:object_r:squid_t
/usr/sbin/squid                 system_u:object_r:squid_exec_t
/var/log/squid                  system_u:object_r:var_log_squid_t

I also added squid_t to system_r in the rbac file.

I also had to make a couple of minor changes to the squid start script 
(hacked Debian start script attached).

Firstly I made the script change the uid/gid of squid because I didn't want 
to grant setuid capability to the squid binary.

Then I changed the script to do a "cd /" before starting squid instead of
"cd /var/cache/squid" because the /var/cache/squid directory is not readable 
by the initrc_t domain.

Please let me know of any suggestions for improvements.  NSA People, please 
include this in the sample policy if it's good enough.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_PD8K6ON3OWPGL4QVTYJG
Content-Type: text/plain;
  charset="us-ascii";
  name="squid.te"
Content-Transfer-Encoding: base64
Content-Description: squid.te
Content-Disposition: attachment; filename="squid.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgc3F1aWRfdCBk
b21haW4uCiMKIyBzcXVpZF90IGlzIHRoZSBkb21haW4gdGhlIHNxdWlkIHByb2Nlc3MgcnVucyBp
biwgYW5kIGlzIGFsc28gdGhlIFNJRCBmb3IKIyBmaWxlcyBpbiAvdXNyL2xpYi9zcXVpZAp0eXBl
IHNxdWlkX3QsIGRvbWFpbiwgcHJpdmxvZzsKIyB2YXJfbG9nX3NxdWlkX3QgaXMgZm9yIC92YXIv
bG9nL3NxdWlkCnR5cGUgdmFyX2xvZ19zcXVpZF90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CiMg
bWFpbiBzcXVpZCBiaW5hcnkgaXMgb2Ygc3F1aWRfZXhlY190CnR5cGUgc3F1aWRfZXhlY190LCBm
aWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKCiMgSW5oZXJpdCBhbmQgdXNlIGRlc2Ny
aXB0b3JzIGZyb20gaW5pdC4KYWxsb3cgc3F1aWRfdCBpbml0X3Q6ZmQgaW5oZXJpdF9mZF9wZXJt
czsKCiMgQ3JlYXRlIHBpZCBmaWxlLgp0eXBlIHNxdWlkX3Zhcl9ydW5fdCwgZmlsZV90eXBlLCBz
eXNhZG1maWxlLCBwaWRmaWxlOwpmaWxlX3R5cGVfYXV0b190cmFucyhzcXVpZF90LCB2YXJfcnVu
X3QsIHNxdWlkX3Zhcl9ydW5fdCkKCiMgaHR0cGRfY2FjaGVfdCBpcyBmb3IgL3Zhci9jYWNoZS9z
cXVpZAphbGxvdyBzcXVpZF90IGh0dHBkX2NhY2hlX3Q6ZGlyIGNyZWF0ZV9kaXJfcGVybXM7CmFs
bG93IHNxdWlkX3QgaHR0cGRfY2FjaGVfdDpmaWxlIHJ3X2ZpbGVfcGVybXM7CmZpbGVfdHlwZV9h
dXRvX3RyYW5zKHNxdWlkX3QsIGh0dHBkX2NhY2hlX3QsIGh0dHBkX2NhY2hlX3QpCgphbGxvdyBz
cXVpZF90IHZhcl9sb2dfc3F1aWRfdDpkaXIgcndfZGlyX3Blcm1zOwphbGxvdyBzcXVpZF90IHZh
cl9sb2dfc3F1aWRfdDpmaWxlIHJ3X2ZpbGVfcGVybXM7CmZpbGVfdHlwZV9hdXRvX3RyYW5zKHNx
dWlkX3QsIHZhcl9sb2dfc3F1aWRfdCwgdmFyX2xvZ19zcXVpZF90KQoKIyBmb3IgL3Vzci9saWIv
c3F1aWQKYWxsb3cgc3F1aWRfdCBzcXVpZF90OmRpciByX2Rpcl9wZXJtczsKYWxsb3cgc3F1aWRf
dCBzcXVpZF90OmZpbGUgcl9maWxlX3Blcm1zOwoKY2FuX25ldHdvcmsoc3F1aWRfdCkKIyBwb3J0
IDgwODAgaXMgaHR0cF9wb3J0CmFsbG93IHNxdWlkX3QgaHR0cF9wb3J0X3Q6dGNwX3NvY2tldCBu
YW1lX2JpbmQ7CmFsbG93IHNxdWlkX3Qgc3F1aWRfdDpmaWxlIHsgZXhlY3V0ZV9ub190cmFucyBl
eGVjdXRlIH07CmFsbG93IHNxdWlkX3Qgc3F1aWRfZXhlY190OmZpbGUgZXhlY3V0ZV9ub190cmFu
czsKCmRvbWFpbl9hdXRvX3RyYW5zKGluaXRyY190LCBzcXVpZF9leGVjX3QsIHNxdWlkX3QpCg==

--------------Boundary-00=_PD8K6ON3OWPGL4QVTYJG
Content-Type: application/x-shellscript;
  name="squid"
Content-Transfer-Encoding: base64
Content-Description: squid
Content-Disposition: attachment; filename="squid"

IyEgL2Jpbi9zaAojCiMgc3F1aWQJCVN0YXJ0dXAgc2NyaXB0IGZvciB0aGUgU1FVSUQgSFRUUCBw
cm94eS1jYWNoZS4KIwojIFZlcnNpb246CUAoIylzcXVpZC5yYyAgMi4yMCAgMDEtT2N0LTIwMDEg
IG1pcXVlbHNAY2lzdHJvbi5ubAojCgpOQU1FPXNxdWlkCkRBRU1PTj0vdXNyL3NiaW4vc3F1aWQK
TElCPS91c3IvbGliL3NxdWlkClBJREZJTEU9L3Zhci9ydW4vJE5BTUUucGlkClNRVUlEX0FSR1M9
Ii1EIC1zWUMiCgpbICEgLWYgL2V0Yy9kZWZhdWx0L3NxdWlkIF0gfHwgLiAvZXRjL2RlZmF1bHQv
c3F1aWQKClBBVEg9L2JpbjovdXNyL2Jpbjovc2JpbjovdXNyL3NiaW4KClsgLXggJERBRU1PTiBd
IHx8IGV4aXQgMAoKZ3JlcGNvbmYyICgpIHsKCXc9IiAJIiAjIHNwYWNlIHRhYgoJc3E9L2V0Yy8k
TkFNRS5jb25mCgkjIHNlZCBpcyBjb29sLgoJcmVzPWBzZWQgLW5lICcKCQlzL14nJDEnWyciJHci
J11cK1teJyIkdyInXVwrWyciJHciJ11cK1woW14nIiR3IiddXCtcKS4qJC9cMS9wOwoJCXQgZW5k
OwoJCWQ7CgkJOmVuZCBxJyA8ICRzcWAKCVsgLW4gIiRyZXMiIF0gfHwgcmVzPSQyCgllY2hvICIk
cmVzIgp9CgojCiMJVHJ5IHRvIGluY3JlYXNlIHRoZSAjIG9mIGZpbGVkZXNjcmlwdG9ycyB3ZSBj
YW4gb3Blbi4KIwptYXhmZHMgKCkgewoJWyAtbiAiJFNRVUlEX01BWEZEIiBdIHx8IHJldHVybgoJ
WyAtZiAvcHJvYy9zeXMvZnMvZmlsZS1tYXggXSB8fCByZXR1cm4gMAoJWyAkU1FVSURfTUFYRkQg
LWxlIDQwOTYgXSB8fCBTUVVJRF9NQVhGRD00MDk2CglnbG9iYWxfZmlsZV9tYXg9YGNhdCAvcHJv
Yy9zeXMvZnMvZmlsZS1tYXhgCgltaW5pbWFsX2ZpbGVfbWF4PSQoKCRTUVVJRF9NQVhGRCArIDQw
OTYpKQoJaWYgWyAiJGdsb2JhbF9maWxlX21heCIgLWx0ICRtaW5pbWFsX2ZpbGVfbWF4IF0KCXRo
ZW4KCQllY2hvICRtaW5pbWFsX2ZpbGVfbWF4ID4gL3Byb2Mvc3lzL2ZzL2ZpbGUtbWF4CglmaQoJ
dWxpbWl0IC1uICRTUVVJRF9NQVhGRAp9CgpzdGFydCAoKSB7CgljZHI9YGdyZXBjb25mMiBjYWNo
ZV9kaXIgL3Zhci9zcG9vbC8kTkFNRWAKCWNhc2UgIiRjZHIiIGluCgkJWzAtOV0qKQoJCQllY2hv
IC1uICJzcXVpZDogc3F1aWQuY29uZiBjb250YWlucyAyLjIuNSBzeW50YXggIiA+JjIKCQkJZWNo
byAiY2FjaGVfZGlyIGRpcmVjdGl2ZSAtIG5vdCBzdGFydGluZyIgPiYyCgkJCWV4aXQgMQoJCQk7
OwoJZXNhYwoJbWF4ZmRzCgl1bWFzayAwMjcKIwljZCAkY2RyCmNkIC8KCXN0YXJ0LXN0b3AtZGFl
bW9uIC0tcXVpZXQgLS1zdGFydCBcCgkJLS1waWRmaWxlICRQSURGSUxFIC0tY2h1aWQgcHJveHkg
XAoJCS0tZXhlYyAkREFFTU9OIC0tICRTUVVJRF9BUkdTIDwgL2Rldi9udWxsCglzbGVlcCAxCn0K
CnN0b3AgKCkgewoJUElEPWBjYXQgJFBJREZJTEUgMj4vZGV2L251bGxgCglzdGFydC1zdG9wLWRh
ZW1vbiAtLXN0b3AgLS1xdWlldCAtLXBpZGZpbGUgJFBJREZJTEUgLS1leGVjICREQUVNT04KCSMK
CSMJTm93IHdlIGhhdmUgdG8gd2FpdCB1bnRpbCBzcXVpZCBoYXMgX3JlYWxseV8gc3RvcHBlZC4K
CSMKCXNsZWVwIDIKCWlmIHRlc3QgLW4gIiRQSUQiICYmIGtpbGwgLTAgJFBJRCAyPi9kZXYvbnVs
bAoJdGhlbgoJCWVjaG8gLW4gIldhaXRpbmcgLiIKCQljbnQ9MAoJCXdoaWxlIGtpbGwgLTAgJFBJ
RCAyPi9kZXYvbnVsbAoJCWRvCgkJCWNudD1gZXhwciAkY250ICsgMWAKCQkJaWYgWyAkY250IC1n
dCA2MCBdCgkJCXRoZW4KCQkJCSMKCQkJCSMJV2FpdGVkIDEyMCBzZWNvbmRzIG5vdy4gRmFpbC4K
CQkJCSMKCQkJCWVjaG8gLW4gIiBGYWlsZWQuLiAiCgkJCQlicmVhawoJCQlmaQoJCQlzbGVlcCAy
CgkJCWVjaG8gLW4gIi4iCgkJZG9uZQoJCVsgIiQxIiA9IHZlcmJvc2UgXSAmJiBlY2hvICJkb25l
LiIKCWVsc2UKCQlbICIkMSIgPSB2ZXJib3NlIF0gJiYgZWNobyAiJE5BTUUuIgoJZmkKfQoKY2Fz
ZSAiJDEiIGluCiAgICBzdGFydCkKCWVjaG8gLW4gIlN0YXJ0aW5nIHByb3h5IHNlcnZlcjogIgoJ
c3RhcnQKCWVjaG8gIiROQU1FLiIKCTs7CiAgICBzdG9wKQoJZWNobyAtbiAiU3RvcHBpbmcgcHJv
eHkgc2VydmVyOiAiCglzdG9wIHZlcmJvc2UKCTs7CiAgICByZWxvYWR8Zm9yY2UtcmVsb2FkKQoJ
ZWNobyAiUmVsb2FkaW5nICROQU1FIGNvbmZpZ3VyYXRpb24gZmlsZXMiCglzdGFydC1zdG9wLWRh
ZW1vbiAtLXN0b3AgLS1zaWduYWwgMSBcCgkJLS1waWRmaWxlICRQSURGSUxFIC0tcXVpZXQgLS1l
eGVjICREQUVNT04KCTs7CiAgICByZXN0YXJ0KQoJZWNobyAiUmVzdGFydGluZyBwcm94eSBzZXJ2
ZXI6ICIKCXN0b3AKCXN0YXJ0CgllY2hvICIkTkFNRS4iCgk7OwogICAgKikKCWVjaG8gIlVzYWdl
OiAvZXRjL2luaXQuZC8kTkFNRSB7c3RhcnR8c3RvcHxyZWxvYWR8Zm9yY2UtcmVsb2FkfHJlc3Rh
cnR9IgoJZXhpdCAxCgk7Owplc2FjCgpleGl0IDAKCg==

--------------Boundary-00=_PD8K6ON3OWPGL4QVTYJG--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
