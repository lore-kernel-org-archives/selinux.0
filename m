Message-Id: <200508251519.j7PFJTss003144@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: <SELinux-dev@tresys.com>, "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   "'James Morris'" <jmorris@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Problems with MCS/Targeted policy update.
Date: Thu, 25 Aug 2005 11:19:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1124981047.3873.64.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, August 25, 2005 10:44 AM
> To: Daniel J Walsh
> Cc: SELinux-dev@tresys.com; Darrel Goeddel; James Morris; SELinux
> Subject: Re: Problems with MCS/Targeted policy update.
> 
> On Wed, 2005-08-24 at 11:14 -0400, Daniel J Walsh wrote:
> > Must have been a older kernel.   Just tried it again with
> > 2.6.12-1.1505_FC5 and it seems to work.
> > chcon is broken though, ls and other commands are not getting the :s0
> > since it is not there, so there might be other problems,
> 
> Ok, Dan pointed out another issue with cleanly upgrading from targeted
> to MCS:  although the SELinux module now defaults the MLS level for
> inodes that lack one (based on the default file SID associated with the
> superblock, typically the 'file' initial SID unless one uses a
> defcontext= mount option), userspace still sees the real xattr value,
> and this leads to problems, e.g. userspace can take a context obtained
> via getfilecon and later try to pass it to an interface like setfilecon
> or setfscreatecon or security_compute_create, and the SELinux module
> will then reject the context as invalid (because the defaulting logic
> only applies when mapping inode contexts to incore inode SIDs, not for
> contexts supplied by userspace).  Options are:
> - Change the SELinux module to reset the on-disk xattr when it defaults
> the MLS level so that userspace will see the same context, or
> - Have the MCS libsetrans insert a default level (s0) into the context
> if it lacks one for trans_to_raw conversion.  However, the latter would
> also require libselinux to invoke the translation functions in some
> additional cases where it does not presently need to, e.g. rpm_execcon
> currently works entirely with raw contexts, but would need to go through
> libsetrans in order to gain the benefit of such corrections on the
> result of the getfilecon.
> 

This is a problem in other places as well - particularly when the on-disk
contexts are invalid. It would be ideal to have interfaces to retrieve both the
on-disk label (for relabeling based on old, possibly invalid contexts) and the
label being used by the kernel. Resetting the on-disk xattr seems like the
better choice of the two you gave to me because it could be generalized to
handle the invalid context case, but we would lose the ability to change the
label based on the previous label.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
