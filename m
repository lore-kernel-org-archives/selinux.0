Message-Id: <200508251813.j7PIDJss010091@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <SELinux-dev@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   "'James Morris'" <jmorris@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Problems with MCS/Targeted policy update.
Date: Thu, 25 Aug 2005 14:13:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1124986480.3873.102.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, August 25, 2005 12:15 PM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; SELinux-dev@tresys.com; 'Darrel Goeddel'; 'James
> Morris'; 'SELinux'
> Subject: RE: Problems with MCS/Targeted policy update.
> 
> On Thu, 2005-08-25 at 11:19 -0400, Karl MacMillan wrote:
> > This is a problem in other places as well - particularly when the on-disk
> > contexts are invalid. It would be ideal to have interfaces to retrieve both
> the
> > on-disk label (for relabeling based on old, possibly invalid contexts) and
> the
> > label being used by the kernel.
> 
> Yes, that has been discussed in the past, but no real consensus on the
> right approach.  The generic VFS fallback for security xattrs patch
> seems to be going forward, so that at least allows us to get the incore
> inode security label for filesystems that do not support xattrs, but it
> doesn't help with the inconsistent xattr/label problem on filesystems
> that do support xattrs.
> 
> In general we don't want applications to have to deal with the notion
> that there are two distinct labels at all, so we'd just like to ensure
> consistency whenever possible.  We could possibly export a selinuxfs
> interface for querying the incore inode security label of a given file,
> but it seems rather ugly, and most applications are just going to call
> getfilecon/getxattr for normal work.
>

I agree that most apps only want to know about one label, but it seems like most
applications want the incore inode security label. Only maintenance tools like
restorecon or replcon would want access to the actual on-disk labels. I would
think that updating the on-disk label to be consistent with the incore labels
would be the best default. As you say, consistency is the best default.

Karl 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134
 
> >  Resetting the on-disk xattr seems like the
> > better choice of the two you gave to me because it could be generalized to
> > handle the invalid context case, but we would lose the ability to change the
> > label based on the previous label.
> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
