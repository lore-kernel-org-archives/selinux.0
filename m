Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83GqirT009076
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 12:52:44 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83GprFY019730
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:51:54 GMT
Date: Fri, 3 Sep 2004 18:03:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040903170348.GA1116@lkcl.net>
References: <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377DD5.8010500@redhat.com> <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil> <41377F4B.3010608@redhat.com> <1094167821.24091.25.camel@nexus.verbum.private> <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil> <20040903131751.GC30562@lkcl.net> <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil> <20040903143808.GA26568@lkcl.net> <1094228921.19206.228.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094228921.19206.228.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 03, 2004 at 12:28:41PM -0400, Stephen Smalley wrote:
> On Fri, 2004-09-03 at 10:38, Luke Kenneth Casson Leighton wrote:
> >   what do you think of the idea of
> >   "run-time enabling of alternative file contexts"?
> > 
> >   because i still think that extending the existing
> >   file_contexts syntax to have an optional keyword at the
> >   end, and then providing extended versions of the existing
> >   libselinux file context related functions, would provide
> >   the simplest from-here-to-there approach.
> 
> I don't like it.  Rationale:
> - programs that don't have device information (or whatever the keyword
> is based on) available to them can't provide useful input to the
> libselinux function, so they will end up matching the wrong entry. 

 it's the sort of thing that is only going to be used by programs
 that understand it.

 e.g. the "postfix" keyword to activate the chroot-specific
 file_contexts is specific to postfix.

 the "mozilla download helper" keyword is specific to the mozilla
 download helper.

 as for udev, once udev is written i do not believe that someone would
 wish to write an alternative, but should they choose to do so, the
 keywords could be extended to say udev_cdrom, udev_disk, such that
 another program could do "myotherdevmanagementprogram_cdrom" etc. etc.


> Essentially, udev is an object manager for /dev, and I'd be glad to push
> management of the device node contexts into it.  And the closer it
> parallels the existing support for ownership/permissions, the better, as
> that increases the likelihood of the SELinux support being understood
> and maintained properly.

 understood.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
