Message-Id: <200509301443.j8UEhaYs008411@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <ltcgcw@us.ibm.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:43:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128089521.12459.111.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Even better would be for setools to just use libsepol, which is _the_
> library for manipulation of binary policies... 

Three reasons why it currently does not:
1. We have backwards compatibility in libapol, since we support analysis of
all sorts of versions of SELinux.

2. It's rather nice to have a separate code path to parse the policy for
testing purposes. We use it a lot in testing compiler changes, etc.

3. (Most importantly) When I first wrote the binpol parser for libapol,
libsepol did not exist in any form like today :-)





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
