Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA22161
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 09:55:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA23664
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 14:54:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA23660 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 14:54:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 041A192443
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 01:55:20 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 919FD22731
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:55:13 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ntp policy
Date: Wed, 20 Mar 2002 15:55:13 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1G1AUNBNCTS8JASXXZOT"
Message-Id: <20020320145513.919FD22731@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_1G1AUNBNCTS8JASXXZOT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here's my latest effort at a ntpd policy, first the file_contexts entries:
/var/lib/ntp(|/.*)              system_u:object_r:var_lib_ntp_t
/etc/ntp.conf                   system_u:object_r:etc_ntp_t
/usr/sbin/ntpd                  system_u:object_r:ntpd_exec_t
/var/log/ntpstats(|/.*)         system_u:object_r:var_log_ntp_t
/var/log/ntpd                   system_u:object_r:var_log_ntp_t

I've attached the ntp.te file.

Note that I'm using my version of uses_shlib that is as follows:
define(`uses_shlib',`
allow $1 ld_so_t:file rx_file_perms;
allow $1 ld_so_t:file execute_no_trans;
allow $1 ld_so_t:lnk_file r_file_perms;
allow $1 shlib_t:file rx_file_perms;
allow $1 shlib_t:lnk_file r_file_perms;
allow $1 ld_so_cache_t:file r_file_perms;
allow $1 lib_t:dir r_dir_perms;
')

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_1G1AUNBNCTS8JASXXZOT
Content-Type: text/plain;
  charset="us-ascii";
  name="ntp.te"
Content-Transfer-Encoding: base64
Content-Description: ntp.te
Content-Disposition: attachment; filename="ntp.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgbnRwZF90IGRv
bWFpbi4KIwp0eXBlIG50cGRfdCwgZG9tYWluLCBwcml2bG9nOwp0eXBlIG50cGRfZXhlY190LCBm
aWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKdHlwZSB2YXJfbGliX250cF90LCBmaWxl
X3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUgdmFyX2xvZ19udHBfdCwgZmlsZV90eXBlLCBzeXNhZG1m
aWxlOwp0eXBlIGV0Y19udHBfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwoKcm9sZSBzeXN0ZW1f
ciB0eXBlcyBudHBkX3Q7CgojIEluaGVyaXQgYW5kIHVzZSBkZXNjcmlwdG9ycyBmcm9tIGluaXQu
CmFsbG93IG50cGRfdCBpbml0X3Q6ZmQgaW5oZXJpdF9mZF9wZXJtczsKCmFsbG93IG50cGRfdCBp
bml0X3Q6cHJvY2VzcyBzaWdjaGxkOwoKdXNlc19zaGxpYihudHBkX3QpCmFsbG93IG50cGRfdCBy
b290X3Q6ZGlyIHJfZGlyX3Blcm1zOwoKIyBDcmVhdGUgcGlkIGZpbGUuCnR5cGUgdmFyX3J1bl9u
dHBfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBwaWRmaWxlOwpmaWxlX3R5cGVfYXV0b190cmFu
cyhudHBkX3QsIHZhcl9ydW5fdCwgdmFyX3J1bl9udHBfdCkKZmlsZV90eXBlX2F1dG9fdHJhbnMo
bnRwZF90LCB2YXJfbG9nX3QsIHZhcl9sb2dfbnRwX3QpCgphbGxvdyBudHBkX3QgeyB2YXJfbGli
X3QgdXNyX3QgfTpkaXIgcl9kaXJfcGVybXM7CmFsbG93IG50cGRfdCB1c3JfdDpmaWxlIHJfZmls
ZV9wZXJtczsKYWxsb3cgbnRwZF90IG51bGxfZGV2aWNlX3Q6Y2hyX2ZpbGUgcndfZmlsZV9wZXJt
czsKYWxsb3cgbnRwZF90IHsgdmFyX2xpYl9udHBfdCB2YXJfbG9nX250cF90IH06ZGlyIHJ3X2Rp
cl9wZXJtczsKYWxsb3cgbnRwZF90IHsgdmFyX2xpYl9udHBfdCB2YXJfbG9nX250cF90IH06Zmls
ZSByd19maWxlX3Blcm1zOwoKYWxsb3cgbnRwZF90IHNlbGY6Y2FwYWJpbGl0eSB7IHN5c190aW1l
IG5ldF9iaW5kX3NlcnZpY2UgaXBjX2xvY2sgfTsKCmFsbG93IG50cGRfdCBldGNfdDpkaXIgcl9k
aXJfcGVybXM7CmFsbG93IG50cGRfdCBldGNfdDpsbmtfZmlsZSByX2ZpbGVfcGVybXM7CmFsbG93
IG50cGRfdCBldGNfbnRwX3Q6ZmlsZSByd19maWxlX3Blcm1zOwoKIyBVc2UgdGhlIG5ldHdvcmsu
CmNhbl9uZXR3b3JrKG50cGRfdCkKYWxsb3cgbnRwZF90IGRvbWFpbjpwYWNrZXRfc29ja2V0IHJl
Y3Zmcm9tOwphbGxvdyBudHBkX3Qgc2VsZjp1bml4X2RncmFtX3NvY2tldCBjcmVhdGVfc29ja2V0
X3Blcm1zOwoKYWxsb3cgbnRwZF90IHNlbGY6cHJvY2VzcyBmb3JrOwoKZG9tYWluX2F1dG9fdHJh
bnMoaW5pdHJjX3QsIG50cGRfZXhlY190LCBudHBkX3QpCgphbGxvdyBudHBkX3QgZnNfdDpmaWxl
c3lzdGVtIGdldGF0dHI7Cg==

--------------Boundary-00=_1G1AUNBNCTS8JASXXZOT--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
