Subject: Re: sshd transition points (user@ip or net_context with setcon)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050221134124.GR14038@lkcl.net>
References: <20050221134124.GR14038@lkcl.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:01:10 -0500
Message-Id: <1109080870.2256.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-21 at 13:41 +0000, Luke Kenneth Casson Leighton wrote:
> e.g. oh i dunno, being able to lock down the priv_sep sshd,
> and the monitor process, because they would have distinct
> selinux domains?

Being able to assign different permissions (particularly different
capabilities) to the listening sshd, parent monitor process, and
unprivileged child process seems useful.  But that doesn't require
anything per-user and can be done _before_ the user identity is even
acquired from the client.  It would be better to switch domains prior to
processing input from the client (other than the initial connection) to
reduce the likelihood of exploitation prior to the domain switch.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
