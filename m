Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5ALhmgA023227
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 17:43:48 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5ALZh1O002315
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 21:35:43 GMT
Date: Fri, 10 Jun 2005 21:26:29 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script
Message-ID: <20050610202629.GF8525@lkcl.net>
References: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com> <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118428283.3720.45.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 10, 2005 at 02:31:23PM -0400, Ivan Gyurdiev wrote:
> 
> > > What do you mean? The policy is not modified when applications are
> > > installed. I know Tresys is working on binary policy modules, but
> > > at the current time policy is only modified when I upgrade
> > > the selinux package, or when I recompile it.
> > > 
> > 
> > Of course, but the concept holds that this only needs to be done when the rpm
> > that adds the need for the additional file types is installed. The fact that the
> > policy doesn't change until then is only an artifact of a lack of
> > infrastructure.
> 
> /tmp on tmpfs is cleared on every boot, creating the need for
> a startup script.
> 
> > > I don't see how it's possible to solve this problem just by
> > > restructuring directories. Can you give an example of how
> > > the gconf-vs-orbit problem can be solved - see the file_type_auto_trans
> > > thread for full description.
> > > 
> > 
> > I thought this was answered - they need to be put in separate directories, e.g.
> > /tmp/orbit/orbit-$USER and /tmp/gconfd/gconfd-$USER. That way /tmp/orbit and
> > /tmp/gconfd can have different types 
> 
> Who will create /tmp/orbit and /tmp/gconfd, and how will you
> get them to have different types? 
 
 a special selinux-aware library, that all gconfd-aware programs and
 orbit-aware programs must utilise, respectively.

 heck, it could even do the setfilecon() for you.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
