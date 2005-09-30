Message-Id: <200509301434.j8UEYJYs008226@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <ltcgcw@us.ibm.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:34:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128089521.12459.111.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 10:12 AM
> To: ltcgcw@us.ibm.com
> Cc: SELinux; Karl MacMillan; Emily Ratliff
> Subject: Re: seinfo and binary policy endianness
> 
> On Thu, 2005-09-29 at 17:55 -0500, George Wilson wrote:
> > Attached is Emily's patch, which is far more elegant than a borrowed.h
> > hack.  It seems like borrowed.h should really go away.
> 
> Even better would be for setools to just use libsepol, which is _the_
> library for manipulation of binary policies...
> 

Again, I agree that only having one library for representing policies would
be desirable in many ways. Not just for reading, but for all policy
representation and analysis. What prevents me from making that choice is:

a) backwards compatibility - we _must_ be able to load and represent very
old policies. We still have work analyzing pre-LSM policies, for example.

I believe that libsepol's data structures can now represent everything from
older policies with the exception of clone rules (which I am willing to
drop). That leaves the parsers - which I guess we could have more than one
source parser into the same data structures. So this is probably solvable, I
would just need a commitment that backwards compatibility would be
maintained.

b) conversion cost - the cost of converting all of our analysis code over to
use libsepol would, in my opinion, outweigh the benefit. It appears to me to
be less work to continue to maintain the separate code base than to do the
conversion. Unless the changes, I cannot justify the cost.

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
