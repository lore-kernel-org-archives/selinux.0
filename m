Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14755
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 10:20:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA21214
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 14:18:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA21210 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 14:18:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2ACA892466
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 00:19:52 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 7F9263F5F
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 16:19:44 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: makefile patch
Date: Wed, 28 Aug 2002 16:19:44 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W45KGMUGB1T8SO384PZX"
Message-Id: <20020828141944.7F9263F5F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_W45KGMUGB1T8SO384PZX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

In the post-install script of my selinux-policy-default package I have the 
following:
  make -s -C /etc/selinux install
  make -s -C /etc/selinux load || true

This results in the policy being compiled twice when using the NSA Makefile, 
I've attached a patch to fix this.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_W45KGMUGB1T8SO384PZX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="makefile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="makefile.diff"

LS0tIC90bXAvcG9saWN5L01ha2VmaWxlCTIwMDItMDgtMjcgMTk6MzI6MDcuMDAwMDAwMDAwICsw
MjAwCisrKyBwb2xpY3kvTWFrZWZpbGUJMjAwMi0wOC0yOCAxNjoxNzoxMy4wMDAwMDAwMDAgKzAy
MDAKQEAgLTQ2LDEwICs0Niw4IEBACiAkKFBPTElDWVZFUik6ICB0bXAgcG9saWN5LmNvbmYgJChD
SEVDS1BPTElDWSkKIAkkKENIRUNLUE9MSUNZKSAtbyAkQCBwb2xpY3kuY29uZgogCi10bXA6Ci0J
bWtkaXIgdG1wCi0KLWluaXRyZC0kKFBPTElDWVZFUik6ICB0bXAgaW5pdHJkLXBvbGljeS5jb25m
ICQoQ0hFQ0tQT0xJQ1kpCitpbml0cmQtJChQT0xJQ1lWRVIpOiBpbml0cmQtcG9saWN5LmNvbmYg
JChDSEVDS1BPTElDWSkKKwlta2RpciAtcCB0bXAKIAkkKENIRUNLUE9MSUNZKSAtbyB0bXAvJEAg
aW5pdHJkLXBvbGljeS5jb25mCiAJZ3ppcCAtYyB0bXAvJEAgPiAkQAogCkBAIC04MSw3ICs3OSw4
IEBACiAKIGxvYWQ6IHRtcC9sb2FkCiAKLXBvbGljeS5jb25mOiB0bXAgJChQT0xJQ1lGSUxFUykg
Citwb2xpY3kuY29uZjogJChQT0xJQ1lGSUxFUykgCisJbWtkaXIgLXAgdG1wCiAJbTQgLUltYWNy
b3MgLXMgJChQT0xJQ1lGSUxFUykgPiBwb2xpY3kuY29uZgogCiBpbnN0YWxsLXNyYzogCg==

--------------Boundary-00=_W45KGMUGB1T8SO384PZX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
