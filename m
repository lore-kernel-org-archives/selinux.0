Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21LMeg4022605
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 16:22:40 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21LO4JC008318
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 21:24:04 GMT
Received: by wr-out-0506.google.com with SMTP id 37so13611wra
        for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2007 13:24:04 -0800 (PST)
Message-ID: <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
Date: Thu, 1 Mar 2007 13:24:03 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

Thanks again for your time and answers!

On 3/1/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2007-03-01 at 08:10 -0800, Ryan Bradetich wrote:
> >    # grep '^[ \t]*user ' policy.conf.base
> >      user system_u roles { system_r };
> >      user user_u roles { user_r };
> >      user staff_u roles { staff_r sysadm_r  };
> >      user sysadm_u roles { sysadm_r };
> >
> >    # grep '^[ \t]*user ' policy.conf.all
> >      user system_u roles { system_r };
> >      user user_u roles { user_r };
> >      user staff_u roles { staff_r sysadm_r  };
> >      user sysadm_u roles { sysadm_r };
> >
> > Is my understanding correct that if these users are defined in the
> > policy.conf file and it successfully compiles into the binary policy,
> > then the user contexts should be available to the policy (even though
> > the userdomain module was not included?).
>
> No.  For the context to be valid and reachable, you need:
> - the user identity defined and authorized for a role (as above),
> - the role defined and authorized for a domain/type,
> - the domain/type defined, including transitions into it.
>
> The statements above only do the first part.

Ah ha.  The last piece was the piece I was missing.  The base-only
policy has the roles defined and authorized for the specific
domain/type.  I also have the domain/type defined, but I do not have
any transitions into it.  I will test this out later tonight by adding
the appropriate transition.

> > At this point, I am not sure why or how the user and role information
> > is getting added to the policy.conf file when only the base modules
> > are defined.  I found then when I went to add the users manually.   I
> > did not dig into the how part, I was more interested in why it was not
> > working.  I will need to understand the how part later as I continue
> > to strip down the base policies.
>
> User identities are defined by policy/users, not in the individual
> policy modules.

Make sense.  I think I remember reading that now either in the SELinux
book or one of the many SELinux howtos.  I will have to go back and
review this.  Thanks for the pointer.

> > But in this case, there was no reachable contexts for the full policy
> > or the base-only policy.  In both cases I was always hitting the
> > failsafe context.
>
> That suggests that the login app wasn't running in the right context, in
> which case the context would be valid, but not reachable per policy.

Excellent.  I will look into this as well.  Is the login app required
to run in a specific context?  Or just a context that has the
appropriate permissions to transfer to the domain the user is in?

> >    The only difference between the full-policy and
> > the base-only policy is the base-only policy failed to write to
> > /selinux/context.  Does this mean I have something configured
> > improperly on my system?
>
> It didn't fail to write, but the write reported invalid argument, i.e.
> the context written was not valid per policy.  That's the point of
> writing it to /selinux/context - to check its validity against policy.

Make sense.  This is something I will probably dig into later ...
sounds interesting and I am curious to understand exactly how it works
:)

> > I did try to add the userdomain module as a stand-alone module, but it
> > requires the use of several other modules such as init, etc.  I can go
> > back and re-construct the list of required modules I needed to include
> > the userdomain module if this is of interest.  [NOTE: When I did have
> > the userdomain + required modules in place, I was able to login
> > successfully].
>
> Naturally userdomain has dependencies; that isn't a surprise.

Understood :)  My intention was to try and bisect the differences, but
it became pretty large quickly.  I understand why, just thought it
might be easier to trace the root of the problem through the
libselinux1 library and see if I could figure out what was required
that way.

> > I understand I will need these modules eventually, but I am really
> > trying to get my head around how these modules work.  I will need this
> > detailed information since I plan to write a busybox SELinux policy
> > module which also implements the system functions like: init,
> > loginutils, logging, etc.
>
> I assume you are leveraging the sebusybox work then...

Yes, I have been testing their patch sets and I am currently running
the latest published patches.  I have also been in contact with
Nakamura-san off list to coordinate patches and features with the
busybox people.


Thanks again for your insight!

- Ryan

> --
> Stephen Smalley
> National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
