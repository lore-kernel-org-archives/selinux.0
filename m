Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050331165116.92416.qmail@web31601.mail.mud.yahoo.com>
References: <20050331165116.92416.qmail@web31601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 13:16:50 -0500
Message-Id: <1112293010.11216.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-31 at 08:51 -0800, Casey Schaufler wrote:
> Existing MLS systems allow unprivileged
> applications to run unmodified. In at least
> one case that included an unmodified X server.
> You have to do at least as well as the unix MLS
> systems to be credible. You think that's a
> low bar, so you shouldn't have any trouble,
> right?

You can certainly allow applications to run unmodified on SELinux today.
But there can be benefit from modifying applications to provide stronger
isolation and true least privilege in the future.  And users do care
about these "unprivileged" applications corrupting or leaking their
data.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
