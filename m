Message-Id: <200509301631.j8UGVJYs009795@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Frank Mayer'" <mayerf@tresys.com>
Cc: <ltcgcw@us.ibm.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 12:31:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128091845.12459.135.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 10:51 AM
> To: Frank Mayer
> Cc: ltcgcw@us.ibm.com; 'SELinux'; 'Karl MacMillan'; 'Emily Ratliff'
> Subject: RE: seinfo and binary policy endianness
> 
> On Fri, 2005-09-30 at 10:43 -0400, Frank Mayer wrote:
> > Three reasons why it currently does not:
> > 1. We have backwards compatibility in libapol, since we support analysis
> of
> > all sorts of versions of SELinux.
> 
> Yes, known, but libsepol goes back to version 15, the first version
> supported in 2.6 kernels, and I'd be surprised if the policy.12 users
> aren't upgraded to 2.6 RSN.
> 

Most, but not all. We can't load version 12 binaries anyway - just source.
So the comment is only relevant if we moved to libsepol entirely.

> > 2. It's rather nice to have a separate code path to parse the policy for
> > testing purposes. We use it a lot in testing compiler changes, etc.
> 
> But it is also a major code duplication and potential source of subtle
> bugs in your analyses.
> 

And supporting things like constraints will require significant work in
libapol.

> > 3. (Most importantly) When I first wrote the binpol parser for libapol,
> > libsepol did not exist in any form like today :-)
> 
> Yes, understood.   But going forward, I think it is the right path.
> 

We'll think about it further.

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
