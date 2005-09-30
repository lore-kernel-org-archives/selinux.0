Message-Id: <200509301406.j8UE65Ys007552@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ltcgcw@us.ibm.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:06:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128034546.6256.15.camel@ea.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: George Wilson [mailto:ltcgcw@us.ibm.com]
> Sent: Thursday, September 29, 2005 6:56 PM
> To: SELinux
> Cc: Karl MacMillan; Emily Ratliff
> Subject: Re: seinfo and binary policy endianness
> 
> On Thu, 2005-09-29 at 17:26 -0500, George Wilson wrote:
> > Hello,
> >
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
> >
> > So, as a side issue, should one expect policies to be portable across
> > platforms with differing endianness?  It may work--I haven't tried.
> Portability
> > would be useful for cross-compile environments, for analysis when one
> has no
> > access to the platform that generated the policy, and for cross-platform
> > deployment of a single binary policy.  It looks like binary policies are
> always
> > little endian so portability may not be an issue.  I must test that.
> Also,
> > might it not be nice to have the policies in big endian (network byte
> order)?
> > I know that would be busy work.  But big endian just feels right for
> portable
> > files.
> >
> 
> Attached is Emily's patch, which is far more elegant than a borrowed.h
> hack.  It seems like borrowed.h should really go away.
> 

Thanks - I'll get this integrated. Why should borrowed.h go away? We can't
rely on libsepol to be stable, and one of the main defining characteristics
of libapol is that it maintains backwards compatibility. We can read any
policy format from pre-version 12 to current policies. That would be
difficult to do relying on libsepol.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> George Wilson
> IBM Linux Technology Center
> <ltcgcw@us.ibm.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
