Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BFR3BI021102
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 11:27:03 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BFR0DE026047
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 15:27:00 GMT
Subject: Re: fsdaemon writes files/disks at different levels, Needs write
	down.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301422.l4UEMhjS007772@localhost.localdomain>
References: <200705301422.l4UEMhjS007772@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:25:35 +0000
Message-Id: <1181575535.16029.34.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:22 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/smartmon.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/smartmon.te	2007-05-30 09:08:15.000000000 -0400
> @@ -60,6 +60,7 @@
>  fs_search_auto_mountpoints(fsdaemon_t)
>  
>  mls_file_read_up(fsdaemon_t)
> +mls_file_write_down(fsdaemon_t)
>  
>  storage_raw_read_fixed_disk(fsdaemon_t)
>  storage_raw_write_fixed_disk(fsdaemon_t)

Looks to me that all of the devices smartmon should care about
(fixed_disk_device_t) are all system high, so I'm not sure why this is
needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
