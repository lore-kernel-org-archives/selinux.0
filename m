Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19665
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:04:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05774
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:01:42 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id WAA05768
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:01:41 GMT
Received: from BATMAN ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.11.4/8.9.3) with ESMTP id h1OM4qC06873
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:04:52 -0500
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: some random policy observations
Date: Mon, 24 Feb 2003 17:04:47 -0500
Message-ID: <004901c2dc50$c208b480$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've taught a couple of classes on policy development, coupled with
some of our own analysis, which resulted with the following
observations.  I haven't spent any time trying to validate these, but
since others are crawling through the policy now perhaps someone can
check these out.  (There were other observations I haven't dug out of my
notes yet!) 

1. dpkg_t has load_policy access to security_t security object.
Probably a legacy problem; seems like it should use the load_policy
program, which is the only one that needs this access.  

2. checkpolicy_t and load_policy_t try hard to prevent their domain from
being able to read from random file types (to avoid possible threats of
them being convinced to read the incorrect data files as policy
source/binary files).  Right now they both have read access to admin
terminal devices; any reason why that access can't be changed to just
write (e.g., for standard output/error only) to avoid potential of using
stadin as their data source?

3. Related, we might want to change the compile option for some program
(e.g., load_policy and checkpolicy) so they're statically linked.  This
not only removes the potential threat of intercepting their linking
process, but also allows us to remove the shared libraries as another
type of file that can be read.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
