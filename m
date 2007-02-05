Subject: Re: Problems installing current version of refpolicy with FC6
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Catalin DIMA <dima@univ-paris12.fr>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <45BE6262.5080902@univ-paris12.fr>
References: <45BE44FC.8080303@univ-paris12.fr>
	 <45BE4FC6.4090502@mentalrootkit.com>  <45BE6262.5080902@univ-paris12.fr>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:34:09 -0500
Message-Id: <1170689649.12293.271.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-29 at 22:08 +0100, Catalin DIMA wrote:
> Karl MacMillan wrote:
> 
> > Just to check - are you certain that you want the full policy? You may 
> > be able to do the teaching you need with policy modules only.
> 
> Do you mean I should compile&load the modular policy ? I certainly would 
> like to do this, as it's supposed to be easily configurable & suitable 
> for experimenting small modules.

Just to clarify, you don't need to install refpolicy from tresys to
compile and load policy modules; FC6 ships with a modular policy based
on refpolicy, so you can create your own policy modules and load them
without ever touching the base policy.  See the Fedora SELinux FAQ and
wiki pages.  You only need to rebuild the base policy if you want to
make a fundamental change to the policy.

Also, you can grab the selinux-policy .src.rpm from the Fedora site
(just like any other .src.rpm) and build from it rather than building
from an upstream release if you want to keep it as close as possible to
the Fedora settings.

> 
> > Did you enable mcs? The standard FC6 policy is targeted-mcs and the 
> > presence of the mcs components in the file system labels may be the 
> > cause of your problems.
> 
> I tried again this build.conf format :
> 
> TYPE = targeted-mcs
> NAME = refpolicy
> DISTRO = redhat
> DIRECT_INITRC=n
> MONOLITHIC=n
> MLS-SENS=16
> MLS_CATS=256
> 
> Done make conf, make install and make load, then configured for 
> refpolicy & asked for relabeling, and the system gets stuck...
> 
> Btw, forgot to mention the libsepol.sepol_genbools: error while reading 
> /etc/selinx/refpolicy/booleans error...
> 
> In permissive refpolicy mode, the only selinux message talks about 
> NetworkManager.
> 
> > The unknown boolean messages should be harmless I believe.
> >
> > You can extract the build.conf from the policy source rpm as well, 
> > which is likely a good starting point.
> 
> The problem is the same with the rpm and the bz2...
> 
> Thanks,
> Catalin.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
