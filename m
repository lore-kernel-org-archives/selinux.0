Subject: Re: Updated policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41F6A47E.9010407@redhat.com>
References: <41F6A47E.9010407@redhat.com>
Content-Type: text/plain
Message-Id: <1106841450.28623.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 27 Jan 2005 10:57:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 14:56, Daniel J Walsh wrote:
> Fixes for targeted crond to run as unconfined and still have transitions 
> work.

I'm a little unclear on the current direction of the targeted policy.  I
see that you are putting more programs like login and crond into
domains, but then adding unconfined_domain() to them and allowing them
to transition to unconfined_t.  What is the purpose of such domains?

As a side note, do you truly want crond to run directly in
system_crond_t (normally only used for system cron jobs in the strict
policy, vs. crond_t for the daemon itself).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
