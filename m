Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA08149
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 07:19:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA20552
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 12:18:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA20547 for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 12:18:27 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8284D92675
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 23:19:14 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8EA77286E2
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 13:19:02 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: nscd
Date: Sun, 24 Feb 2002 04:49:56 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8NQ0A8K8I3G9BSUZ2YLS"
Message-Id: <20020224121902.8EA77286E2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_8NQ0A8K8I3G9BSUZ2YLS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Subject: 

I have just created some rules for nscd (the name service caching daemon).

In domains/system/initrc.te I put the following:
domain_auto_trans(initrc_t, nscd_exec_t, nscd_t)

I put the following in file_contexts:
/usr/sbin/nscd                  system_u:object_r:nscd_exec_t

I have attached my nscd.te file.

I believe that the recent versions of nscd (and the matching library code in 
libc6) doesn't attempt to cache /etc/shadow data.  If this isn't the case 
then it's a security issue which would have to be corrected on an SE system 
(or else nscd should not be run).  I have to check this (don't have access to 
the source right now).

In a typical setup of nscd you will have a somewhat slow source of password 
data (LDAP or a SQL database) and the nscd will cache lookups so that
"ls -l /tmp" doesn't take all day.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--------------Boundary-00=_8NQ0A8K8I3G9BSUZ2YLS
Content-Type: text/plain;
  charset="us-ascii";
  name="nscd.te"
Content-Transfer-Encoding: base64
Content-Description: nscd.te
Content-Disposition: attachment; filename="nscd.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgbnNjZF90IGRv
bWFpbi4KIwp0eXBlIG5zY2RfdCwgZG9tYWluLCBwcml2bG9nOwp0eXBlIG5zY2RfZXhlY190LCBm
aWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKCiMgSW5oZXJpdCBhbmQgdXNlIGRlc2Ny
aXB0b3JzIGZyb20gaW5pdC4KYWxsb3cgbnNjZF90IGluaXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1z
OwoKIyBDcmVhdGUgcGlkIGZpbGUuCnR5cGUgbnNjZF92YXJfcnVuX3QsIGZpbGVfdHlwZSwgc3lz
YWRtZmlsZSwgcGlkZmlsZTsKZmlsZV90eXBlX2F1dG9fdHJhbnMobnNjZF90LCB2YXJfcnVuX3Qs
IG5zY2RfdmFyX3J1bl90KQoKY2FuX3VuaXhfY29ubmVjdChkb21haW4sIG5zY2RfdCkKYWxsb3cg
ZG9tYWluIG5zY2RfdmFyX3J1bl90OnNvY2tfZmlsZSByd19maWxlX3Blcm1zOwo=

--------------Boundary-00=_8NQ0A8K8I3G9BSUZ2YLS--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
