Subject: Re: shadow
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801311146l626f8c29o1460ef3e5e7682d3@mail.gmail.com>
References: <dd18b0c30801311146l626f8c29o1460ef3e5e7682d3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 31 Jan 2008 15:02:15 -0500
Message-Id: <1201809735.4568.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-31 at 19:46 +0000, Justin Mattock wrote:
> Hello; with /etc/shadow what might I be doing wrong; I keep receiving:
> libsepol.check_assertion_helper: assertion on line 137107 violated by
> allow newrole_t shadow_t:file { read };
> libsepol.check_assertion_helper: assertion on line 137107 violated by
> allow  crond_t shadow_t:file { read};
> libsepol.check_assertion_helper: assertion on line 137107 violated by
> allow sysadm_sudo_t shadow_t:file { read };
> 
> am I not supposed to use newrole in a root terminal! or is this
> something else. In my desperation I commented
> out /etc/selinux/refpolicy/policy/modules/system/authlogin.te
> line 48 : [ #neverallow ~can_read_shadow_passwords shadow_t:file
> read; ] to allow my self to newrole login. I dont like messing with
> any of the neverallow rules; what am I missing? 

pam_unix is supposed to fall back to invoking unix_chkpwd to check
passwords if the process cannot directly read the shadow file.  Thus,
policy doesn't give those domains permission to directly read shadow and
only the chkpwd domains (with some exceptions) require such access.

The avc denials should be suppressed by dontaudit rules, unless you've
rebuilt with those stripped from the policy.

The neverallow is to ensure that you don't accidentally give direct
access to shadow via audit2allow.

If you use the proper refpolicy interface to grant access to shadow,
then the domain will be added to the can_read_shadow_passwords attribute
and the neverallow won't fail.  But you shouldn't be granting direct
access here unless your pam_unix lacks the necessary support for falling
back to chkpwd.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
