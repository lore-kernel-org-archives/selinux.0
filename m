Subject: Re: Separating libselinux/libsepol (Was: Re: BusyBox: load_policy
	applet)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <e739902b0703261958t27d288d3wde1f09e96a0fa488@mail.gmail.com>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703261958t27d288d3wde1f09e96a0fa488@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 08:32:01 -0400
Message-Id: <1174998721.29300.16.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 19:58 -0700, Ryan Bradetich wrote:
> Hello all,
> 
> Just thought I would add a few comments.
> 
> On 3/26/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2007-03-26 at 12:12 -0400, Christopher J. PeBenito wrote:
> > > So to summarize my rambling, my personal opinion is, embedded systems do
> > > not use managed policy, therefore do not require libsemanage.  They do
> > > not use a distro policy, but rather compile their own, therefore do not
> > > use the setlocaldefs support.
> 
> The embedded system I work on are typically higher end embedded
> systems, but everything on these devices are controlled from settings
> [NOTE: End-users are never provided a direct path to obtain shell
> access on the system].  While the current research I am doing for my
> thesis does not require module support, I could easily imagine
> situations where I would like both modules and boolean support.
> 
> Chris is correct though, we do tend to customize and compile
> everything to meet our space requirements, etc.  My goal is to fit my
> customized SELinux Debian based distribution in 16MB of flash.
> 
> I did read Stephen's RFC on setlocaldefs, but to be honest ... I do
> not have enough background to really understand it yet.   I will need
> some more time to dig in get a feel for the issue :(
> 
> > IIRC, the conditional policy support and loadable module support grew
> > out of some work investigating the use of SELinux on small mobile
> > devices, with an eye toward allowing things like:
> > - a daemon on the device to make controlled changes to policy via policy
> > booleans in response to events / environmental factors (some of which
> > should be preserved even if the device is rebooted),
> 
> I can imagine a couple different scenarios where I would like to have
> limited control over the policy via booleans based on events/commands
> originating from the SCADA operations center.

This mostly fits with what my idea of how booleans fit in.  I view them
as needing to be toggled based on the state of the device.  I still
don't agree that they need to be preserved, as the device is going to
have to reestablish its state when it boots, and can set the booleans at
that time.

> > - new applications for the device to come with their own policies w/o
> > requiring full policy sources or rebuild on the end systems (in
> > particular thinking of third party apps).  Further, being able to limit
> > what those application policies could allow was of interest, which also
> > brings into play something like policy management server (possibly a
> > very cut-down version).
> 
> A different take on this would be different modules could be loaded
> depending upon device settings.  For example, one of the settings on
> one of my devices might be to disable the HTTP server.   Based on this
> setting information, the SELinux web server policy could be optionally
> loaded or unloaded.  [NOTE: Settings changes on my embedded devices
> are very rare once they are in production, but are very common during
> the commissioning phase, so it is not unreasonable to require a reboot
> of the device on settings change if absolutely needed].

If the device requires configuration changes, I think the best answer is
the upcoming tunable support.  You could use just a base module and have
all the options.  Then you won't be wasting kernel memory on unused
configuration options since only the rules required for the
configuration settings are included in the final binary policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
