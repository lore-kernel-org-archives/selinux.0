Subject: Re: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: George Wilson <ltcgcw@us.ibm.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>,
   Emily Ratliff <ratliff@austin.ibm.com>
In-Reply-To: <20050929222619.GA21890@us.ibm.com>
References: <20050929222619.GA21890@us.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:11:02 -0400
Message-Id: <1128089462.12459.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 17:26 -0500, George Wilson wrote:
> Our test team has run into a problem with seinfo on big endian platforms.
> Seinfo compares the unswapped SELINUX_MAGIC defined in borrowed.h with it's
> little endian counterpart at the top of the binary policy.  So it doesn't
> recognize binary policies.  It's easy enough to fix by #ifdef'ing swapped and
> unswapped definitions in borrrowed.h.  But shouldn't SELINUX_MAGIC be defined
> in a single place and used throughout to write and read the policy?

IMHO, setools should just be using libsepol to read binary policies and
then converting its data structures into its own internal ones.

> So, as a side issue, should one expect policies to be portable across
> platforms with differing endianness?

Yes, that is the intent.  They are always converted to/from little
endian when written/read.

>   It may work--I haven't tried.  Portability
> would be useful for cross-compile environments, for analysis when one has no
> access to the platform that generated the policy, and for cross-platform
> deployment of a single binary policy.  It looks like binary policies are always
> little endian so portability may not be an issue.  I must test that.  Also,
> might it not be nice to have the policies in big endian (network byte order)?
> I know that would be busy work.  But big endian just feels right for portable
> files.

It adds overhead on our most common platform (x86).  Also, ext2 uses
little endian, so it must be right ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
