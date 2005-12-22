Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03J1dXf022837
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:01:39 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03J1bah000600
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:01:37 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k03J0mB6032320
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:00:48 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k03J0m35032319
	for selinux@tycho.nsa.gov; Tue, 3 Jan 2006 14:00:48 -0500
Date: Wed, 21 Dec 2005 20:10:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, Chris Wright <chrisw@sous-sol.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Adding audit messge to newrole
Message-ID: <20051222041008.GW20219@sorel.sous-sol.org>
References: <20051220221439.16245.qmail@web51505.mail.yahoo.com> <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On Tue, 2005-12-20 at 14:14 -0800, Steve G wrote:
> +static void drop_capabilities(void)
> +{
> +  uid_t uid = getuid();
> +
> +  if (uid) { /* Non-root path */
> +    cap_t new_caps;
> +    cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
> +
> +    /* Keep capabilities across uid change */
> +    prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> +
> +    /* Change uid */
> +    if (setuid(uid)) {
> +      fprintf(stderr, _("Error changing uid, aborting.\n"));
> +      exit(-1);
> +    }
> +
> +    /* Now get rid of this ability */
> +    prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0);
> +
> +    /* We should still have root's caps, so let drop them. */
> +    new_caps = cap_init();
> +    if (!new_caps) {
> +      fprintf(stderr, _("Error initing capabilities, aborting.\n"));
> +      exit(-1);
> +    }
> +    cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
> +    cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
> +    if (cap_set_proc(new_caps)) {
> +      fprintf(stderr, _("Error dropping capabilities, aborting"));

While moot, it's a leak ;-)

> +      exit(-1);
> +    }
> +    cap_free(new_caps);
> +  }
> +}
> 
> Why don't you drop capabilities first, then switch to the real uid?
> Otherwise, you have a task with the caller's uid and full capabilities
> for an interval of time, right?

As you noted later, you must retain at least CAP_SETUID (and
CAP_AUDIT_WRITE) in order to drop uid.  It should be done as early as
possible during startup.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
