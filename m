Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83D6jrT007006
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 09:06:45 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83D6iUQ018520
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 13:06:45 GMT
Date: Fri, 3 Sep 2004 14:17:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040903131751.GC30562@lkcl.net>
References: <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil> <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377DD5.8010500@redhat.com> <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil> <41377F4B.3010608@redhat.com> <1094167821.24091.25.camel@nexus.verbum.private> <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 03, 2004 at 07:28:03AM -0400, Stephen Smalley wrote:
> On Thu, 2004-09-02 at 19:30, Colin Walters wrote:
> > I think "unit" in this context should be a regular expression which can
> > match an arbitrary identification string.  udev would extract the e.g.
> > the USB model number for this purpose.  This wouldn't actually be
> > supplied in the sample policy, but system administrators could use it to
> > customize the policy at a more granular level than "cdrom".
> 
> What granularity does udev currently support for specifying
> ownership/mode on device nodes?  

 ironically, it's scripted - with regexps matching nodes :)

 and then the owner, group and permissions are specified.

 there's also a system for dealing with classes of devices.

 so ide and scsi and also cd symbolic links are dealt with separately,
 with scripts.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
