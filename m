Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJu9wj019345
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:56:09 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJu8ca002253
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:56:08 GMT
Subject: Re: [Fwd: [PATCH] refpolicy: system_iptables changes]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B22279.9030909@redhat.com>
References: <46B22279.9030909@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:14 -0400
Message-Id: <1187812514.13874.104.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 14:29 -0400, Daniel J Walsh wrote:
> Switch iptables to use nsswitch
> 
> --- nsaserefpolicy/policy/modules/system/iptables.te    2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.4/policy/modules/system/iptables.te 2007-07-25
> 12:27:26.000000000 -0400
> @@ -44,6 +44,8 @@
> 
>  corenet_relabelto_all_packets(iptables_t)
> 
> +auth_use_nsswitch(iptables_t)
> +

I applied this part a few lines down

>  dev_read_sysfs(iptables_t)
> 
>  fs_getattr_xattr_fs(iptables_t)
> @@ -62,6 +64,7 @@
>  init_use_script_ptys(iptables_t)
>  # to allow rules to be saved on reboot:
>  init_rw_script_tmp_files(iptables_t)
> +init_rw_script_stream_sockets(iptables_t)

This is weird, what caused this behavior?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
