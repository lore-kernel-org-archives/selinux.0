Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RAsvsJ005566
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 06:54:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8RAsuCG011798
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 10:54:56 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8RAssqJ011795 for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 10:54:55 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id B4A72C164
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:54:53 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24683-05 for <selinux@tycho.nsa.gov>;
 Sat, 27 Sep 2003 20:54:52 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id BF836C163
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:54:52 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 568EA924D6
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:54:52 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 233597F04B
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:54:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: unlabeled_t and assert.te
Date: Sat, 27 Sep 2003 20:54:50 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309272054.50553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

type unlabeled_t, fs_type, file_type, root_dir_type, sysadmfile;

Currently unlabeled_t is defined as above.  I have been experimenting with the 
below assertions to fix some instances of stupidity in policy writing (I have 
found two mistakes in policy I wrote already).

The problem is that as unlabeled_t has attribute file_type I can't assert that 
file_type may not be a tcontext of a process operation.  I believe that 
although unlabeled_t often refers to files (probably it mostly refers to 
files) it has a special status and therefore does not deserve the file_type 
attribute.  So I have defined it as only having the sysadmfile attribute (to 
allow the administrator to fix problems), and I am considering giving it the 
"domain" attribute as well.

But it occurs to me that this may be a symptom of an error in design.  An 
unlabeled process is quite a different thing from an unlabeled file.  
Allowing read access to unlabeled files and directories on a file system has 
different implications than allowing "ps" to show unlabeled processes.  I 
think that the correct solution to this requires a kernel change to have 
unlabeled_process_t and unlabeled_file_t (or other names as considered 
appropriate).

#
# for gross mistakes in policy
neverallow * domain:dir ~r_dir_perms;
neverallow * domain:file_class_set ~rw_file_perms;
neverallow * file_type:process *;
neverallow ~{ domain unlabeled_t } *:process *;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
