Subject: Re: Deprecating setlocaldefs, preservebools support in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1201203958.21288.120.camel@moss-spartans.epoch.ncsc.mil>
References: <1201203958.21288.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 14:49:56 -0500
Message-Id: <1201204196.21288.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 14:45 -0500, Stephen Smalley wrote:
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

I should note that the latter change would affect use of newer
libselinux on RHEL5 (we'd have to add the new setting
to /etc/selinux/config for the legacy behavior) or Debian etch.  Whereas
the former change only affects RHEL4.

> 
> Thoughts?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
