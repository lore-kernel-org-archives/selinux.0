Subject: Re: Failed write to /selinux/context in
	selinux_trans_to_raw_contex()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	 <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Mar 2007 06:54:31 -0500
Message-Id: <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-01 at 22:54 -0800, Ryan Bradetich wrote:
> Hello Stephen,
> 
> As you suggested, I found adding the following two lines to the
> policy.conf file allowed me to successfully login.
> 
> type sysadm_t;
> role sysadm_r types sysadm_t;
> 
> Just wanted to let you know I got it working!

You would need more than that to make it work correctly in enforcing
mode, as you have to allow the login domain to transition to it and you
have to allow the sysadm_t domain sufficient permissions to operate.
Which you would get just by including userdomain and its dependencies of
course.  If your goal is a stripped down policy, then I think you'll
find it simpler to go through userdomain and its dependencies and
gradually remove parts you think you don't need (re-testing at each
change to verify that it didn't break the system) than trying to create
your own user domains from the ground up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
