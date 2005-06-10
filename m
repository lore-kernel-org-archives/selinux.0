Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AIdYgA021438
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 14:39:34 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AIVU1O018109
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 18:31:30 GMT
Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
References: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:31:23 -0400
Message-Id: <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > What do you mean? The policy is not modified when applications are
> > installed. I know Tresys is working on binary policy modules, but
> > at the current time policy is only modified when I upgrade
> > the selinux package, or when I recompile it.
> > 
> 
> Of course, but the concept holds that this only needs to be done when the rpm
> that adds the need for the additional file types is installed. The fact that the
> policy doesn't change until then is only an artifact of a lack of
> infrastructure.

/tmp on tmpfs is cleared on every boot, creating the need for
a startup script.

> > I don't see how it's possible to solve this problem just by
> > restructuring directories. Can you give an example of how
> > the gconf-vs-orbit problem can be solved - see the file_type_auto_trans
> > thread for full description.
> > 
> 
> I thought this was answered - they need to be put in separate directories, e.g.
> /tmp/orbit/orbit-$USER and /tmp/gconfd/gconfd-$USER. That way /tmp/orbit and
> /tmp/gconfd can have different types 

Who will create /tmp/orbit and /tmp/gconfd, and how will you
get them to have different types? 

> and the only changes required for orbit and
> gconfd are to put their files in a different location. If /tmp is tmpfs there
> needs to be a script that creates these directories with the correct labels at
> boot.

... and this leads us to... selinux.sh. 
Except you're saying that it should be executed once on boot, as root,
and not per login shell, is that correct? We may actually need to 
do that, since at the current time I can't create .ICE-unix in this
script - insufficient privileges.

> Changes retroactively seem problematic (see my other email). I think this is a
> hard problem - not relabeling possibly means confused users and relabeling
> possibly means going against the user's wishes or confusing them.

I don't think the user's intended to be changing the types of those 
directories - they are to be used for internal settings. That's
why most of them are hidden files.

>  I have to say
> that not relabeling is probably more confusing, but it starts to feel like
> fixing problems by rebooting . . . it just changes to logging in. 

The relabeling was actually not what I was focusing on - the
real issue was whether it's a good idea to pre-create folders
ahead of time.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
