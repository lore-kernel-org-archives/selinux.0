Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01597
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:36:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA12461
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:35:11 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA12457 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:35:11 GMT
Date: Tue, 1 Oct 2002 07:36:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brian May <bam@snoopy.apana.org.au>, <selinux@tycho.nsa.gov>
Subject: Re: Editing crontabs
In-Reply-To: <200210010017.34485.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210010734350.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Russell Coker wrote:

> The same domain as them.  If you're sysadm_r then you should have permissions
> to change to that role.
>
> Or I guess it would make sense to put the following in
> macros/programs/crontab_macros.te:
> allow sysadm_crontab_t $1_crontab_t:file { getattr read };
>
> Of course we must not give create or write access to the other user's crontab
> file to prevent mistakes...

As long as you assume that sysadm_t is the most privileged user domain,
then this should be fine.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
