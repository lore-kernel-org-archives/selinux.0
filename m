MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [patch] libselinux:  don't preservebools for Linux >= 2.6.22
Date: Tue, 5 Feb 2008 11:13:49 -0500
Message-ID: <C3CDF56D.55C0C%csellers@tresys.com>
In-Reply-To: <1202226145.27371.48.camel@moss-spartans.epoch.ncsc.mil>
From: "Chad Sellers" <csellers@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "Todd Miller" <tmiller@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/5/08 10:42 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> Since Linux >= 2.6.22 includes the logic to automatically preserve
> active boolean values across a policy reload, the libselinux load policy
> logic can check the kernel version and skip the userspace preservebools
> processing in that case.  This is cleaner than introducing a config
> option to /etc/selinux/config, as it will auto-detect the support and
> fall back to the compatibility behavior for older kernels.  Thus,
> this change does not change behavior for RHEL 5 or Debian etch.
> 
<snip>

Sounds good to me. This is also convenient for those that may be switching
between kernel versions. This way they don't have to continually change a
config file.

Chad



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
