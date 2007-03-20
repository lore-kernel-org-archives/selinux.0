Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2K5gAPl031140
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 01:42:10 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2K5g97o008885
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 05:42:09 GMT
Received: by ug-out-1314.google.com with SMTP id y2so1713708uge
        for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 22:42:08 -0700 (PDT)
Message-ID: <e739902b0703192242u464c1331jbbfa94ef1e206713@mail.gmail.com>
Date: Mon, 19 Mar 2007 22:42:07 -0700
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Incorrect comment or toolchain problem in refpolicy policy/modules/kernel/kernel.te?
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1174310930.22565.39.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0703171534x795e8802jeec1427f63043df7@mail.gmail.com>
	 <1174310930.22565.39.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

Is this something the community wants to pursue?
i.e. should I submit patches to do this?

Thanks!

- Ryan



On 3/19/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sat, 2007-03-17 at 15:34 -0700, Ryan Bradetich wrote:
> > Hello All,
> >
> > I found the following comment in the kernel.te refpolicy module:
> >
> > # These initial sids are no longer used, and can be removed:
> >
> > So naturally, I attempted to remove the sids ... but I got the
> > following error when compiling the policy:
> >
> > Compiling refpolicy policy.21
> > /usr/bin/checkpolicy policy.conf -o policy.21
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > libsepol.policydb_load_isids: SID (null) was never defined
> > make: *** [policy.21] Error 1
> >
> > I do go through all the sids and commented each one out individually
> > to see if there was a subset that could be removed.   What I found is
> > that if any of the sids were removed, it caused a compile error.
> >
> > Is the comment in the module incorrect?  Or is this a toolchain problem?
>
> The initial SIDs are declared in the flask/ files, then mapped to
> contexts by the definitions in refpolicy.  Removing them would require
> removing them from both places _and_ regenerating the kernel headers
> _and_ rebuilding the kernel if the removal affected the values of any
> other initial SIDs (which it would if there are any other initial SIDs
> that follow the removed ones in the declaration list).  Tight coupling
> to the kernel, as with the class and permission definitions.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
