Subject: Re: Is SIDs no longer used?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040608043054.58295.qmail@web51505.mail.yahoo.com>
References: <20040608043054.58295.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1086704448.32292.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 08 Jun 2004 10:20:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-06-08 at 00:30, Park Lee wrote:
>         Then, I want to ask: Is SIDs really no longer used? If it's
> true, What does the policy enforcement code of SELinux typically
> handle?

The kernel still uses SIDs internally, but it no longer exports its SIDs
to userspace.  Only security contexts are exported to userspace. 
However, the userspace AVC (in libselinux) provides its own SID mapping
for userspace policy enforcers such as security-enhanced X and
security-enhanced dbus.  That SID mapping is private to each policy
enforcer.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
