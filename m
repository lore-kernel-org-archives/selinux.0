Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFpRrT027894
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:27 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFofMZ015293
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:50:41 GMT
Date: Tue, 24 Aug 2004 15:53:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: running make relabel from a cronjob
Message-ID: <20040824145315.GD4698@lkcl.net>
References: <20040824110741.GI25356@lkcl.net> <1093348538.1800.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093348538.1800.45.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 07:55:38AM -0400, Stephen Smalley wrote:
> On Tue, 2004-08-24 at 07:07, Luke Kenneth Casson Leighton wrote:
> > the following patches allow the attached /etc/cron.d/selinux program
> > to successfully run.
> > 
> > this is for a user-only system where root access will not be given
> > out, and there won't be any maintenance or support, either.
> > 
> > i heard from someone that Fedora also has a cronjob doing a make
> > relabel too, so i am slightly confused that the strict selinux policy
> > doesn't presently have this already oh well.
> 
> See the cron_can_relabel boolean in crond.te and the fixfiles.cron
> script in policycoreutils.  If CRONTYPE=relabel is in
> /etc/selinux/config and the cron_can_relabel boolean is enabled, then
> cron will (and can) relabel.  Otherwise, cron will merely check file
> contexts and mail a report about incorrect contexts.  It doesn't need to
> access policy sources; there is an installed file_contexts file in
> /etc/selinux/$SELINUXTYPE/contexts/files that is used at runtime for
> restorecon, fixfiles, etc.
 
 ah ha!

 great.  thank you v. much.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
