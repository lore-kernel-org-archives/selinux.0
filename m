Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82MmVrT003762
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 18:48:32 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82MmUv0004670
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 22:48:30 GMT
Date: Thu, 2 Sep 2004 23:59:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040902225937.GQ5745@lkcl.net>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 03:38:39PM -0400, Stephen Smalley wrote:

> On Thu, 2004-09-02 at 11:52, Daniel J Walsh wrote:
> > Collin and I were discussing a way to label hardware devices correctly.
> > 
> > One proposal would be to come up with a new file_contexts file based off 
> > of path and hardware type.
> > 
> > So we could have a file with
> > 
> > /dev/h
> > 
> > /u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t
> > /u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom

> This is separate from the main file_contexts configuration used by
> setfiles, restorecon, and rpm?  If so, what prevents the device from
> being relabeled back to the wrong type by them?  If not, how do they
> determine the hardware type to pass in?  
> 
> It also isn't clear that you care about the pathname regex or file type
> if you know that you are dealing with a particular hardware type (and
> unit); you can just map those directly to a context.

okay: i got it, i got it.

the "cdrom" bit on the end is a "shortcut keyword" to say
"please override the default".

we need an "alternative" file system context function.

the function - setalternatefscontext() - should take two arguments:

- the name of the device (/dev/hdc)
- the "keyword" e.g. "cdrom".

setfscontextbykeyword() should:

- match the device against the regexp
- match the keyword against the last line: if there isn't one that
  matches, return an error (?)

if both device and keyword match, set the file context.


it remains the responsibility of programs that use the "alternative"
to reset the context back to the default after they're done.

so udev would need a udevremove if it doesn't already have one.


this is generic enough for it to be useable for purposes other than
/dev.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
