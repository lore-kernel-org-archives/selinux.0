Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69BhlrT018645
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 07:43:47 -0400 (EDT)
Received: from mproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i69BhRbg028492
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 11:43:28 GMT
Received: by mproxy.gmail.com with SMTP id d19so207784rnf
        for <selinux@tycho.nsa.gov>; Fri, 09 Jul 2004 04:43:39 -0700 (PDT)
Message-ID: <e294b46e0407090443663d55c4@mail.gmail.com>
Date: Fri, 9 Jul 2004 12:43:38 +0100
From: Bradley Chapman <kakadu@gmail.com>
To: russell@coker.com.au
Subject: Re: An SELinux policy for Red Hat 9
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200407092111.55045.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <e294b46e040708131736c57b6@mail.gmail.com> <200407092111.55045.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

On Fri, 9 Jul 2004 21:11:55 +1000, Russell Coker <russell@coker.com.au> wrote:
> 
> 
> On Fri, 9 Jul 2004 06:17, Bradley Chapman <kakadu@gmail.com> wrote:
> > Does anyone know of a good place where I can start reading about how
> > to adapt, or obtain, an SELinux policy for Red Hat 9, running the
> > 2.6.7 kernel with the SELinux userspace package dated 20040628-16?
> 
> Why would you want to do that?  Consider Fedora Core 1 as RHL 10, and FC2 as
> RHL 11 an just upgrade a couple of versions to get SE Linux support.

I would do that - except for the fact that the system I want to run
SELinux on is my personal system, and upgrading it is currently not
something I wish to do. I may want to upgrade to FC2 later, but right
now I want to stick with RHL9.

> 
> But if you REALLY want to use RHL 9, the current policy should work OK, you
> just have to make the appropriate changes to pam, logrotate, cron, coreutils,
> etc.

What sort of changes? Path changes? 

Thanks,

Brad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
