Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB9Km6Jc016647
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 15:48:08 -0500
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nB9KoO6g000403
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 20:50:24 GMT
From: Paul Moore <paul.moore@hp.com>
To: russell@coker.com.au
Subject: Re: tun/tap and SE Linux in 2.6.32
Date: Wed, 9 Dec 2009 15:48:03 -0500
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200912091232.26387.russell@coker.com.au>
In-Reply-To: <200912091232.26387.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912091548.03369.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 December 2009 08:32:24 pm Russell Coker wrote:
> ----------  Forwarded Message  ----------
> 
> Subject: selinux permissive blocking tun/tap device creation in v2.6.32
> Date: Wed, 9 Dec 2009
> From: Andrew Worsley <amworsley@gmail.com>
> To: luv-main@luv.asn.au
> 
> I upgraded to the v2.6.32 kernel and I found tunctl would fail with
> the  ioctl TUNSETIFF rejected with an EINVAL. A real pain when running
> vpn and kvms which use these.
> 
> I don't know where to go from this - so directions as to where to post
> / look would be appreciated but at least I can now create tap
> interfaces.
> 
> I am looking for suggestions where I should post this to find a fix or
> other better work around than merely commenting out this code...
> 
>    Andrew
> 
> I eventually traced this via recompiling the tun module with tracing
> to this code:
> 
> 
>             printk(KERN_INFO "tun: tun_set_iff () 10\n");
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>             printk(KERN_INFO "tun: tun_set_iff () 11\n");
> #if 0
>                 err = security_tun_dev_create();
>                 if (err < 0)
>                         return err;
> #endif
> 
>             printk(KERN_INFO "tun: tun_set_iff () 12\n");
>                 /* Set dev type */
>                 if (ifr->ifr_flags & IFF_TUN) {
>                         /* TUN device */
> 
> in drivers/net/tun.c (commenting out the above allows the tunctl
> command to work!)

I imagine this is because the original reporter is using a SELinux policy 
without the new TUN socket classes/permissions (which is likely the common 
case at this point).  The unknown class/permission handling that Eric added 
_should_ protect us from this - Russel do you have any more information about 
the distribution and policy in use here?  

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
