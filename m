Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12959
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 11:34:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA19145
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 16:33:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA19141 for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 16:33:07 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 23E0D92495
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 03:34:07 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B5DC127D29
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 17:33:00 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ldconfig policy
Date: Sun, 24 Mar 2002 17:32:59 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZMKHWQR4YMFMC5D5RRT2"
Message-Id: <20020324163359.B5DC127D29@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_ZMKHWQR4YMFMC5D5RRT2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

/sbin/ldconfig                  system_u:object_r:ldconfig_exec_t

I've attached the policy file.  I had to make appropriate adjustments to the 
assert.te file to match.

The purpose of this new domain is to ensure that sym-links and the 
/etc/ld.so.cache file created by ldconfig get the right types.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_ZMKHWQR4YMFMC5D5RRT2
Content-Type: text/plain;
  charset="us-ascii";
  name="ldconfig.te"
Content-Transfer-Encoding: base64
Content-Description: ldconfig.te
Content-Disposition: attachment; filename="ldconfig.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgbGRjb25maWdf
dCBkb21haW4uCiMKdHlwZSBsZGNvbmZpZ190LCBkb21haW4sIHByaXZsb2c7CnR5cGUgbGRjb25m
aWdfZXhlY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4ZWNfdHlwZTsKCnJvbGUgc3lzYWRt
X3IgdHlwZXMgbGRjb25maWdfdDsKcm9sZSBzeXN0ZW1fciB0eXBlcyBsZGNvbmZpZ190OwoKZG9t
YWluX2F1dG9fdHJhbnMoeyBzeXNhZG1fdCBpbml0cmNfdCB9LCBsZGNvbmZpZ19leGVjX3QsIGxk
Y29uZmlnX3QpCgp1c2VzX3NobGliKGxkY29uZmlnX3QpCgpmaWxlX3R5cGVfYXV0b190cmFucyhs
ZGNvbmZpZ190LCBldGNfdCwgbGRfc29fY2FjaGVfdCkKZmlsZV90eXBlX2F1dG9fdHJhbnMobGRj
b25maWdfdCwgbGliX3QsIHNobGliX3QpCgphbGxvdyBsZGNvbmZpZ190IHsgdXNlcl90IHN5c2Fk
bV90IH06ZmQgdXNlOwphbGxvdyBsZGNvbmZpZ190IGV0Y190OmZpbGUgcl9maWxlX3Blcm1zOwoK


--------------Boundary-00=_ZMKHWQR4YMFMC5D5RRT2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
