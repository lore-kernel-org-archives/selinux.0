Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21G9nrn006040
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:09:49 -0500
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21GBBtV015742
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 16:11:12 GMT
Received: by nz-out-0506.google.com with SMTP id z3so449729nzf
        for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2007 08:11:10 -0800 (PST)
Message-ID: <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
Date: Thu, 1 Mar 2007 08:10:56 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

Thanks for your time and reply!
My answers are in-lined below.

- Ryan

On 3/1/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2007-02-28 at 23:57 -0800, Ryan Bradetich wrote:

[snip]

> >        3. vi policy/modules.conf (:1,$s/= module/= off/g)
>
> Um, why do you expect this to work?  Looking at a modules.conf here,
> that would exclude userdomain from the build, and thus no user domains
> at all.  Which is fine from a dependency view (hence not in base) but
> not if you want users to login...

I understand and that was my first thought when I got the login error.
 In the SELinux by example book it does talk about this in section
6.3.2.  And there is a note in the book that matches my error
condition:  If the generic user_u or the Linux user is not explicitly
defined in the SELinux policy, logins will be denied ... even in
permissive mode.  I did the following comparisons between the policies
before I started debugging the libselinux1 library.  I apologize, I
did not put this information in my email notes.

   # grep '^[ \t]*user ' policy.conf.base
     user system_u roles { system_r };
     user user_u roles { user_r };
     user staff_u roles { staff_r sysadm_r  };
     user sysadm_u roles { sysadm_r };

   # grep '^[ \t]*user ' policy.conf.all
     user system_u roles { system_r };
     user user_u roles { user_r };
     user staff_u roles { staff_r sysadm_r  };
     user sysadm_u roles { sysadm_r };

Is my understanding correct that if these users are defined in the
policy.conf file and it successfully compiles into the binary policy,
then the user contexts should be available to the policy (even though
the userdomain module was not included?).

At this point, I am not sure why or how the user and role information
is getting added to the policy.conf file when only the base modules
are defined.  I found then when I went to add the users manually.   I
did not dig into the how part, I was more interested in why it was not
working.  I will need to understand the how part later as I continue
to strip down the base policies.

[snip]

> > [NOTE: why are we in the failsafe?  Seems like I am missing something
> > that would avoid this step].
>
> Yes, this means that there were no reachable contexts for the user from
> the login app's context in the policy.  Or no defined contexts for the
> user at all in the policy.  So it bails and tries the failsafe one as a
> fallback for recovery.

But in this case, there was no reachable contexts for the full policy
or the base-only policy.  In both cases I was always hitting the
failsafe context.   The only difference between the full-policy and
the base-only policy is the base-only policy failed to write to
/selinux/context.  Does this mean I have something configured
improperly on my system?

[snip]

> > This write system call is the difference between the everything policy
> > and the base-only policy files.   With the everything policy, this
> > write command successfully writes 23 bytes.   In the base-only policy,
> > the write command fails and sets errno to 22.
>
> Yes, because even the failsafe context wouldn't be defined if you
> excluded userdomain.

I did try to add the userdomain module as a stand-alone module, but it
requires the use of several other modules such as init, etc.  I can go
back and re-construct the list of required modules I needed to include
the userdomain module if this is of interest.  [NOTE: When I did have
the userdomain + required modules in place, I was able to login
successfully].


I understand I will need these modules eventually, but I am really
trying to get my head around how these modules work.  I will need this
detailed information since I plan to write a busybox SELinux policy
module which also implements the system functions like: init,
loginutils, logging, etc.


> --
> Stephen Smalley
> National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
