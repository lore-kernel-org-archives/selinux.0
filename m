Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523SlrT000787
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:28:47 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52BNIbn009730
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:23:18 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 20:22:03 -0000
Date: Tue, 1 Jun 2004 20:19:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
Message-ID: <20040601201928.GQ5690@lkcl.net>
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil> <40B67F41.6020309@snu.edu> <1086111584.13325.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086111584.13325.111.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 01:39:44PM -0400, Stephen Smalley wrote:

> On Thu, 2004-05-27 at 19:52, Joshua Brindle wrote:
> > on the slide entitled seperation it says that ACL's are used to protect 
> > the disk files so that rogue apps in a vm can't affect other vm's, 
> > additionally each vm's disk file is encrypted so that only the 'level' 
> > user can access it.
> > 
> > Obviously both of these things can be done with (SE)Linux but it appears 
> >   they thought about this already.
> 
> ACLs are a poor substitute for MAC, e.g. see
> http://marc.theaimsgroup.com/?l=selinux&m=104508693312829&w=2
 

 NT Security Descriptors (which contain ACLs) were pinched pretty
 much wholesale from VME / VMS, and they are a lot more comprehensive
 than what is described at that reference.

 NT security descriptors contain four ACLS:

 - a system mandatory acl
 - a system discretionary acl
 - a [user?] mandatory acl
 - a [user?] discretionary acl

 bizarrely all of those are optional and the usual default behaviour
 of an empty SD is "allow everything" which is about the only
 stupidity of the NT security model.

 NT ACLs themselves contain ACEs (access control entries) which
 themselves contain a SID (security identifier) and an oh i forget
 what call it a.. a... access permission set.

 SIDs are up to 6 32-bit words in length and consist of a domain
 prefix (long) and a suffix (only one, the last one, of the 32-bit
 words).

 access permissions are 32-bit - 16 of those bits are "generic"
 and consist of things like generic read, generic write, generic
 execute, then delete, access, etc. pretty much like capabilities,
 and then there are 16-bits which are designated for "service-specific"
 things.

 so a service can create up to 16 separate "capabilities".


 the only thing about the use of NT security descriptors is that they
 are implemented pretty much exclusively in USER SPACE.

 usually in those lovely DCE/RPC applications.

 there is very little in the way of kernel-level support for NT
 security descriptors, and what there is is self-contained and
 uses the same API as the user-space applications e.g. the NT
 SMB file server is all in kernel-space *gibber*.

 
 so, what _most_ people think of in "ACLs" is user and group and
 other read-write-execute lists, whereas in NT it's a lot more
 comprehensive and pervasive.

 and, due to the default of "allow everything if there's no SD"
 it's a pretty moot issue, silly people.

 as a developer, you make one mistake (add a new function and
 forget to correct support the user-space SDs) and NT's toast.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
