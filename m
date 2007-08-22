Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJu5Hn019306
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:56:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJu4H3002120
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:56:04 GMT
Subject: Re: [PATCH] refpolicy: system_miscfiles changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B221A7.4040000@redhat.com>
References: <46B221A7.4040000@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:09 -0400
Message-Id: <1187812509.13874.102.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 14:25 -0400, Daniel J Walsh wrote:
> 
> Additional fonts directory

Merged

> --- nsaserefpolicy/policy/modules/system/miscfiles.fc   2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.4/policy/modules/system/miscfiles.fc        2007-07-25 12:07:25.000000000 -0400
> @@ -66,6 +66,7 @@
>  /var/lib/texmf(/.*)?           gen_context(system_u:object_r:tetex_data_t,s0)
> 
>  /var/cache/fonts(/.*)?         gen_context(system_u:object_r:tetex_data_t,s0)
> +/var/cache/fontconfig(/.*)?    gen_context(system_u:object_r:fonts_t,s0)
>  /var/cache/man(/.*)?           gen_context(system_u:object_r:man_t,s0)
> 
>  /var/spool/texmf(/.*)?         gen_context(system_u:object_r:tetex_data_t,s0)
> 
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
