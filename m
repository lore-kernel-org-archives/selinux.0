Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IDArrT020016
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 09:10:53 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IDACho012260
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 13:10:12 GMT
Date: Wed, 18 Aug 2004 14:21:56 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mozilla 0.9.3-2 crashing with tunables read and write homedir OFF
Message-ID: <20040818132156.GB19646@lkcl.net>
References: <20040817193823.GU18321@lkcl.net> <1092780620.6531.3.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092780620.6531.3.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 12:10:20AM +0200, Erich Schubert wrote:
> Hi,
> 
> > just in case anyone's curious about using mozilla with no read or write
> > access to user-home: at present (policy 1.12-3 or 4 and mozilla 0.9.2-3)
> > it don't work.
> > 
> > debian bugreport raised.
> 
> Waste of time. I guess that any mozilla developer will tell you they do
> need write access to their profile directory.

 i believe you may be misunderstanding.

 access to profile directory is fine: they can have write access
 to ~/.mozilla no problem, specifying some file contexts to
 allow that [a $1_mozilla_profile_t where $1=user/sysadm/staff/whatever
 which is placed on all files in ~/.mozilla]


 it's write access to home directories [file downloads, viruses,
 exploits, security holes etc] that should be banned via the
 tunable parameter mozilla_can_write.

 instead, not setting this parameter causes mozilla to go pear-shaped.



> Furthermore using an ancient version of mozilla doesn't help either.
> Even Debian "woody" (aka "stable") has mozilla 1.0.0 because of security
> issues... If you want to have a secure system you should at least
> upgrade to the most recent security update.
> 
> And don't expect applications to behave differently than what they were designed for.
> Mozilla was designed to have a writeable profile directory for its cache, configuration data etc.
> I bet the developers will just drop your bug report and tell you to write your own browser using the gecko engine...
 
  hah! 

 when i am rich and no longer infamous.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
