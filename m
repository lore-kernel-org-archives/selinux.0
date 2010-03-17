Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2H7mlPW026891
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 03:48:47 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2H7mOVO023878
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 07:48:25 GMT
Message-ID: <4BA0894C.1060005@ak.jp.nec.com>
Date: Wed, 17 Mar 2010 16:48:28 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Manvendra Pratap Singh <manav.emb@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: working linux and busybox versions
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>	 <4BA06092.9030302@ak.jp.nec.com>	 <482a0d8c1003162308r3989a64by797220bf38dffdb3@mail.gmail.com> <482a0d8c1003170012w6de08b88l11c5a0d23420b805@mail.gmail.com>
In-Reply-To: <482a0d8c1003170012w6de08b88l11c5a0d23420b805@mail.gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/17 16:12), Manvendra Pratap Singh wrote:
> Hi KaiGai,
> 
> I checked /etc/selinux/base_policy/contexts/default_contexts and 
> /etc/selinux/base_policy/contexts/users/root both in my rootfs and it is 
> in correct place. But it still giving me same SID problem. Please give 
> some idea.

Does it have correct format? Does it contains an entry which matches
with the security context of your logind daemon?

If your policy does not define domain-transitions appropriately,
all the process may work with kernel_t, init_t or initrc_t.
If so, get_default_context() cannot find out configured entry.

What is your policy type? The standard reference policy?, or others?

Thanks,

> On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Singh 
> <manav.emb@gmail.com <mailto:manav.emb@gmail.com>> wrote:
> 
>     Thanks for reply KaiGai Kohei, I will follow your suggestion and let
>     you know about it.
> 
>     ---
>     Manav
>     Hyderabad
> 
>     2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com
>     <mailto:kaigai@ak.jp.nec.com>>
> 
>         (2010/03/17 13:22), Manvendra Pratap Singh wrote:
>          > Can anyone suggest me good guide for SELinux on omap3
>         (beagleboard). I
>          > tried it myself but I am not able to login after booting. On
>         loging in
>          > root I get a msg "Cann't get SID for root". Please help me on
>         this
>          > issue.  Here take a look at boot-log.
>          >
>          >
>          > [    0.000000] Security Framework initialized
>          > [    0.000000] SELinux:  Initializing.
>          >
>          >
>          > beagleboard login: root
>          > login: can't get SID for root
> 
>         This message come from logind applet of busybox.
> 
>         It tries to fetch the default security context of the root session.
> 
>         Put "/etc/selinux/<SELINUXTYPE>/contexts/default_contexts" or
>         "/etc/selinux/<SELINUXTYPE>/contexts/users/root" correctly, and
>         try it again.
> 
>         Thanks,
> 
>          >
>          > Embinux Linux 1.1 beagleboard ttyS2
>          >
>          > beagleboard login:
>          >
>          >
>          >
>          > ---
>          > Manav
>          > Hyderabad
>          >
>          >
>          >
>          > On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh
>          > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>
>         <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>>> wrote:
>          >
>          >     Thanks for the information. I asked about working busybox
>         and linux
>          >     kernel versions because when I am enabling selinux in busybox
>          >     (1.13.0), it is giving me lot of compilation errors and I
>         think some
>          >     code is also missing. Although the kernel (2.6.29) which
>         I am using
>          >     is working fine. If you tell anything more on this then
>         it will be a
>          >     great help.
>          >
>          >
>          >     --
>          >     Manav
>          >     Hyderabad
>          >
>          >
>          >
>          >     On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley
>         <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
>          > <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
>          >
>          >         On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap
>         Singh wrote:
>          > > Hi Stephen,
>          > >
>          > > May be I could not make myself clear to you. My question was
>          >         not about
>          > > linux on omap3, it was about SELinux on omap3. Anyways thanks
>          >         for your
>          > > reply. I will check the links given by you.
>          >
>          >         SELinux isn't platform-specific, and is a component
>         of the Linux 2.6
>          >         kernel.
>          >
>          >         --
>          >         Stephen Smalley
>          >         National Security Agency
>          >
>          >
>          >
> 
> 
>         --
>         KaiGai Kohei <kaigai@ak.jp.nec.com <mailto:kaigai@ak.jp.nec.com>>
> 
> 
> 
> 
> 
> -- 
> Manav
> Hyderabad


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
