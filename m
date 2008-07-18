Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IEWkd1030758
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 10:32:46 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IEWjGo027665
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:32:45 GMT
Subject: Re: [refpolicy] Let dhcp use init fds
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <486277AC.9080801@martinorr.name>
References: <486277AC.9080801@martinorr.name>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 10:32:18 -0400
Message-Id: <1216391538.21191.149.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-06-25 at 17:51 +0100, Martin Orr wrote:
> Without this patch, I see no output from dhclient when it is run during boot.
> There is no avc message because it is dontaudited in init_daemon_domain.
> 
> Index: policy/modules/system/sysnetwork.te
> ===================================================================
> --- policy/modules/system/sysnetwork.te.orig
> +++ policy/modules/system/sysnetwork.te
> @@ -126,6 +126,7 @@
>  files_dontaudit_search_locks(dhcpc_t)
> 
>  init_rw_utmp(dhcpc_t)
> +init_use_fds(dhcpc_t)
> 
>  logging_send_syslog_msg(dhcpc_t)

I would think that allowing it to write to the console would be required
to make this work too.  If thats the case I'm not sure we want it; I
don't think we want daemons writing to the console.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
