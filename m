Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA07459
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2002 15:32:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA29095
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2002 19:31:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA29091
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2002 19:31:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 959AF92472
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 05:32:33 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BF6CA7513
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2002 21:32:25 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: setfiles buglet
Date: Wed, 18 Sep 2002 21:32:25 +0200
MIME-Version: 1.0
Message-Id: <200209182132.25322.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/usr/sbin/setfiles:  conflicting specifications for 
/var/spool/postfix/incoming/6/9/69AB444B and /var/www/mrtg/eth1.old, using 
system_u:object_r:postfix_spool_t.

root@caesar:~# l -i /var/spool/postfix/incoming/6/9/69AB444B
   1099 -rw-------    1 postfix  postfix         0 Sep 19 05:23 
/var/spool/postfix/incoming/6/9/69AB444B
root@caesar:~# l -i /var/www/mrtg/eth1.old
   8160 -rw-r--r--    1 root     root        58441 Sep 19 05:15 
/var/www/mrtg/eth1.old
root@caesar:~#

There is either a bug in setfiles or in it's documentation.

If run on a live system it can give inconsistant results as shown above.  In 
the example above I believe that the /var/www directory got processed first, 
then the eth1.old file was unlinked and the inode number got re-used by 
postfix.  This is on a P-133 machine and setfiles takes 6 minutes to run...

I think that either the documentation should mention that running in single 
user mode is a good idea (something I should have done when writing the man 
page), or it should stat the files again before changing the permissions 
(which still probably won't be flawless so changing the documentation is 
probably necessary).

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
