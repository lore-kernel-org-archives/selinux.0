Date: Thu, 23 May 2013 09:57:47 +0200
From: Laurent Bigonville <bigon@debian.org>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Last version of policycoreutils using Fedora only API
Message-ID: <20130523095747.22818ef6@soldur.bigon.be>
In-Reply-To: <CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com>
References: <20130523005354.418a2541@fornost.bigon.be>
	<CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Thu, 23 May 2013 07:30:18 +0200,
Sven Vermeulen <sven.vermeulen@siphos.be> a écrit :

> On May 23, 2013 1:09 AM, "Laurent Bigonville" <bigon@debian.org>
> wrote:
> > The last release of policycoreutils is using a function
> > (selinux_current_policy_path()) that is only available in Fedora. I
> > guess this shouldn't have made upstream.
> >
> > An idea how this could be sorted for other distributions?
> 
> Please see my answer to Joshua's announcement on the new userspace.

Oh thanks, I messed this.

> You'll need to add in the function. 

Well I'm not a big fan of adding function in libraries that are not
merged upstream. IIRC eparis told me on IRC that he has not happy with
this new functions.

Is this (or a reworked) function planned to be merged?

> There is also a dependency on yum Python bindings that you might
> need to remove, and depending on your directory structure you might
> need a /etc/selinux/sepolgen.conf (iirc) that defines where to find
> the refpolicy Makefile.

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
