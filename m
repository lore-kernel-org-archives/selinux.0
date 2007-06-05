Subject: Re: Can't login in F7 strict
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
References: <f71a82820706021820m34d5da17n56dcb312a061a988@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:48:19 -0400
Message-Id: <1181047699.25769.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-03 at 10:20 +0900, Shintaro Fujiwara wrote:
> Hello.
> 
> I'm trying to work out on F7 strict policy.
> My server is now FC6, so I'm trying to change it 7.
> 
> I yum installed every selinux related packages.
> I made localaudit.pp typing
> #audit2allow -i /var/log/audit/audit.log -m localaudit > localaudit.te
> at /usr/share/selinux/devel
> #semodule -i localaudit.pp
> violation reported by libsepol.chek_assertions
> 
> local_login_t local_login_t:netlink_audit_socket { nlmsg_relay };
> local_login_t local_login_t:capability { audit_write };
> local_login_t local_login_t:capability { audit_control };

These permissions should be allowed in the base policy, so this seems
like a bug in your specific policy.  They appear to be allowed in the
base policy.

As far as assertions go, please see prior explanations.  Policy contains
a set of neverallow rules to catch certain error cases or sensitive
permissions, and to override them you typically have to add a type
attribute to the type to indicate that it is supposed to be privileged
to override the restriction.  That is usually done via a suitable
refpolicy interface.

You can also disable all assertion checking, but that isn't recommended.

> 
> So,I commented those lines on localaudit.te including require brace.
> This time I succeeded installing localaudit.pp.
> 
> I restarted my machine setting Enforcing/strict.
> During the startup process, I could see Keymap had failed.
> I can't login from console.
> I typed like a US key not jp106, still I can't.
> 
> You made strict policy not logging in from console?
> What should I do?
> 
> 
> homepage http://intrajp.no-ip.com/
> SELinux Forum JP http://intrajp.no-ip.com/xoops
> SELinux Wiki JP http://intrajp.no-ip.com/pukiwiki
> my blog JP http://intrajp.no-ip.com/nucleus
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
