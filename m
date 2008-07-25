Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P17xeT030135
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 21:07:59 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P17wm4000587
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:07:58 GMT
Received: by py-out-1112.google.com with SMTP id a78so8388757pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 18:07:58 -0700 (PDT)
Subject: Re: Mapping Linux GROUP to an SELinux user ?...
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04BF337D@de01exm68.ds.mot.com>
References: <48881546.6070903@ak.jp.nec.com>
	 <1216898673.3881.4.camel@sulphur>
	 <D06FE0A2807BC145B0D38744789D4F5D04BF337D@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 21:05:54 -0400
Message-Id: <1216947967.5185.3.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-07-24 at 14:22 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> Is there any way at all to map an entire Linux GROUP to an SELinux_user
> ??
> 
> For example if Linux User accounts (Admin1, Admin2, and Admin3), all
> belong to the Linux group  "wadm".
> 
> Is there a simple or tricky way to map the entire Linux group    wadm ->
> to staff_u ?
> 
> This way, any Linux user account that happens to be part of the "wadm"
> group would automatically be mapped to staff_u  ? This way we don't have
> to execute several semanage commands to create all those individual
> mappings ?

Not presently, but one could certainly implement such support in the
userland (pam_selinux + libselinux getseuserbyname).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
