Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6FGESf017670
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 10:16:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA6FFo1W002742
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 15:15:50 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id hA6FFo5e002739
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 15:15:50 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6FGCh9032149
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 10:16:12 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hA6FGCNx032147
	for selinux@tycho.nsa.gov; Thu, 6 Nov 2003 10:16:12 -0500
Date: Thu, 6 Nov 2003 10:07:12 -0500 (EST)
From: Dean Anderson <dean@av8.com>
To: sMoTo <smoto@gmx.de>
cc: SELinux@tycho.nsa.gov
Subject: Re: Question concerning proftpd exploit
In-Reply-To: <000001c3a463$6d510650$02000a0a@lady>
Message-ID: <Pine.LNX.4.44.0311061005160.31835-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why don't you just try it in enforcing mode?

Then try some privilege escalation cracks, and see what gets logged.

Experience is the best teacher.

		--Dean

On Thu, 6 Nov 2003, sMoTo wrote:

> Hello,
>
> I have created a SELinux System running a vulnerable proftpd daemon (see
> http://xforce.iss.net/xforce/alerts/id/154). My ps listing in enforcing
> mode looks like this:
>
> PID CONTEXT                                  COMMAND
>     1 system_u:system_r:init_t                 init
>     2 system_u:system_r:kernel_t               [keventd]
>     3 system_u:system_r:kernel_t               [ksoftirqd_CPU0]
>     4 system_u:system_r:kernel_t               [kswapd]
>     5 system_u:system_r:kernel_t               [bdflush]
>     6 system_u:system_r:kernel_t               [kupdated]
>     9 system_u:system_r:kernel_t               [kjournald]
>   828 system_u:system_r:syslogd_t              syslogd -m 0
>   832 system_u:system_r:klogd_t                klogd -x
>   869 system_u:system_r:ftpd_t                 proftpd: (accepting
> connections)
>   878 system_u:system_r:sshd_t                 /usr/sbin/sshd
>   900 system_u:system_r:sendmail_t             sendmail: accepting
> connections
>   909 system_u:system_r:sendmail_t             sendmail: Queue
> runner@01:00:00 f
>   921 system_u:system_r:httpd_t                /usr/sbin/httpd
>   930 system_u:system_r:gpm_t                  gpm -t imps2 -m
> /dev/mouse
>   939 system_u:system_r:crond_t                crond
>   947 system_u:system_r:local_login_t          login -- root
>   948 system_u:system_r:local_login_t          login -- root
>   949 system_u:system_r:getty_t                /sbin/mingetty tty3
>   950 system_u:system_r:getty_t                /sbin/mingetty tty4
>   951 system_u:system_r:getty_t                /sbin/mingetty tty5
>   952 system_u:system_r:getty_t                /sbin/mingetty tty6
>   953 system_u:system_r:httpd_t                /usr/sbin/httpd
>   954 system_u:system_r:httpd_t                /usr/sbin/httpd
>   955 system_u:system_r:httpd_t                /usr/sbin/httpd
>   956 system_u:system_r:httpd_t                /usr/sbin/httpd
>   957 system_u:system_r:httpd_t                /usr/sbin/httpd
>   958 system_u:system_r:httpd_t                /usr/sbin/httpd
>   959 system_u:system_r:httpd_t                /usr/sbin/httpd
>   960 system_u:system_r:httpd_t                /usr/sbin/httpd
>   961 root:sysadm_r:sysadm_t                   -bash
>  1012 root:sysadm_r:sysadm_t                   -bash
>  1064 root:sysadm_r:sysadm_t                   ps -e --context
>
> The proftpd daemon runs in its own domain. ftpd_t
>
> The open source proof of concept exploit code gains a root shell on my
> Red Hat 8.0 System without running in enforcing mode. I ran the system
> with a maintenance kernel. If I would switch to enforcing mode, what
> would happen? Does the exploit gain a root shell with privileges
> system_u:system_r:ftp_t? Is this possible?
> Which security feature of SELinux handles such attacks? Which avc
> loggings should I see?
>
>
> Best regards.
>
> ### Oliver Fritz
> ### Singerstrasse 80
> ### 10243 Berlin
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
