Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9H3RmWt007018
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 23:27:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9H3RlmR002017
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 03:27:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9H3Rjjp002014 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 03:27:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos Anisio Monteiro <monteiro@ipen.br>, selinux@tycho.nsa.gov
Subject: Re: process context
Date: Fri, 17 Oct 2003 13:27:31 +1000
References: <3F8EEA16.8090908@ipen.br>
In-Reply-To: <3F8EEA16.8090908@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310171327.31980.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 04:57, Carlos Anisio Monteiro wrote:
> The system have many process running in the following context:
> system_u:system_r:kernel_t (see example below).
>
>  PID CONTEXT                                  COMMAND
>   250 system_u:system_r:kernel_t               /sbin/syslogd
>   253 system_u:system_r:kernel_t               /sbin/klogd
>   262 system_u:system_r:kernel_t               /usr/sbin/inetd
>   346 system_u:system_r:kernel_t               sendmail: MTA: accepting
> connections
>   373 system_u:system_r:kernel_t               /usr/sbin/cron
>   378 system_u:system_r:kernel_t               /sbin/getty 38400 tty2
>   379 system_u:system_r:kernel_t               /sbin/getty 38400 tty3
>
> This is happen in the time of boot.

I guess that at boot time the init process (usually /sbin/init) was not 
labeled with init_exec_t, that caused init to be run in kernel_t.

root@lyta:/etc/selinux# grep kernel_t.*process.transition policy.conf
allow kernel_t init_t:process transition;
allow kernel_t insmod_t:process transition;
allow kernel_t hotplug_t:process transition;
allow { initrc_t kernel_t } insmod_t:process transition;
root@lyta:/etc/selinux#

As you can see above kernel_t can only transition to init_t, insmod_t, and 
hotplug_t in a default policy.  So therefore when you have init running in 
kernel_t every process that init runs (either directly or indirectly) apart 
from modprobe and hotplug will be in kernel_t.

If you label init correctly and run "telinit u" then init should re-exec 
itself in the correct context.  If you then run "killall -9 getty" the getty 
processes should be restarted in the correct context.  After getting getty 
running in the correct context you should be able to login at the console and 
then use run_init to restart the daemons and thus get them all running in the 
right context without rebooting.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
