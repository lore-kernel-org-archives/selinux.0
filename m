Date: Wed, 28 Mar 2007 11:19:50 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ynakam@hitachisoft.jp, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        busybox@kaigai.gr.jp, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
 applet)
Message-Id: <20070328111950.1a07afef.ynakam@hitachisoft.jp>
In-Reply-To: <1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	<1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	<20070326102809.e4f80126.ynakam@hitachisoft.jp>
	<1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	<1174925566.28830.61.camel@sgc>
	<1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>
	<20070327095945.1c4245ec.ynakam@hitachisoft.jp>
	<1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Mar 2007 08:15:07 -0400
Stephen Smalley  wrote:
> On Tue, 2007-03-27 at 09:59 +0900, Yuichi Nakamura wrote:
> > Hi.
> > Thank you for opinion and information > Stephen, Christopher
> > 
> > My personal opinion is following:
> > # I think it is easier to explain my opinion by that than by commenting your posts.
> > 
> > I want to make SELinux easy to customize for various embedded devices.
> > The requirement for embedded SELinux will be various.
> > Someone may want to write strict policy for all processes, 
> > and some may want to write policy only for one or two applications.
> > Customize is neccesary.
> > 
> > If device is rich enough, 
> > full-featured SELinux can be used. 
> > Mobile PDA may be example of such devices.
> > It includes boolean, modular policy, semanage etc.
> > Size optimization for libsemanage,libsepol, semanage will be necessarty as you say.
> > 
> > However, what if devices are poor or there are small room for SELinux?
> > Example of such devices are electrical appliances conneceted to network.
> > In such environment, people want to make SELinux as small as possible.
> > They may remove modular support, libsepol and booleans, uses only monolitic poilcy.
> > I think even some hooks may be removed to improve performance.
> > Some of such people are now being attracted to other light-weight Secure OSes,
> > such as TOMOYO Linux(http://tomoyo.sourceforge.jp/en/1.3/) and AppArmor.
> >  
> > I want to make them to be interested in SELinux.
> > 
> > The SELinux for embedded in my brain(future SEDiet work) for now is following.
> > * Embedded SELinux development kit is prepared and it has following features.
> > * BusyBox includes SELinux commands
> > * Developers can choose required features(boolean, module, semanage etc)
> > * To implement it following will be necessary.
> > * libselinux/libsepol/libsemanage is separated
> > * Something like ENABLE_BOOLEAN, ENABLE_MODULE, ENABLE_SEMANAGE is embedded in source codes of libse*, BusyBox.
> > * Least set of refpolicy is prepared: 
> >   - only core policy(kernel policy module?) and macros are enabled by default
> >   - supports both modular and monolitic
> >   - To write new policy, SEEdit or other tools can be used
> >   - has a compiler that has feature for size optimization
> 
> For the most part, this approach sounds fine, and I suspect that you
> could even introduce a build option for creating a minimal subset of
> libselinux as well as the other libraries.  Note that the loadable
> policy module support depends on libsemanage, so I doubt you would
> support separate ENABLE_MODULE vs. ENABLE_SEMANAGE options unless you
> just mean the set of utility programs.
Yes. separating module and semanage does not make sense..
We are thinking about options that can be chosen by embedded developers..
We will propose in the future.

> Some specific questions and comments:
> 1) Do you think you will need the legacy support for setting local
> persistent booleans without using libsemanage?  We were planning on
> dropping that support out of libselinux and libsepol in the 2.x/devel
> series.
I saw discussion between you, Karl and Chris.
And I've understood legacy boolean support can be removed.
I and KaiGai will proceed to include preserve boolean support in load_policy BusyBox applet.
We will also try to reduce libselinux+libsepol size.

> 2) How do you plan to support initial policy load in the embedded
> environment?  From an initramfs, as proposed for Ubuntu, or via modified
> init functionality in busybox, as in current distributions that support
> SELinux?  Do you intend to replicate the logic that currently lives in
> selinux_init_load_policy() for selecting the initial state of SELinux
> (disabled/enforcing/permissive) based on /etc/selinux/config and the
> kernel parameters somewhere else?
I think it depends on devices.
I am using Open Zaurus, and its /sbin/init is a shell script, 
I am loading policy in shell script.
I think the most reasonable will be in /sbin/init binary.

> Do you intend to replicate the logic that currently lives in
> selinux_init_load_policy() for selecting the initial state of SELinux
> (disabled/enforcing/permissive) based on /etc/selinux/config and the
> kernel parameters somewhere else?
It depends on size.
I will use selinux_init_load_policy if the size is small enough,
if it is not small, I will write small selinux_init_load_policy.

As KaiGai said now,
to reduce size of libselinux+libsepol,
it is nice if we can pick up necessary fuctions from libselinux/libsepol by build option.
This means, not separated libselinux/libsepol, but tiny libselinux/libsepol.

> 3) I'd much prefer to see your policy optimization work go into
> refpolicy and any "optimizing" policy compiler work go into checkpolicy
> rather than keeping it in your own SEEdit-specific policy and tool.
I see.

> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
