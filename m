Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHiXXh004291
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:44:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHiWRc020573
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:44:32 GMT
Subject: Re: Add kvmfs support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F0292A.3000301@redhat.com>
References: <45F0292A.3000301@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 17:45:00 +0000
Message-Id: <1174326300.16707.7.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:18 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/kernel/kernel.te      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/kernel.te   2007-03-08 08:42:45.000000000 -0500
> @@ -51,6 +51,15 @@
>  genfscon debugfs / gen_context(system_u:object_r:debugfs_t,s0)
>  
>  #
> +# kvmFS
> +#
> +
> +type kvmfs_t;
> +fs_type(kvmfs_t)
> +allow kvmfs_t self:filesystem associate;
> +genfscon kvmfs / gen_context(system_u:object_r:kvmfs_t,s0)
> +
> +#
>  # Procfs types
>  #

Merged, except for the associate line, which is redundant.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
