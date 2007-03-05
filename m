Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l256UiCe029890
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 01:30:44 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l256W9ce007217
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 06:32:10 GMT
Received: by wr-out-0506.google.com with SMTP id 37so1257907wra
        for <selinux@tycho.nsa.gov>; Sun, 04 Mar 2007 22:32:07 -0800 (PST)
Message-ID: <e739902b0703042232n7eccb84esbed5c7c386d59f2b@mail.gmail.com>
Date: Sun, 4 Mar 2007 22:32:07 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Yuichi Nakamura" <ynakam@hitachisoft.jp>
Subject: Re: Assgin domain to busybox applet(Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, busybox@kaigai.gr.jp
In-Reply-To: <20070305092421.c5121997.ynakam@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	 <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
	 <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
	 <20070305092421.c5121997.ynakam@hitachisoft.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Nakamura-san,

On 3/4/07, Yuichi Nakamura <ynakam@hitachisoft.jp> wrote:
> On Fri, 2 Mar 2007 08:21:03 -0800
> We(people in JSELUG(Japan SELinux Users Group)
> are extending busybox to assign domain to busybox applets.
> It might be useful for you.
> You can obtain it from
> http://code.google.com/p/sebusybox/source

Excellent!  I will grab a copy of this code later this week so I can
look at it in more detail.   Thanks for the link!

> By preparing wrapper program or separting executable,
> you can assign domain to applet,
> but it is not useful.
> We decided to extend busybox to support dynamic domain transition.
>
> In this, "CONFIG_SELINUX_DYNTRANSITION" is prepared.
> It is under "Support NSA Security Enhanced Linux" in menu.
> By enabling this, you can assign domain to applet by dynamic domain transition.
>
> It can assign entrypoint label to applet, by following syntax.
> In file_contexts file:
> <path to busybox>/<name of applet>  system_u:object_r:<entry point label>
> For example, assume following situation
> * busybox executable is: /usr/bin/busybox
> * applet name is httpd
> * entrypoint label you want to assign is httpd_exec_t
> Then you have to write following in file_contexts
> /usr/bin/busybox/httpd  system_u:object_r:httpd_exec_t
>
> You also need to write domain_auto_trans rule
> and allow some permissions(setcontext, dyntransition) for dynamic domain transition.
> Sample policy is under construction, sorry..
>
> Extended Busybox obtain
> applet's entrypoint label by matchpathcon,
> decides domain transition by compute_av, and set new domain by setcon.
>
> We are using file_contexts file to label entrypoint.
> However, it has to use /proc/self/exe,
> so before mounting /proc ,it does not work.
>
> We are preparing another patch that does not use file_contexts
> and uses "busybox_contexts file" to assign entrypoint label.
> I hope we can announce it in near future..

Sounds interesting, Looking forward to your announcement!

> Documentation is under construction,
> so please ask us if you have questions.

Will do.  Thanks for the pointers to your work!

- Ryan


> Regards,
> --
> Yuichi Nakamura
> Hitachi Software Engineering Co., Ltd.
> SELinux Policy Editor: http://seedit.sourceforge.net/
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
