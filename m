Message-ID: <4609CB85.1060401@ak.jp.nec.com>
Date: Wed, 28 Mar 2007 10:57:25 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Yuichi Nakamura <ynakam@hitachisoft.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
 applet)
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>	 <1174925566.28830.61.camel@sgc>	 <1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>	 <20070327095945.1c4245ec.ynakam@hitachisoft.jp> <1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> The SELinux for embedded in my brain(future SEDiet work) for now is following.
>> * Embedded SELinux development kit is prepared and it has following features.
>> * BusyBox includes SELinux commands
>> * Developers can choose required features(boolean, module, semanage etc)
>> * To implement it following will be necessary.
>> * libselinux/libsepol/libsemanage is separated
>> * Something like ENABLE_BOOLEAN, ENABLE_MODULE, ENABLE_SEMANAGE is embedded in source codes of libse*, BusyBox.
>> * Least set of refpolicy is prepared: 
>>   - only core policy(kernel policy module?) and macros are enabled by default
>>   - supports both modular and monolitic
>>   - To write new policy, SEEdit or other tools can be used
>>   - has a compiler that has feature for size optimization
> 
> For the most part, this approach sounds fine, and I suspect that you
> could even introduce a build option for creating a minimal subset of
> libselinux as well as the other libraries.  Note that the loadable
> policy module support depends on libsemanage, so I doubt you would
> support separate ENABLE_MODULE vs. ENABLE_SEMANAGE options unless you
> just mean the set of utility programs.
> 
> Some specific questions and comments:
> 1) Do you think you will need the legacy support for setting local
> persistent booleans without using libsemanage?  We were planning on
> dropping that support out of libselinux and libsepol in the 2.x/devel
> series.

I want to mention that separating libselinux/libsepol is not the only way
to reduce binary size.
Is it possible to replace some functions rare needed in the target system
by empty implemented functions, isn't it? I think this approach enables
more flexible selection of functionalities than the simple separation.

The typical example is userspace avc. I think seldom people use userspace
object managers like XACE/SELinux on embedded systems.
The sum of avc.o, avc_internal.o and avc_sidtab.o is about 32kb (on i386).
Because the size of libselinux.a is about 146kb, we will be able to reduce
about 20% of binary size.

Currently, I don't have actual measurement of the minimum binary size of
libsepol needed to handle preserving boolean variables and so on.
Who can estimate it?

Thanks,

> 2) How do you plan to support initial policy load in the embedded
> environment?  From an initramfs, as proposed for Ubuntu, or via modified
> init functionality in busybox, as in current distributions that support
> SELinux?  Do you intend to replicate the logic that currently lives in
> selinux_init_load_policy() for selecting the initial state of SELinux
> (disabled/enforcing/permissive) based on /etc/selinux/config and the
> kernel parameters somewhere else?
>
> 3) I'd much prefer to see your policy optimization work go into
> refpolicy and any "optimizing" policy compiler work go into checkpolicy
> rather than keeping it in your own SEEdit-specific policy and tool.

-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
