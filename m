Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA07701
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 09:21:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25256
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 14:20:21 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA25252 for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 14:20:20 GMT
Date: Mon, 11 Feb 2002 09:20:51 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: vixie cron patch and also MLS
In-Reply-To: <20020211045646.F19B2101A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202110906240.5822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 11 Feb 2002, Russell Coker wrote:

> >From a quick code inspection it appears that if the user name matches the
> start of a line in /etc/security/cron_context then the context of that line
> will be used.
>
> So for the default setup if I get the sysadmin to give me an account named
> "sy" then my cron jobs will be run as system_u:system_r:system_crond_t, or if
> I get an account named "roo" (actually had a user with that account name
> once) then I'd get my cron jobs run as root:sysadm_r:sysadm_crond_t!
>
> I think that in the get_user_sid() function the following code:
>          if (strncmp(name, bufp, name_len) == 0) {
> Should be changed to:
>          if (strncmp(name, bufp, name_len) == 0 && bufp[name_len] == ':') {

I don't think so.  Look again at how 'name' is constructed and 'name_len'
is computed.  The terminating colon is included.

Also, notice that crond performs a check between the user context and the
context on the crontab file.  Consequently, even if this were a bug, the
entrypoint check would likely fail on the user's crontab file.

> Also is there any way to determine programmatically if we are running in MLS
> mode?  Having #ifdef CONFIG_FLASK_MLS in the cron code is ugly and is likely
> to cause pain (I don't want to recompile my daemons when switching to/from
> MLS mode).
>
> Also in libsecure/src/get_user_sid.c there's a lot of #ifdef CONFIG_FLASK_MLS
> code.  So it looks like changing to/from MLS requires a recompile of the
> library code and a recompile of all programs linked with -lsecure!
>
> Is the plan to make MLS mandatory in the near future (IE to drop support for
> SE Linux without MLS)?  If so then the current situation will probably do (no
> point coding too much support for something that's going away).  But if the
> plan is to continue to support a choice of MLS or non-MLS then I think it
> needs to be improved.

I agree that this is ugly and needs to be fixed, but I don't know when we
are likely to get to it.  To date, the MLS policy component has not been a
priority.  I doubt that it would ever be made "mandatory" - there are
plenty of users who will want RBAC/TE but will not care about MLS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
