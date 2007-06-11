Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BE5wcO015723
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:05:58 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BE5vDE009019
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:05:57 GMT
Subject: Re: apps_mozilla changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301541.l4UFfFZq011841@localhost.localdomain>
References: <200705301541.l4UFfFZq011841@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 14:04:32 +0000
Message-Id: <1181570672.16029.11.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:41 -0400, dwalsh@redhat.com wrote:
> Mozilla wants to read /dev/rand
> --- nsaserefpolicy/policy/modules/apps/mozilla.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/apps/mozilla.if	2007-05-30 09:25:53.000000000 -0400
> @@ -150,6 +150,7 @@
>  	corenet_dontaudit_tcp_bind_generic_port($1_mozilla_t)
>  
>  	dev_read_urand($1_mozilla_t)
> +	dev_read_rand($1_mozilla_t)
>  	dev_write_sound($1_mozilla_t)
>  	dev_read_sound($1_mozilla_t)
>  	dev_dontaudit_rw_dri($1_mozilla_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
