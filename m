Subject: Re: modular policy: local module issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4624E91F.1080807@nagafix.co.uk>
References: <4624E91F.1080807@nagafix.co.uk>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 10:51:01 -0400
Message-Id: <1176994261.27654.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-17 at 16:34 +0100, Antoine Martin wrote:
> Hi all,
> 
> I am moving some of my old policies to the modular policy - using this
> page as a base:
> http://sepolicy-server.sourceforge.net/index.php?page=module-overview
> and I am having a few problems:
> 
> * Trying to use tmp_domain():
> logcheck.te:18:ERROR 'syntax error' at token 'tmp_domain' on line 77716:
> tmp_domain(logcheck)

Look for the equivalent refpolicy interface instead.

> * Removed this line, then:
> # make load
> Loading strict modules: logcheck
> libsepol.permission_copy_callback: Module local depends on permission
> dccp_recv in class node, not satisfied
> libsemanage.semanage_link_sandbox: Link packages failed

The implication is that you built the local module against newer
refpolicy headers than the base module was built against, thus picking
up newer kernel class/perm definitions that are not defined by the base
module.

> 
> Any ideas?
> 
> Thanks
> Antoine
> 
> # uname -r
> kernel 2.6.15-skas3-v8.2
> 
> # sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 20
> Policy from config file:        strict
> 
> sys-libs/libselinux 1.34.0
> sys-libs/libsemanage 1.10.0
> sys-libs/libsepol 1.16.2
> 
> Gentoo profile:
> /usr/portage/profiles/selinux/x86/2006.1
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
