Message-ID: <44260A20.2030406@tresys.com>
Date: Sat, 25 Mar 2006 22:27:28 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: sds@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: How can modular policy ever have worked? [patch]
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>	 <1142867787.6145.18.camel@wintermute.xmldesign.de>	 <1142870455.16487.68.camel@moss-spartans.epoch.ncsc.mil> <1143331040.6084.15.camel@wintermute.xmldesign.de>
In-Reply-To: <1143331040.6084.15.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> Hello Stephen,
>>> Any progress on the optional{} in base.pp issues?
>> Hmmm...I thought optionals in base was fixed in the current version.
> 
> No, they are not. Since I added the patch I posted earlier - which is
> now in the refpolicy cvs for some time - I only obtain corrupt policies.
> 
> Today a user on IRC running Fedora had the very same problem:
> <rsc> Since upgrading to latest SELinux stuff from Fedora Core Rawhide,
> I'm getting tons of avc denied messages in syslog (serefpolicy targeted)
> <rsc> unfortunately, I can't downgrade selinux-policy for testing
> purposes
> <rsc> nearly every action is commented with avc denied
> <rsc> btw. /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> <rsc> libsemanage.semanage_reload_policy: load_policy returned error
> code 2.
> <rsc> while trying to switch one selinux-policy back
> 
> Well, this sounds _exactly_ like what I'm seeing. Tons of missing
> statements (because type attributes are not working anymore) and no way
> to load a different policy despite rebooting.
> 
> Anyone running the _current_ CVS refpolicy _successfully_?
> 
>> checkpolicy/test has a crude dispol program for dumping a binary policy.
> 
> With the dispol tool (menu choice 1) I get the following result:
> # grep "restorecon_t .* : file .* relabelto" dispol-result-1
> allow restorecon_t policy_config_t : file { relabelto read getattr lock
> ioctl };
> allow restorecon_t shadow_t : file { relabelto };
> 
> Just these two lines. When I do the same on my last working refpolicy
> build (without the optionals in base patch), I get 448 rules.
> 
> That's why I think the following line is not working properly anymore:
> allow restorecon_t { file_type  }:file { getattr relabelfrom
> relabelto };
> 
>> Reported your problem with apol yet?  sediff is useful for comparing two
>> policies, e.g. a monolithic build against a linked one from a modular
>> build.
> 
> Monolithic builds are broken AFAICT now, by the removal of the module
> name from the optional_policy statement... that way, the only optional
> policy you could maybe still build is the one containing all modules.
> When I downgrade policy/support/loadable_module.spt to the version with
> my original patch only, and downgrade to my latest version prior to the
> optional_policy $1 removal, I can build a monolithic policy.
> The dump 1 then contains 1090 "restorecon_t .* : file .* relabelto"
> lines.
> 
> So the type attributes are definitely broken somehow.

I can't reproduce this problem using the latest cvs refpolicy and latest 
cvs toolchain

refpolicy]# grep "restorecon_t .* : file .* relabelto" dump  | wc -l
1047

This is a fresh refpolicy checkout:
# cat build.conf | grep ^[A-Z]
TYPE = strict-mcs
NAME = refpolicy
DIRECT_INITRC=n
MONOLITHIC=y
POLY=n
QUIET=n

and I am able to load the resultant binary policy. Is there anything in 
your audit log or dmesg about the policy load failing? is there an MLS 
mismatch between the in kernel policy and the new one you just built?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
