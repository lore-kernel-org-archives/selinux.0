Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01964
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:52:58 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Editing crontabs
Date: Tue, 1 Oct 2002 13:52:48 +0200
Cc: Brian May <bam@snoopy.apana.org.au>, <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210010734350.1579-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210010734350.1579-100000@raven>
MIME-Version: 1.0
Message-Id: <200210011352.48238.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 13:36, Stephen Smalley wrote:
> On Tue, 1 Oct 2002, Russell Coker wrote:
> > The same domain as them.  If you're sysadm_r then you should have
> > permissions to change to that role.
> >
> > Or I guess it would make sense to put the following in
> > macros/programs/crontab_macros.te:
> > allow sysadm_crontab_t $1_crontab_t:file { getattr read };
> >
> > Of course we must not give create or write access to the other user's
> > crontab file to prevent mistakes...
>
> As long as you assume that sysadm_t is the most privileged user domain,
> then this should be fine.

Well that assumption goes right through the default policy.  Removing or 
changing it would be as much work as it was to make multiple user roles work 
properly (which incidentally is still not complete).

I've added the following to my policy tree:
allow sysadm_crontab_t $1_cron_spool_t:file { getattr read };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
