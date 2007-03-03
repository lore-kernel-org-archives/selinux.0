From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ryan Bradetich" <rbradetich@gmail.com>
Subject: Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Date: Sat, 3 Mar 2007 21:40:30 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com> <1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil> <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
In-Reply-To: <e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703032140.32482.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 03 March 2007 03:21, "Ryan Bradetich" <rbradetich@gmail.com> 
wrote:
> 2. Busybox provides the init functionality,  So I am going to start
> evaluating and reviewing the init module and figure out what is needed
> to successfully allow the kernel_t domain to transition to the init_t
> domain and do the work init busybox init needs to do.

domain_auto_trans(kernel_t, bin_t, init_t)

Not something we want for general-purpose desktop and server machines but 
should be fine for embedded systems.

> [NOTE: I will be asking the communities advice on shortly is how to
> handle busybox.  The problem is that busybox is a single binary that
> provides the functionality of many binaries (init, login, coreutils,
> etc).  I am not quite far enough to fully understand the problem, but
> I am pretty sure it will be a problem.  I will start a different
> thread on this problem soon.]

My conclusion after trying some of the other options is that the best thing to 
do is to divide busybox into several programs for different tasks.  So have 
one executable for programs that don't have domain transitions (ls, cp, 
etc) - you could include init in this as the kernel shouldn't be executing 
bin_t for anything else.

Then have one executable for login and getty (which will require a minor 
change to policy), one for klogd and syslogd (the policy option for syslog-ng 
should make that work), one for ifconfig and related sys-admin tools, one for 
ping and related privileged programs that users may run, etc.

Having 3-4 busybox executables that each have subsets of the busybox 
functionality should not cause a significant overhead if you are dynamically 
linking busybox (as is done on Familiar).

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
