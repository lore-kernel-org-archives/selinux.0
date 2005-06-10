Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AIRigA021267
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 14:27:44 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AIK6fM005042
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 18:20:06 GMT
Message-Id: <200506101819.j5AIJi5F009499@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 14:19:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118426293.3720.14.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 1:58 PM
> To: Joshua Brindle
> Cc: Daniel J Walsh; SELinux; selinux-dev@tresys.com
> Subject: Re: Restorecon script
> 
> On Fri, 2005-06-10 at 12:05 -0400, Joshua Brindle wrote:
> > On Thu, 2005-06-09 at 22:32 -0400, Ivan Gyurdiev wrote:
> > > > What problem is this solving?
> > >
> > > It is solving the problem of labeling things properly in /tmp and /home
> > > (according to recent policy changes,
> >
> > relabeling at policy modification time is much better than automated
> > relabeling when a user logs in
> 
> What do you mean? The policy is not modified when applications are
> installed. I know Tresys is working on binary policy modules, but
> at the current time policy is only modified when I upgrade
> the selinux package, or when I recompile it.
> 

Of course, but the concept holds that this only needs to be done when the rpm
that adds the need for the additional file types is installed. The fact that the
policy doesn't change until then is only an artifact of a lack of
infrastructure.

> > > It can be solved by setfscreate code in the application, but
> > > that's worse - intrusive code in multiple applications.
> > >
> >
> > it can also be solved by properly structuring directories, either by
> > application configuration or if necessary modifying the application in a
> > much less intrusive way (this was mentioned on that thread I believe)
> 
> I don't see how it's possible to solve this problem just by
> restructuring directories. Can you give an example of how
> the gconf-vs-orbit problem can be solved - see the file_type_auto_trans
> thread for full description.
> 

I thought this was answered - they need to be put in separate directories, e.g.
/tmp/orbit/orbit-$USER and /tmp/gconfd/gconfd-$USER. That way /tmp/orbit and
/tmp/gconfd can have different types and the only changes required for orbit and
gconfd are to put their files in a different location. If /tmp is tmpfs there
needs to be a script that creates these directories with the correct labels at
boot.

> > > Creating folders ahead of time is the most acceptable solution so far.
> > > I'm not sure how exactly this should be done, but some sort of simple
> > > script like this is one possibility.
> > >
> >
> > scripts that install stuff to skel maybe should be responsible for
> > adding them to user dirs and labeling properly. This would be a trusted
> > app (rpm or whatever) instead of a user shell script
> 
> /skel does not work, because you have to apply the changes retroactively
> to users that already exist. Additionally, tmp has to be handled
> at startup time, because it can be on tmpfs.

Changes retroactively seem problematic (see my other email). I think this is a
hard problem - not relabeling possibly means confused users and relabeling
possibly means going against the user's wishes or confusing them. I have to say
that not relabeling is probably more confusing, but it starts to feel like
fixing problems by rebooting . . . it just changes to logging in. 

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
