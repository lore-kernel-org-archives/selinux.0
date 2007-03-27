Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
	applet)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1175021034.29300.67.camel@sgc>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174927054.12204.45.camel@localhost.localdomain>
	 <1174939981.28830.84.camel@sgc>
	 <1174999512.3864.278.camel@moss-spartans.epoch.ncsc.mil>
	 <1175010151.29300.39.camel@sgc>
	 <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil>
	 <1175011333.19343.33.camel@localhost.localdomain>
	 <1175021034.29300.67.camel@sgc>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 14:47:54 -0400
Message-Id: <1175021274.3864.403.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 14:43 -0400, Christopher J. PeBenito wrote:
> On Tue, 2007-03-27 at 12:02 -0400, Karl MacMillan wrote:
> > * We are not just talking about reboots, we are also talking about
> > policy updates. I wouldn't expect installing an app to turn off a
> > lockdown mode, but that would happen if it installed policy.
> 
> Removing setlocaldefs will not change this behavior.  Current Boolean
> states will still be kept if you reload or update the policy on a
> running system.

That's true as long as at least that part of the policy loading logic is
preserved, i.e. the if (preservebools) block in selinux_mkload_policy()
in libselinux.  Which calls sepol_genbools_array() and thus requires
libsepol (or a cut-down version of it).  But the present load_policy
applet for busybox just calls security_load_policy() directly and won't
preserve booleans across reloads.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
