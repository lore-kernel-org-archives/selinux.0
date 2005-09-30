Message-Id: <200509301401.j8UE1QYs007476@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'George Wilson'" <ltcgcw@us.ibm.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:01:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050929222619.GA21890@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: George Wilson [mailto:ltcgcw@us.ibm.com]
> Sent: Thursday, September 29, 2005 6:26 PM
> To: SELinux
> Cc: Karl MacMillan; Emily Ratliff
> Subject: seinfo and binary policy endianness
> 
> Hello,
> 
> Our test team has run into a problem with seinfo on big endian platforms.
> Seinfo compares the unswapped SELINUX_MAGIC defined in borrowed.h with
> it's
> little endian counterpart at the top of the binary policy.  So it doesn't
> recognize binary policies.  It's easy enough to fix by #ifdef'ing swapped
> and
> unswapped definitions in borrrowed.h.  But shouldn't SELINUX_MAGIC be
> defined
> in a single place and used throughout to write and read the policy?
> 

Thanks for testing this - none of our powerbook owners seem to be loading
binary policies I guess. Yes - there is only one SELINUX_MAGIC. Your other
patch is correct.

> So, as a side issue, should one expect policies to be portable across
> platforms with differing endianness?  It may work--I haven't tried.
> Portability
> would be useful for cross-compile environments, for analysis when one has
> no
> access to the platform that generated the policy, and for cross-platform
> deployment of a single binary policy.  It looks like binary policies are
> always
> little endian so portability may not be an issue.  I must test that.

Policies should be portable - as you mention they are always stored little
endian. I've not tried this much in practice, but that is the intention.

> Also,
> might it not be nice to have the policies in big endian (network byte
> order)?
> I know that would be busy work.  But big endian just feels right for
> portable
> files.
> 

Portable formats transferred over the network maybe, but I don't see why it
matters for file formats. It is an arbitrary choice and it makes more sense
to have the default be a no-op on 90% of the hardware for reading these
policies. Feel free to submit a patch to Steve and the kernel maintainers
though :)

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> George Wilson <ltcgcw@us.ibm.com>
> IBM Linux Technology Center



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
