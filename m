Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62FKGKR009559
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:20:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l62FKD49009965
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 15:20:13 GMT
Subject: Re: apcupsd policy addon
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <61D1AE62-7AED-4A77-9EFC-0B56164B7F17@sf-net.com>
References: <61D1AE62-7AED-4A77-9EFC-0B56164B7F17@sf-net.com>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 11:18:14 -0400
Message-Id: <1183389494.4084.12.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-07-01 at 04:26 -0400, Stefan Schulze Frielinghaus wrote:
> debian stores the apcupsd binary under /sbin not /usr/sbin
> 
> --- /usr/src/refpolicy-20070629/policy/modules/services/
> apcupsd.fc      2007-05-07 16:55:54.000000000 +0200
> +++ policy/modules/services/apcupsd.fc  2007-07-01 10:18:45.000000000 
> +0200
> @@ -1,4 +1,5 @@
> /usr/sbin/apcupsd              --      gen_context
> (system_u:object_r:apcupsd_exec_t,s0)
> +/sbin/apcupsd                  --      gen_context
> (system_u:object_r:apcupsd_exec_t,s0)
> /var/log/apcupsd\.events.*     --      gen_context
> (system_u:object_r:apcupsd_log_t,s0)

The patch is linewrapped, so I merged it manually, in a distro_debian
block.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
