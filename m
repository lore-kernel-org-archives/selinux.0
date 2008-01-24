Message-ID: <4798FD01.9060807@manicmethod.com>
Date: Thu, 24 Jan 2008 16:02:57 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Deprecating setlocaldefs, preservebools support in libselinux
References: <1201203958.21288.120.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201203958.21288.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> I'd still like to deprecate setlocaldefs support and preservebools
> support in libselinux in the trunk (i.e. libselinux 2.x).  I posted
> patches for completely removing such support a long while ago, but those
> particular patches would require an ABI change (as they include API
> removal) and thus I held off on them, but we could also take the more
> intermediate approach of just turning off the functionality by default
> in libselinux without disturbing the ABI.
>
> As a refresher, setlocaldefs support refers to the support for pulling
> in local boolean and user definitions at policy load time w/o managed
> policy, i.e. the approach used in RHEL4 and Fedora 3 and 4 (but not in
> Fedora 5 and later or RHEL5).  By default, libselinux still checks for
> such definitions and patches them into the in-memory policy at load time
> unless /etc/selinux/config has SETLOCALDEFS=0.  I'd like to make
> SETLOCALDEFS=0 the default in the trunk and require SETLOCALDEFS=1
> in /etc/selinux/config to enable the old behavior.
>
> preservebools support refers to the support for preserving active
> boolean values across a policy reload by having libselinux patch the
> active values into the in-memory policy at policy load time.  As of
> Linux 2.6.22 and later, this is now handled automatically by the kernel
> as part of the policy reload and isn't needed in userspace.  I'd like to
> also disable this by default in libselinux and perhaps allow it to be
> enabled via some /etc/selinux/config setting.
>
> Thoughts?
>   

I'm fine saying its deprecated but CLIP currently uses an updated 
toolchain for both RHEL5 and RHEL4 (adds policy management capabilities 
to RHEL4) so removing the boolean preservation functionality would be 
detrimental. setlocaldefs isn't used very often afaik but we sometimes 
build systems where the use of 'managed policy' is objected to, in which 
case the only way to add users is via users.local. With this in mind 
we'll just have to be careful when upgrading the CLIP toolchain not to 
use a version that eventually removes this support.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
