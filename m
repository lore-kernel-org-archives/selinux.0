Message-Id: <200509301422.j8UELvYs008023@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'George Wilson'" <ltcgcw@us.ibm.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:21:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128089462.12459.110.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 10:11 AM
> To: George Wilson
> Cc: SELinux; Karl MacMillan; Emily Ratliff
> Subject: Re: seinfo and binary policy endianness
> 
> On Thu, 2005-09-29 at 17:26 -0500, George Wilson wrote:
> > Our test team has run into a problem with seinfo on big endian
> platforms.
> > Seinfo compares the unswapped SELINUX_MAGIC defined in borrowed.h with
> it's
> > little endian counterpart at the top of the binary policy.  So it
> doesn't
> > recognize binary policies.  It's easy enough to fix by #ifdef'ing
> swapped and
> > unswapped definitions in borrrowed.h.  But shouldn't SELINUX_MAGIC be
> defined
> > in a single place and used throughout to write and read the policy?
> 
> IMHO, setools should just be using libsepol to read binary policies and
> then converting its data structures into its own internal ones.
> 

This approach was discussed when we initially did this work. Again, the main
drawback is the possibility that libsepol would drop backwards compatibility
- which I think is a good idea for libsepol. There is no reason to maintain
the ability to read very old file formats in libsepol, but there is in
libapol.

Other than that, using libsepol may have been easier. At this point, though,
maintaining our binary parser is a fairly low amount of effort and switching
would be a large effort.

Karl
 

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
