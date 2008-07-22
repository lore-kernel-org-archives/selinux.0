Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6M2758J003584
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 22:07:05 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6M275mn008386
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 02:07:05 GMT
Received: by yw-out-1718.google.com with SMTP id 6so619852ywa.84
        for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 19:07:05 -0700 (PDT)
Subject: Re: About unifying the coding style
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64L.0807211208370.17053@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807211208370.17053@ruuvi.it.helsinki.fi>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 22:05:16 -0400
Message-Id: <1216692320.17786.25.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-07-21 at 12:19 +0300, Vesa-Matti J Kari wrote:
> Hello,
> 
> I'm planning to do more trivial fixes to the SELinux kernel subsystem to
> make the coding style look as unified as possible. Before continuing,
> however, I would like to ask for an opinion, because I do not want to
> waste my time.
> 
> There currently exist mixed styles such as:
> 
>   while (cur != NULL)
> 
> vs
> 
>   while (cur)
> 
> and of course the related "if"- and "for"-variants.
> 
> My questions:
> 
> 1) Is there a general agreement that only one style should be used?

I'd agree with that, yes.

> 2) If answer to the question 1 is "yes", which one is the preferred style?

I'm inclined to the latter as it is more concise and loses nothing in
semantics, but I'm open to hearing the other side of it.

A note however:  the core selinux developers are likely to be somewhat
unresponsive to non-critical patches right now because we are at the
SELinux mini-summit and Linux Symposium this week.

> 
> Thanks for the information.
> 
> Best regards,
> vmk
> --
> ************************************************************************
>                Tietotekniikkaosasto / Helsingin yliopisto
>                  IT Department / University of Helsinki
> ************************************************************************
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
