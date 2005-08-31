Subject: Re: [PATCH] show correct error message when a policy has duplicate
	declarations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1125510199.5306.59.camel@localhost.localdomain>
References: <1125510199.5306.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 14:09:42 -0400
Message-Id: <1125511782.18888.347.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-31 at 13:43 -0400, Jason Tang wrote:
> Although checkpolicy/checkmodule catch duplicate declarations, the
> compiler prints the wrong message.  This patch alters the program so that it
> shows the correct message.

Hmm...interesting.  Adding a duplicate type declaration for device_t, I
see the following behaviors before and after this patch:

Before:
checkpolicy: module_compiler.c:318: declare_type: Assertion `0' failed.

After:
types/device.te:16:ERROR 'Out of memory!' at token ';' on line 3855:

type device_t;
checkpolicy:  error(s) encountered while parsing configuration

Somewhat improved, but still not what we want.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
