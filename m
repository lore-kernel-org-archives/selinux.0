Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TM3UrT023104
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 18:03:30 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TM2xbB022705
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 22:02:59 GMT
Date: Thu, 29 Jul 2004 23:14:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev has had udev_selinux removed - argh!
Message-ID: <20040729221434.GP9950@lkcl.net>
References: <20040729094717.GE6443@lkcl.net> <20040729185034.GA1530@kroah.com> <20040729204008.GM9950@lkcl.net> <1091133915.3283.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091133915.3283.25.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 10:45:15PM +0200, Kay Sievers wrote:
> On Thu, 2004-07-29 at 21:40 +0100, Luke Kenneth Casson Leighton wrote:
> > hello greg,
> > 
> > well i tried compiling udev-024 and it was a pain, plus i got udev-030
> > to work and decided it wasn't worth the effort, the users can
> > JustLiveWithIt(tm) until it's fixed properly.
> > 
> > greg, do you have any objections to me doing a "proper" job, which
> > is to patch udev-add.c to use some libselinux1 functions that will
> > "prime" the selinux module with the right context, such that
> > when the node (and the symlink!) are individually created, they
> > are individually created with the correct context - there and then.
> 
> How do we solve the klibc build, if selinux is used internally? We've
> moved it to a external program for that reason.
 
  if i understand you correctly (i don't know what klibc is):

  i'd recommend leaving it up to distributions to decide
  to create (or not) two _separate_ packages, se_udev and udev.

  if you can at least provide an option --with-selinux in the
  configure script, distros can make the decision.

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
