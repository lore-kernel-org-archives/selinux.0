Subject: Re: Failed write to /selinux/context in
	selinux_trans_to_raw_contex()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	 <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
	 <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Mar 2007 12:23:38 -0500
Message-Id: <1172856218.19041.703.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-02 at 08:21 -0800, Ryan Bradetich wrote:
> Yep, I understand it will not work in enforcing mode yet.  My system
> still needs a lot of work before I can put it into enforcing mode
> because I am using busybox instead of the standard Unix tools (that
> already have policies).
> 
> My goal is more than just a stripped down policy.  I am currently
> researching SELinux for a specific usage.  On paper, I have already
> broken the system down into high level domains and have defined
> high-level interactions between these domains.  I do not believe the
> refpolicy will meet all my needs, but I am hoping to leverage as much
> as I can from the refpolicy.
> 
> 
> Here is the rough plan I am pursuing to get busybox up and working on my system.
> 
> 1. Strip the policy down to just the base modules.   I needed the
> above fix to allow me to login in.  I am at this point right now.
> 
> 2. Busybox provides the init functionality,  So I am going to start
> evaluating and reviewing the init module and figure out what is needed
> to successfully allow the kernel_t domain to transition to the init_t
> domain and do the work init busybox init needs to do.
> 
> [NOTE: I will be asking the communities advice on shortly is how to
> handle busybox.  The problem is that busybox is a single binary that
> provides the functionality of many binaries (init, login, coreutils,
> etc).  I am not quite far enough to fully understand the problem, but
> I am pretty sure it will be a problem.  I will start a different
> thread on this problem soon.]

Yes, it is an issue.  You aren't the first to encounter it, e.g.
http://www.coker.com.au/selinux/talks/ols2003/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
