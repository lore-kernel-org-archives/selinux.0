Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3O3TFI4006334
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 23:29:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3O3TAVf010371
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:29:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3O3T44D010361
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 03:29:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Peter Gervai <grin@tolna.net>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: please offer your good advices / new policies: exim, dovecot, maradns, (aptitude)
Date: Thu, 24 Apr 2003 13:29:03 +1000
References: <20030423111231.GV3993@narya.grin.hu>
In-Reply-To: <20030423111231.GV3993@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304241329.03351.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In regard to your policy patch:
+# run init scripts? valid? secure?? --<g>
+#domain_auto_trans(sysadm_t, etc_t, initrc_t)

Not secure as it may allow the administrator to be tricked into running the 
daemon.  Also it does not allow role transition to system_r and the daemon 
domains would need to be allowed to be in sysadm_r, and it would have the 
daemons running with the identity of the administrative user (bad idea).

+ifdef(`exim.te', `
+allow { crond_t system_crond_t } exim_exec_t:lnk_file read;
+domain_auto_trans(system_crond_t, exim_exec_t, exim_t)
+# FIXME: is this secure?
+domain_auto_trans(crond_t, exim_exec_t, exim_t)
+')

There should be no need for a domain_auto_trans() from crond_t.  As for the 
lnk_file, it's probably best to just have the .fc file not label sym-links.

+# can start exim --<g>
+ifdef(`exim.te', `
+domain_auto_trans_read(dhcpc_t, exim_exec_t, exim_t)
+')
I don't think that this is the right way to do it.  On my laptop I have a 
script running as system_u:system_r:initrc_t that listens on a named pipe.  
When an IP address is assigned then that script is informed by the pipe and 
it will start the necessary daemons.

But I think that the correct way to do this is through a modified cron.  It's 
something I plan to work on when I have some spare time.  Modifying cardctl, 
dhcpc, and ppp policies to separately support this makes no sense to me.

-/var/run/dhclient\.pid         system_u:object_r:var_run_dhcpc_t
+/var/run/dhclient\.(.+\.)?pid          system_u:object_r:var_run_dhcpc_t
What does this do?

For port 53, I think that having the name always be named_port_t is the 
correct thing to do.  It allows the possibility of running two different DNS 
servers on different IP addresses, and also allows having the policy for 
multiple DNS servers to be loaded at the same time to allow an easy 
transition between server programs.  I suggest doing what was done for the 
POP port.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
