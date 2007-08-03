Subject: Re: libsepol.print_missing_requirements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820708021357o66c94abbgfd73370b98fdbcca@mail.gmail.com>
References: <f71a82820708021357o66c94abbgfd73370b98fdbcca@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 15:41:59 -0400
Message-Id: <1186170119.2434.313.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-03 at 05:57 +0900, Shintaro Fujiwara wrote:
> Hi,
> I made a .pp file by policygentool in devel directory.
> But can not istall .pp file in strict policy.
> I added many type/attribute as global requirements.
> And finally, libsemanage says common (null) were not met.

Show the actual output of semodule, and attach your .te file.

> I did
> 
> semodule -b base.pp
> 
> in /usr/share/selinux/strict directory,
> but can_send_audit_msg were not met.

Wait, first you say you tried installing a .pp file that you generated
via policygentool, but now you say you are trying to install the base.pp
file from strict?

> so, I did
> 
> semodule -b base.pp
> 
> in /etc/selinux/strict/modules/active
> 
> it worked.

And now you are re-installing the already installed base module from
strict?  Are /etc/selinux/strict/modules/active/base.pp
and /usr/share/selinux/strict/base.pp identical?

> Still I can't install my .pp file.
> 
> 
> Why and what sould I do ?
> 
> Please help...
> 
> version

> policycoreutils-2.0.16-6.fc7
> policycoreutils-2.0.16-11.fc7
> policycoreutils-2.0.16-10.fc7

Hmm...three versions of policycoreutils?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
