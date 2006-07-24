Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6OGQHMg000564
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 12:26:17 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6OGQFqo008903
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 16:26:16 GMT
Message-ID: <20060724162559.84696.qmail@web36607.mail.mud.yahoo.com>
Date: Mon, 24 Jul 2006 09:25:59 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Existence of "helper" functions (specifcally MLS)
To: Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1153755260.6122.85.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Also, in general, we try to avoid MLS-specific logic
> outside of the
> policy engine; in many cases, applications that
> might historically have
> done a specific MLS dominance check on a traditional
> trusted OS should
> instead be performing a SELinux permission check via
> avc_has_perm or
> security_compute_av, and then you can internally map
> that permission to
> a MLS relationship via the mlsconstrain statements
> in the policy.  So
> the first question is whether this application
> should be performing a
> MLS label comparison at all, or whether we can
> abstract that to a
> service permission check.

Are you making the assumption that the
objects involved are among those protected
by the kernel? Application objects (e.g.
print jobs, mail messages, X11 windows, cron
jobs) may be maintained strictly by an
application that enforces policy. In such
cases the application requires access to
mechanism to determine on its own if an
access should be permitted. In the context
of an evaluation it will be very important
for the MLS policy enforcement on application
objects to be concise and clearly defined.
I expect that, as you mention above,
security_compute_av(3) is the "right" choice
for doing this. It does put the burden
of proof on the lower level function. I'd
be concerned regarding performance, but
I'm sure that issue will recieve all the
attention it needs.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
