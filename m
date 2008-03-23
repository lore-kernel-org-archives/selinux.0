Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2NDZrSL006029
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 09:35:53 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2NDZitS017616
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 13:35:50 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 5DFCA18C6E
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 00:35:42 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc1MtuvQb99g for <selinux@tycho.nsa.gov>;
	Mon, 24 Mar 2008 00:35:42 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id DE5F218547
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 00:35:41 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9547721B30
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 00:35:40 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: /bin/passwd and a basic MLS install of Fedora 8
Date: Mon, 24 Mar 2008 00:35:38 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803240035.40028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/newgrp
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rcp
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rlogin
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/bin/rsh
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/kerberos/bin/ksu
-rwsr-xr-x  root root 
system_u:object_r:bin_t:SystemLow /usr/sbin/ccreds_validate
-rws--x--x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/userhelper
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/userisdnctl
-rwsr-xr-x  root root system_u:object_r:bin_t:SystemLow /usr/sbin/usernetctl


/tmp/a.out is a test program I wrote which calls setresuid(0,0,0); 
system("/bin/bash");  But for the sake of discussion, let's assume it's one 
of the above programs (from a minimal install of Fedora 8) which has been 
cracked.  Of course it could also be one of the other SUID root programs 
which are probably installed in a default or typical install but which have 
no special labelling.

$ ls -lZ /tmp/a.out
-rwsr-xr-x  root test user_u:object_r:bin_t:SystemLow  /tmp/a.out
$ /tmp/a.out
# id
uid=0(root) gid=500(test) groups=500(test) 
context=user_u:user_r:user_t:SystemLow
# passwd
Changing password for user root.
New UNIX password:
BAD PASSWORD: it is too short
Retype new UNIX password:
passwd: all authentication tokens updated successfully.


Then of course I just ssh back in to the machine as root and get the context 
root:sysadm_r:sysadm_t:SystemLow:SystemLow-SystemHigh.


It seems to me that a reasonable way of preventing this particular attack (and 
many others of a similar nature) is to have /bin/passwd check which identity 
may be used for a login of the account which is getting it's password (or 
finger name or shell) changed and then verify that it matches the identity 
used to run /bin/passwd.  So for example if you change the password for 
the "root" account then merely having UID=0 should not be sufficient, but 
also having an identity of "root" (in the case of the default MLS policy) 
would be required.

One possible ways of mitigating this are to cause domain transitions on every 
execution of a SUID root program by labelling them all in an appropriate 
manner (maybe even with a non_exec_t type for ones which can't be properly 
supported with the policy that is running).  This could be helped by denying 
user_t access to the setuid capability.

But then we have programs such as crontab which by design will run programs in 
a different UID and if tricked into choosing the wrong UID will bring the 
same problem back.  This is not to say that relabelling some of the programs 
such as rcp, rlogin, etc isn't a good idea - merely that I don't think it 
removes the need for extra checks in /bin/passwd.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
