Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA25095
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 21:17:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA02384
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 01:15:32 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
        by jazzband.ncsc.mil  with ESMTP id BAA02376 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 01:15:31 GMT
Received: from jw (unknown [65.166.138.2])
	by mail.servicemail123.com (Postfix on SuSE Linux 7.1 (i386)) with ESMTP id E83C1499AA
	for <selinux@tycho.nsa.gov>; Mon,  8 Jul 2002 20:16:57 -0500 (CDT)
Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: <selinux@tycho.nsa.gov>
Subject: Is make relabel suposed to be run from policy or or setfiles?
Date: Mon, 8 Jul 2002 20:16:35 -0500
MIME-Version: 1.0
Message-Id: <200207082016.36223.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As per the instructions on http://www.nsa.gov/selinux/doc/readme.html section 16,  I rebooted into the selinux kernel, loged in as jw (who is the sysadmin, sysadm_r:sysadm_t) su'd to root (who,a ccording to the default selinux setup [which I did not change] is a 'common user', cd'd to /usr/src/selinux/policy and ran 'make relabel' with the following results:

ccs001:/usr/src/selinux/policy # make relabel
/usr/local/selinux/bin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]|reiserfs)/{print $3}'`
/usr/local/selinux/bin/setfiles:  Running on a SELinux kernel, using new system calls
/usr/local/selinux/bin/setfiles:  read 665 specifications
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:inetd_var_log_t on line number 625
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:inetd_var_log_t on line number 626
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:inetd_var_log_t on line number 637
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:inetd_var_log_t on line number 638
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:initrc_runlevel_t on line number 654
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:initrc_runlevel_t on line number 655
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:initrc_runlevel_t on line number 668
/usr/local/selinux/bin/setfiles:  invalid context system_u:object_r:initrc_runlevel_t on line number 669
make: *** [relabel] Error 1
ccs001:/usr/src/selinux/policy #

I did notice the following in /var/log/warn:

Jul  8 19:48:18 ccs001 kernel:
Jul  8 19:48:18 ccs001 kernel: avc:  denied  { write } for  pid=759 exe=/bin/su path=/dev/log dev=08:03 ino=26755 scontext=jw:sysadm_r:sysadm_su_t tcontext=system_u:object_r:device_t tclass=sock_file
Jul  8 19:48:18 ccs001 kernel:
Jul  8 19:48:18 ccs001 kernel: avc:  denied  { sendto } for  pid=759 exe=/bin/su path=/dev/log scontext=jw:sysadm_r:sysadm_su_t tcontext=system_u:system_r:initrc_t tclass=unix_dgram_socket


I noticed a post from Russel suggested that make relabel should be run from selinux/setfiles/ not selinux/policy, but I'm not sure if that's correct or not.

ccs001:/usr/src/selinux/setfiles # make relabel
chcon system_u:object_r:setfiles_exec_t /usr/local/selinux/bin/setfiles
ccs001:/usr/src/selinux/setfiles #

Is that correct? Based on some discussion I had on IRC, I think it is NOT correct.
Perhaps someone could update the web page if it is correct.
I'll also point out that step 17 (PATH changes) have to occur before you can run make relabel, because use is made of /usr/local/selinux/chcon

Just out of curiosity, why do you have to be root to do that? I have no doubt that I've much to lera here :-) but considering that 'jw' is sysadm_* and 'root' is just user_*, I would think that jw would be the proper account to run make relabel under.


- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Kjl0Q5u80xXOLBcRAv2EAJ431gypUeAcKK8KZJS9JGutL+wFRACcCrgo
slqOJh1GOr5CDofyUUQJb84=
=4n1v
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
