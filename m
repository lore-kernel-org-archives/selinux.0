Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA20401
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2002 19:39:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA00077
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 00:38:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA00073
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 00:38:22 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E29B69266B
	for <selinux@tycho.nsa.gov>; Thu,  7 Feb 2002 11:39:00 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id D5D1C364E8A
	for <selinux@tycho.nsa.gov>; Thu,  7 Feb 2002 10:39:36 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: stat_secure()
Date: Thu, 7 Feb 2002 09:52:08 +1000
MIME-Version: 1.0
Message-Id: <20020207003936.D5D1C364E8A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The man page for stat_secure() does not document it's behaviour when SE Linux 
is not enabled (IE you booted a non-SE kernel).

The current behaviour is not what I expected.  I first expected that 
stat_secure() would return -1 when run on a non-SE kernel.  Then when I 
discovered that it works for the regular stat() functionality I expected that 
the security_id_t *sid parameter would not be changed.

Then I had to read the docs to discover that *sid would be set to 
SECINITSID_UNLABELED.

I think that it would be preferrable for the call to return -1 or to set *sid 
to -1 to indicate that a non-SE kernel is running.  There is a big difference 
between a file being truely unlabled and the system just not supporting SE!

For my latest stat program I am forced to use is_flask_enabled() to get 
correct functionality.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
