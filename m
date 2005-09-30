Subject: RE: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: ltcgcw@us.ibm.com, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
In-Reply-To: <200509301434.j8UEYJYs008226@gotham.columbia.tresys.com>
References: <200509301434.j8UEYJYs008226@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:48:17 -0400
Message-Id: <1128091697.12459.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 10:34 -0400, Karl MacMillan wrote:
> Again, I agree that only having one library for representing policies would
> be desirable in many ways. Not just for reading, but for all policy
> representation and analysis. What prevents me from making that choice is:

I wasn't suggesting the latter (unified representation), just the former
(reading the binary policy image).  I'd still expect you to take the
resulting libsepol data structures and convert them over to the native
libapol representation that is presumably geared more toward analysis
needs, unless it happens to be the case that the formats have converged
to such a degree as to make that unnecessary (e.g. due to the avtab
changes made recently).

> a) backwards compatibility - we _must_ be able to load and represent very
> old policies. We still have work analyzing pre-LSM policies, for example.

In the short term, perhaps.  But that is a rather specialized case, and
doesn't require that the main setools branch retain that support.  Seems
suitable for a fork.

> I believe that libsepol's data structures can now represent everything from
> older policies with the exception of clone rules (which I am willing to
> drop). That leaves the parsers - which I guess we could have more than one
> source parser into the same data structures. So this is probably solvable, I
> would just need a commitment that backwards compatibility would be
> maintained.
> 
> b) conversion cost - the cost of converting all of our analysis code over to
> use libsepol would, in my opinion, outweigh the benefit. It appears to me to
> be less work to continue to maintain the separate code base than to do the
> conversion. Unless the changes, I cannot justify the cost.

I don't think you need to do that - just convert the sepol data
structures to your internal structures after the read.  No need to touch
the rest of your code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
