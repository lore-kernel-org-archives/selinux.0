Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2R2wZUv005791
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 22:58:35 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2R2wYok016535
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 02:58:34 GMT
Received: by ug-out-1314.google.com with SMTP id y2so2045800uge
        for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:58:31 -0700 (PDT)
Message-ID: <e739902b0703261958t27d288d3wde1f09e96a0fa488@mail.gmail.com>
Date: Mon, 26 Mar 2007 19:58:30 -0700
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Separating libselinux/libsepol (Was: Re: BusyBox: load_policy applet)
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Yuichi Nakamura" <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Chad Sellers" <csellers@tresys.com>
In-Reply-To: <1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

Just thought I would add a few comments.

On 3/26/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-03-26 at 12:12 -0400, Christopher J. PeBenito wrote:
> > So to summarize my rambling, my personal opinion is, embedded systems do
> > not use managed policy, therefore do not require libsemanage.  They do
> > not use a distro policy, but rather compile their own, therefore do not
> > use the setlocaldefs support.

The embedded system I work on are typically higher end embedded
systems, but everything on these devices are controlled from settings
[NOTE: End-users are never provided a direct path to obtain shell
access on the system].  While the current research I am doing for my
thesis does not require module support, I could easily imagine
situations where I would like both modules and boolean support.

Chris is correct though, we do tend to customize and compile
everything to meet our space requirements, etc.  My goal is to fit my
customized SELinux Debian based distribution in 16MB of flash.

I did read Stephen's RFC on setlocaldefs, but to be honest ... I do
not have enough background to really understand it yet.   I will need
some more time to dig in get a feel for the issue :(

> IIRC, the conditional policy support and loadable module support grew
> out of some work investigating the use of SELinux on small mobile
> devices, with an eye toward allowing things like:
> - a daemon on the device to make controlled changes to policy via policy
> booleans in response to events / environmental factors (some of which
> should be preserved even if the device is rebooted),

I can imagine a couple different scenarios where I would like to have
limited control over the policy via booleans based on events/commands
originating from the SCADA operations center.

> - new applications for the device to come with their own policies w/o
> requiring full policy sources or rebuild on the end systems (in
> particular thinking of third party apps).  Further, being able to limit
> what those application policies could allow was of interest, which also
> brings into play something like policy management server (possibly a
> very cut-down version).

A different take on this would be different modules could be loaded
depending upon device settings.  For example, one of the settings on
one of my devices might be to disable the HTTP server.   Based on this
setting information, the SELinux web server policy could be optionally
loaded or unloaded.  [NOTE: Settings changes on my embedded devices
are very rare once they are in production, but are very common during
the commissioning phase, so it is not unreasonable to require a reboot
of the device on settings change if absolutely needed].

One other example is information in the settings could be used to
generate the policy file themselves.  For example, the HTTP protocol
typically listens on port 80, but this port number is actually a user
configurable setting.   On a settings change, I could have my embedded
device generate the appropriate HTTP module using the current port
setting information and the load the module.

The idea of a policy  management server is also intriguing,  but I am
still trying to get my head around SELinux and how I can successfully
use it in my environment.  No comments from me yet on the policy
management server yet :)

> So I'd be concerned about not supporting such things ever in the
> embedded space, and would like to have a strategy for working toward
> such support even it isn't going to be in the initial version.  And I
> think that the mainline selinux would benefit from such work as well, as
> some optimizations may be applicable in general w/o sacrificing much in
> the way of real functionality.

I would also like to see this.   I am planning on following this email
up with my customized policy (based on the refpolicy) that I am using
for my thesis research.
The reason I bring this up here is my binary policy (version 21) size
is 18k.   While the refpolicy is a great start, and I am hoping with
more embedded people getting interested in SELinux, that we can also
work on the policy size as well as flexibility in the future.

Thanks!

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
