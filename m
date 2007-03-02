Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l22GJigh002387
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 11:19:44 -0500
Received: from ik-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l22GL5OK013733
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 16:21:06 GMT
Received: by ik-out-1112.google.com with SMTP id b32so534474ika
        for <selinux@tycho.nsa.gov>; Fri, 02 Mar 2007 08:21:04 -0800 (PST)
Message-ID: <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
Date: Fri, 2 Mar 2007 08:21:03 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	 <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
	 <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

On 3/2/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2007-03-01 at 22:54 -0800, Ryan Bradetich wrote:
> > Hello Stephen,
> >
> > As you suggested, I found adding the following two lines to the
> > policy.conf file allowed me to successfully login.
> >
> > type sysadm_t;
> > role sysadm_r types sysadm_t;
> >
> > Just wanted to let you know I got it working!
>
> You would need more than that to make it work correctly in enforcing
> mode, as you have to allow the login domain to transition to it and you
> have to allow the sysadm_t domain sufficient permissions to operate.
> Which you would get just by including userdomain and its dependencies of
> course.  If your goal is a stripped down policy, then I think you'll
> find it simpler to go through userdomain and its dependencies and
> gradually remove parts you think you don't need (re-testing at each
> change to verify that it didn't break the system) than trying to create
> your own user domains from the ground up.

Yep, I understand it will not work in enforcing mode yet.  My system
still needs a lot of work before I can put it into enforcing mode
because I am using busybox instead of the standard Unix tools (that
already have policies).

My goal is more than just a stripped down policy.  I am currently
researching SELinux for a specific usage.  On paper, I have already
broken the system down into high level domains and have defined
high-level interactions between these domains.  I do not believe the
refpolicy will meet all my needs, but I am hoping to leverage as much
as I can from the refpolicy.


Here is the rough plan I am pursuing to get busybox up and working on my system.

1. Strip the policy down to just the base modules.   I needed the
above fix to allow me to login in.  I am at this point right now.

2. Busybox provides the init functionality,  So I am going to start
evaluating and reviewing the init module and figure out what is needed
to successfully allow the kernel_t domain to transition to the init_t
domain and do the work init busybox init needs to do.

[NOTE: I will be asking the communities advice on shortly is how to
handle busybox.  The problem is that busybox is a single binary that
provides the functionality of many binaries (init, login, coreutils,
etc).  I am not quite far enough to fully understand the problem, but
I am pretty sure it will be a problem.  I will start a different
thread on this problem soon.]

3. Identify the next module that is throwing AVC errors and repeat
step 2 until I am happy I have a working system.

4. Set the box in enforcing mode to make sure everything still works
as I expected.

5. Test and evaluate the policy.


Hopefully the additional background on what I am trying to do makes
sense.  I am not trying to re-invent the wheel, just wanted to get the
system down to a the base, so I could start adding the additional
module functionality I need in the busybox module.

Thanks again for your time and input!

- Ryan

P.S Unfortunately, time for work.  I will have to respond to your next
email at lunch or after work tonight.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
