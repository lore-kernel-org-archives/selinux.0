Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Russell Coker <russell@coker.com.au>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
In-Reply-To: <200404141310.i3EDAlJx015401@gotham.columbia.tresys.com>
References: <200404141310.i3EDAlJx015401@gotham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1081949423.23747.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 14 Apr 2004 09:30:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-04-14 at 09:11, Karl MacMillan wrote:
> As far as preserving boolean values, this doesn't seem any different from
> other runtime kernel values and there are mechanism that can be easily
> extended to handle this.

So you are suggesting something akin to /etc/sysctl.conf for boolean
values and running something akin to sysctl -p from /etc/rc.d/rc.sysinit
to set the boolean value during initialization?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
