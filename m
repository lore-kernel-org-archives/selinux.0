Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06803
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 15:22:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA14640
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 20:19:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA14636
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 20:19:35 GMT
Date: Wed, 26 Feb 2003 15:22:15 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Core policy, second pass
In-Reply-To: <200302262110.51204.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0302261520260.4040-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="554330684-2034360462-1046290935=:4040"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--554330684-2034360462-1046290935=:4040
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 26 Feb 2003, Russell Coker wrote:

> As for the xauth part, what is this xauth-pty-helper.te file?
>

  Wrong version of the patch. Attached is the correct version.

Thanks,

-- 
Wayne Salamon
wsalamon@tislabs.com

--554330684-2034360462-1046290935=:4040
Content-Type: TEXT/plain; name="diff.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0302261522150.4040@vox.gw.tislabs.com>
Content-Description: 
Content-Disposition: attachment; filename="diff.txt"

SW5kZXg6IHN1X21hY3Jvcy50ZQ0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvcG9saWN5L21hY3Jvcy9wcm9n
cmFtL3N1X21hY3Jvcy50ZSx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuOQ0K
ZGlmZiAtdSAtcjEuOSBzdV9tYWNyb3MudGUNCi0tLSBzdV9tYWNyb3MudGUJ
MjAwMy8wMS8yNyAxOToxNTo1NwkxLjkNCisrKyBzdV9tYWNyb3MudGUJMjAw
My8wMi8yNiAyMDoyMDowNA0KQEAgLTYxLDcgKzYxLDkgQEANCiBhbGxvdyAk
MV9zdV90ICQxX2hvbWVfZGlyX3Q6ZGlyIHNlYXJjaDsNCiANCiAjIE1vZGlm
eSAuWGF1dGhvcml0eSBmaWxlICh2aWEgeGF1dGggcHJvZ3JhbSkuDQoraWZk
ZWYoYHhhdXRoLnRlJywgYA0KIGRvbWFpbl9hdXRvX3RyYW5zKCQxX3N1X3Qs
IHhhdXRoX2V4ZWNfdCwgJDFfeGF1dGhfdCkNCisnKQ0KIA0KICMgQWNjZXNz
IHNzaGQgY29va2llIGZpbGVzLg0KIGFsbG93ICQxX3N1X3Qgc3NoZF90bXBf
dDpkaXIgcndfZGlyX3Blcm1zOw0K
--554330684-2034360462-1046290935=:4040--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
