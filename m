Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i73EuArT021284
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 10:56:10 -0400 (EDT)
Date: Tue, 3 Aug 2004 14:37:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040803133755.GC4043@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil> <20040802145724.GG4194@lkcl.net> <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil> <20040802191243.GJ4194@lkcl.net> <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil> <20040802211212.GB6260@lkcl.net> <1091531491.7645.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091531491.7645.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 07:11:32AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-02 at 17:12, Luke Kenneth Casson Leighton wrote:
> >  okay, quick question: if i use setfscreatecon(), is it a "one-time"
> >  create, or is it effective on all creates up until the time that
> >  freecon() is called?
> 
> Once set, the fscreate context remains set for all file creations until
> the program explicitly resets it (via another setfscreatecon() call) or
> the program performs an execve (in which case the context is reset so
> that all programs start in a known state, defaulting to the
> policy-defined labeling behavior).  

 eek okay so i should use getcon() and restore the context afterwards.


> The freecon() is irrelevant to the
> "lifetime" of the fscreate context, as it just frees the context in the
> application's memory; it doesn't affect the saved value for the task in
> the kernel.
 
  ack.

> >  [because if it's "up until freecon() is called", then the bug that
> >   the selinux patch to udev was suffering from was that free(scontext)
> >   was being used instead of freecon().]
> 
> While it is preferable to use freecon() for encapsulation, it is
> presently true that freecon(x) == free(x).
> 
> With regard to your patch, please pass the actual mode to matchpathcon,
> not 0, as the second parameter.  This allows the matching to take into
> account the file type, e.g. whether it is a character device or a block
> device.

 oh yeah i forgot.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
