Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5OMes3E026194
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 18:40:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5OMer5e008173
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 22:40:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5OMep92008166 for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 22:40:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dean Anderson <dean@av8.com>, selinux@tycho.nsa.gov
Subject: Re: proftpd
Date: Wed, 25 Jun 2003 08:40:43 +1000
References: <Pine.LNX.4.44.0306241457400.11428-100000@vista.av8.net>
In-Reply-To: <Pine.LNX.4.44.0306241457400.11428-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306250840.43592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jun 2003 05:15, Dean Anderson wrote:
> I'm having some trouble with the proftpd program, specifically, it won't
> seem to transition from the initrc domain to the ftpd_t domain

The daemon_domain() macro should take care of this.

> I relabeled the files (after changing the path to the proftpd binary to
> /usr/local/sbin/proftpd in file_contexts/programs/ftpd.fc
>
> ls --context /usr/local/sbin/proftpd
> shows system_u:object_r:ftpd_exec_t
>
> grep ftpd_exec_t policy.conf shows a type transition line:
> type_transition initrc_t ftpd_exec_t:process ftpd_t
>
> Yet, no effect. Rebooting also has no effect.

It seems that you've done all the right checks.  I'm not sure what's going 
wrong here.

> Interestingly, the radius.te file has this:
>
> domain_auto_trans(system_crond_t, radiusd_exec_t, radiusd_t)
>
> However, radius is not started by cron. What is up with this?

This is so that cron jobs for maintaining RADIUS run in the same domain.  It 
may be worth putting the cron job into a different domain, maybe 
radius_crond_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
