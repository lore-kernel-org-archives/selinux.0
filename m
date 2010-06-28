Subject: Re: Rebuilding Modified Base Policy on RHEL6 (was  on-Computing
 Abstractions & An Issue Thereof)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Kramer <josh@globalherald.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4C2687E7.5000705@globalherald.net>
References: <289557.20002.qm@web87003.mail.ird.yahoo.com>
	 <4C2652F3.8010309@globalherald.net>  <4C2687E7.5000705@globalherald.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Jun 2010 14:13:07 -0400
Message-ID: <1277748787.12016.76.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-06-26 at 19:06 -0400, Joshua Kramer wrote:
> 
> > Is the method for rebuilding policy explained in the following
> > guide, still effective for RHEL6? 
> > http://danwalsh.livejournal.com/26428.html 
> > 
> Ok, so I followed the instructions on the noted page; specifically,
> near the bottom.  This line works to rebuild policy on RHEL6:
> 
> make validate UNK_PERMS=allow NAME=strict TYPE=mcs DISTRO=redhat
> UBAC=n DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024
> base
> 
> However, if I do this, to switch the build from strict to targeted:
> 
> cd ~/sources/BUILD/serefpolicy-VERSION
> make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
> DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 bare
> make conf
> make UNK_PERMS=allow NAME=targeted TYPE=mcs DISTRO=redhat UBAC=n
> DIRECT_INITRC=y MONOLITHIC=n POLY=y MLS_CATS=1024 MCS_CATS=1024 conf

NAME= just defines an arbitrary name for the policy; it is only used as
the name of the directory into which the policy is installed
(under /usr/share/selinux and /etc/selinux).  It does not select the
kind of policy that is built.

TYPE= selects the kind of policy that is built, and there are no longer
distinct cases for targeted vs strict, as they have long since been
merged together.  TYPE=mcs is what you want for Fedora/RHEL unless you
want MLS, in which case you want TYPE=mls.

I note that you ran make conf twice above, once without any settings and
once with a collection of settings, and I have to wonder what state that
left your build tree in.  I'd do a 'make bare' again and then just edit
build.conf with the settings you want so that you don't have worry about
getting them all right on the command line each time.

> ...the make breaks with this error:
> 
> Creating targeted base module base.conf
> cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
> tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
> base.conf
> Compiling targeted base module
> /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
> /usr/bin/checkmodule:  loading policy configuration from base.conf
> policy/modules/kernel/domain.te":195:ERROR 'type selinux_config_t is
> not within scope' at token ';' on line 9468:
> #line 195
>     dontaudit domain selinux_config_t:dir { getattr search open };
> /usr/bin/checkmodule:  error(s) encountered while parsing
> configuration
> make: *** [tmp/base.mod] Error 1
> 
> It breaks even with a non-modified policy (i.e. install src.rpm and
> run this make command).
> 
> Do I need to do this, even if I only want to build a modified
> "targeted" version of the policy?  Is it "strict" by default?

No, you don't need to do that, and there is no such thing as strict
policy anymore.  If you want the behavior of strict policy, you just map
users to confined roles via semanage and if you want to go fully to
strict behavior, you can remove the unconfined module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
