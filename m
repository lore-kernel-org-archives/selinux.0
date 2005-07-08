Subject: RE: Useradd patchset - seeking comments..
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1120768031.6275.13.camel@celtics.boston.redhat.com>
References: <200507072013.j67KDjQ4012679@gotham.columbia.tresys.com>
	 <1120768031.6275.13.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 08:42:48 -0400
Message-Id: <1120826568.19035.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-07 at 16:27 -0400, Ivan Gyurdiev wrote:
> > Long term maintenance is everyone's concern 
> 
> Which is why this patch should be merged for clarity.
> 
> > Also, I don't like the style - I think that people
> > start worrying about the keyword even though it is useless. Verbosity is only
> > useful if it communicates something not already stated.
> 
> It communicates the storage class of the function, which I believe
> is not explicitly stated anywhere. It only stated implicitly, and
> programmers such as myself get confused by the lack of keyword -
> there's several storage classes to choose from, and this makes it clear.
> It also allows you to grep the file for extern, which you may
> want to do for some reason.
> 
> You can disagree, but /usr/include/* speaks for itself - 
> the vast majority of headers are explicitly marked extern, 
> which establishes the dominant style.
> 
> ===============
> 
> Also, we should move all headers describing functions 
> not exported by the shared library into a subfolder...

Yes, creating a include/sepol/private or similar and moving the headers
associated only with the static library into it would make sense.  Not
sure if there are any other libraries that have a similar issue with
exporting a much wider interface via the static library than the shared
library.

As for extern, I don't care either way, just need to be consistent.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
