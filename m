Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SFf3Do027323
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 10:41:03 -0500 (EST)
Received: from mail.lemuria.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SFeD1g007013
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 15:40:14 GMT
Date: Mon, 28 Mar 2005 17:41:00 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328174059.C29441@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net> <20050328132653.F27857@lemuria.org> <1112012129.1514.187.camel@cobra.ivg2.net> <20050328151126.B28232@lemuria.org> <1112017584.1514.239.camel@cobra.ivg2.net> <20050328160935.B28563@lemuria.org> <1112022358.5811.47.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112022358.5811.47.camel@cobra.ivg2.net>; from ivg2@cornell.edu on Mon, Mar 28, 2005 at 10:05:58AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 10:05:58AM -0500, Ivan Gyurdiev wrote:
> > ah! What you want is /home/tom/.etc/ ?
> 
> Something like that - yes.

Ok, that's a good idea.



> > Behind the scenes, the file is relabeled or moved into another
> > directory where mplayer can access it.
> 
> How does this relate to the SElinux work to secure the X server?

Not at all. X doesn't come in here. There's no reason why I can't do
something similar in non-X environments.


> Should the desktop environment be trusted?

Everything is trusted - to a degree. Can I trust my desktop environment
to relabel one filetype to one other filetype? For a military system
the answer would be no, but for a desktop system I think that's a risk
we can take.


> .. so what you're saying is that nautilus (running as user_t, which has
> read access to the file in question, as well as appropriate relabel
> access), should determine its mime type, or use the DND target app, and
> associate a context with that, which the mime handler can play, then
> relabel file to that context (can't copy - what if it's huge?).... and
> do this for every mime handler I attempt to open it with?

You could do priviledge seperation and have a relabeling demon running
in the background.

There's a dozen ways to do it. I really don't care much about which
exactly is used. The point I'm adamant about is two-fold: a) no generic
directories accesable by anyone and their dog - b) explicit transfers
through user interaction are a good idea. Not everything should be
transparent. Firefox's "hey, you downloaded this .exe from the 'net,
you sure you really wanna run it?" is a _good_ idea.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
