Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65]) by
	tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33Jnkx6002077 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 14:49:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1]) by
	jazzswing.ncsc.mil  with ESMTP id h33Jk7Ov012679 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 19:46:08 GMT
Received: from sat.sws.net.au ([202.5.161.49]) by jazzswing.ncsc.mil  with
	ESMTP id h33JjoY1012664 for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003
	19:46:06 GMT
Received: from localhost (localhost [127.0.0.1]) by sat.sws.net.au
	(Postfix) with ESMTP id 591F0BF47 for <selinux@tycho.nsa.gov>; Fri,  4 Apr
	2003 05:49:13 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1]) by localhost (sat
	[127.0.0.1:10024]) (amavisd-new) with ESMTP id 22392-04 for
	<selinux@tycho.nsa.gov>; Fri,  4 Apr 2003 05:49:12 +1000 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2]) by sat.sws.net.au
	(Postfix) with ESMTP id 1174FBF43 for <selinux@tycho.nsa.gov>; Fri,  4 Apr
	2003 05:49:12 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1]) by tsv.sws.net.au
	(Postfix) with ESMTP id BDE2192738 for <selinux@tycho.nsa.gov>; Fri,  4 Apr
	2003 05:49:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1]) by lyta.coker.com.au
	(Postfix) with ESMTP id 980A6724D for <selinux@tycho.nsa.gov>; Fri,  4 Apr
	2003 05:49:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy
Date: Fri, 4 Apr 2003 05:49:06 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <200304040549.06053.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

can_exec(crond_t, sbin_t);
Why was the above rule added to crond.te?

allow $1_t sshd_tmp_t:file create_file_perms;
The above rule from macros/user_macros.te looks dangerous.  We have the type 
sshd_tmp_t being used for all user domains.

Could the following please be added to initrc.fc:
/etc/nologin.*                 system_u:object_r:etc_runtime_t
/etc/nohotplug                 system_u:object_r:etc_runtime_t

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
