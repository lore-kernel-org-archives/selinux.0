Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SF1ADo027004
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 10:01:10 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SF0L1g003389
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 15:00:21 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Tom <tom@lemuria.org>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050328160935.B28563@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
	 <1112017584.1514.239.camel@cobra.ivg2.net>
	 <20050328160935.B28563@lemuria.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:05:58 -0500
Message-Id: <1112022358.5811.47.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 16:09 +0200, Tom wrote:
> On Mon, Mar 28, 2005 at 08:46:24AM -0500, Ivan Gyurdiev wrote:
> > I was suggesting that content should be kept in a sub-folder of /home,
> > not that it should be kept somewhere else. I'm sorry for the
> > misunderstanding. I am suggesting that this folder(s) should be
> > standartized somehow. I am saying that settings should be kept separate.
> 
> ah! What you want is /home/tom/.etc/ ?

Something like that - yes.


> Aunt Ellie downloads a movie. It goes into the Download folder (or
> really anywhere, it doesn't matter much). She drags the movie icon to
> the movie player and lets it drop. Movie plays.
> 
> Behind the scenes, the file is relabeled or moved into another
> directory where mplayer can access it.

How does this relate to the SElinux work to secure the X server?
Should the desktop environment be trusted?

.. so what you're saying is that nautilus (running as user_t, which has
read access to the file in question, as well as appropriate relabel
access), should determine its mime type, or use the DND target app, and
associate a context with that, which the mime handler can play, then
relabel file to that context (can't copy - what if it's huge?).... and
do this for every mime handler I attempt to open it with?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
