Subject: RE: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: ltcgcw@us.ibm.com, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
In-Reply-To: <200509301443.j8UEhaYs008411@gotham.columbia.tresys.com>
References: <200509301443.j8UEhaYs008411@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:50:45 -0400
Message-Id: <1128091845.12459.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 10:43 -0400, Frank Mayer wrote:
> Three reasons why it currently does not:
> 1. We have backwards compatibility in libapol, since we support analysis of
> all sorts of versions of SELinux.

Yes, known, but libsepol goes back to version 15, the first version
supported in 2.6 kernels, and I'd be surprised if the policy.12 users
aren't upgraded to 2.6 RSN.

> 2. It's rather nice to have a separate code path to parse the policy for
> testing purposes. We use it a lot in testing compiler changes, etc.

But it is also a major code duplication and potential source of subtle
bugs in your analyses.

> 3. (Most importantly) When I first wrote the binpol parser for libapol,
> libsepol did not exist in any form like today :-)

Yes, understood.   But going forward, I think it is the right path.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
