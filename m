Subject: Re: FW: Current/Future Plans to Support Stacking LSM Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom Fortmann <tfortmann@xcapesolutions.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <003801c739a6$461871f0$030a0a0a@ACER>
References: <003801c739a6$461871f0$030a0a0a@ACER>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 14:52:13 -0500
Message-Id: <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 13:41 -0600, Tom Fortmann wrote:
> Can you send me a pointer to the limited stacking that selinux supports?

http://www.nsa.gov/selinux/papers/module/x341.html

> I will join the LSM list.  I started here because LSM already supports a
> basic stacking method.  However, SELinux does not support the
> mod_reg_security call necessary to take advantage of this capability.  

No, SELinux does support trivial stacking by implementing a
register_security hook, which is what mod_reg_security() calls.  That is
used to combine SELinux with the Linux capabilities module.

> The product we are developing adds additional security at the application
> data layer.  It is a commercial product so I can't say a lot, other then to
> say that SELinux currently does not provide the additional features we are
> working on.

If you are adding additional security at the application data layer,
then you can do that in userspace, and use SELinux Type Enforcement to
make it unbypassable and tamperproof.  You don't need to change the
kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
