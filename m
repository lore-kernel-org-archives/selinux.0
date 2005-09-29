Date: Thu, 29 Sep 2005 17:26:19 -0500
From: George Wilson <ltcgcw@us.ibm.com>
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Emily Ratliff <ratliff@austin.ibm.com>
Subject: seinfo and binary policy endianness
Message-ID: <20050929222619.GA21890@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Our test team has run into a problem with seinfo on big endian platforms.
Seinfo compares the unswapped SELINUX_MAGIC defined in borrowed.h with it's
little endian counterpart at the top of the binary policy.  So it doesn't
recognize binary policies.  It's easy enough to fix by #ifdef'ing swapped and
unswapped definitions in borrrowed.h.  But shouldn't SELINUX_MAGIC be defined
in a single place and used throughout to write and read the policy?

So, as a side issue, should one expect policies to be portable across
platforms with differing endianness?  It may work--I haven't tried.  Portability
would be useful for cross-compile environments, for analysis when one has no
access to the platform that generated the policy, and for cross-platform
deployment of a single binary policy.  It looks like binary policies are always
little endian so portability may not be an issue.  I must test that.  Also,
might it not be nice to have the policies in big endian (network byte order)?
I know that would be busy work.  But big endian just feels right for portable
files.

-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
