Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07492
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 08:50:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23879
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:49:25 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA23875 for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 13:49:24 GMT
Date: Mon, 11 Feb 2002 08:49:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init - am I missing something?
In-Reply-To: <20020209012156.49DED32FDF1@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202110845440.5822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 9 Feb 2002, Russell Coker wrote:

> It seems to me that run_init should just quietly change to
> system_u:system_r:initrc_t without asking for any passwords if run from
> system_u:system_r:init_t.  That way the same /etc/init.d/* scripts can be
> used by the sysadmin to restart daemons and also for them to be started
> automatically on boot.
>
> Is there anything I'm missing here?  Is there some need to do otherwise?

When running from system_u:system_r:init_t, you shouldn't need to use
run_init at all.  There is an automatic domain transition from init_t to
initrc_t when running one of the /etc/rc.d/rc* scripts (with the
initrc_exec_t type).  If you need init to be able to directly run a
/etc/init.d script, then you should just apply the initrc_exec_t type to
those scripts as well.  run_init is only needed to support a secure
transition from sysadm_r:sysadm_t.

> Also I've hacked my run_init to just run the program if it's run on a non-SE
> system so that the same start scripts can be used with an SE kernel or a
> non-SE kernel.  Any good reasons for not doing this?

That's fine.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
