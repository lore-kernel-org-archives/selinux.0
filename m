Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17313
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 11:22:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA00556
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 15:20:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA00552
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 15:20:55 GMT
Date: Thu, 10 Oct 2002 11:22:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: yacc problem
In-Reply-To: <200210101651.49164.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210101121130.23968-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1144747756-1034263322=:23968"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1144747756-1034263322=:23968
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 10 Oct 2002, Russell Coker wrote:

> yacc -d policy_parse.y
> policy_parse.y:344.4: parse error, unexpected "|"
> make[1]: *** [y.tab.c] Error 1
>
> I have suddenly started getting the above error on building selinux-small
> after upgrading to the latest bison.
>
> I upgraded from bison 1.35 to 1.50 ("yacc" == "bison -y" on my system).
>
> I have attached the policy_parse.y file I am using to avoid confusion about
> which patches I have installed.

Yes, there is a spurious semicolon in the yacc file.  The attached patch
(also committed to sf CVS) removes it.  Thanks.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1144747756-1034263322=:23968
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="parse.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0210101122020.23968@raven>
Content-Description: 
Content-Disposition: attachment; filename="parse.patch"

SW5kZXg6IHNlbGludXgvbW9kdWxlL2NoZWNrcG9saWN5L3BvbGljeV9wYXJz
ZS55DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jv
b3Qvc2VsaW51eC9uc2Evc2VsaW51eC9tb2R1bGUvY2hlY2twb2xpY3kvcG9s
aWN5X3BhcnNlLnksdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjUNCmRpZmYg
LXUgLXIxLjUgcG9saWN5X3BhcnNlLnkNCi0tLSBzZWxpbnV4L21vZHVsZS9j
aGVja3BvbGljeS9wb2xpY3lfcGFyc2UueQkyNyBTZXAgMjAwMiAxOTozMjoz
MyAtMDAwMAkxLjUNCisrKyBzZWxpbnV4L21vZHVsZS9jaGVja3BvbGljeS9w
b2xpY3lfcGFyc2UueQkxMCBPY3QgMjAwMiAxNToxOTo0NSAtMDAwMA0KQEAg
LTM0MSw3ICszNDEsNiBAQA0KIAkJCXwgVDIgb3AgeyBpZiAoaW5zZXJ0X3Nl
cGFyYXRvcigxKSkgcmV0dXJuIC0xOyB9IG5hbWVzX3B1c2gNCiAJCQl7ICQk
ID0gKGludCkgZGVmaW5lX2NleHByKENFWFBSX05BTUVTLCBDRVhQUl9UWVBF
IHwgQ0VYUFJfVEFSR0VULCAkMik7DQogCQkJICBpZiAoJCQgPT0gMCkgcmV0
dXJuIC0xOyB9DQotCQkJOw0KIAkJCXwgU0FNRVVTRVINCiAJCQl7ICQkID0g
KGludCkgZGVmaW5lX2NleHByKENFWFBSX0FUVFIsIENFWFBSX1VTRVIsIENF
WFBSX0VRKTsNCiAJCQkgIGlmICgkJCA9PSAwKSByZXR1cm4gLTE7IH0NCg==
---559023410-1144747756-1034263322=:23968--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
