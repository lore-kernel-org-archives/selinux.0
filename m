Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OBv0rT025509
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:57:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OBuxCV029811
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:56:59 GMT
Subject: Re: running make relabel from a cronjob
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040824110741.GI25356@lkcl.net>
References: <20040824110741.GI25356@lkcl.net>
Content-Type: text/plain
Message-Id: <1093348538.1800.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 07:55:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 07:07, Luke Kenneth Casson Leighton wrote:
> the following patches allow the attached /etc/cron.d/selinux program
> to successfully run.
> 
> this is for a user-only system where root access will not be given
> out, and there won't be any maintenance or support, either.
> 
> i heard from someone that Fedora also has a cronjob doing a make
> relabel too, so i am slightly confused that the strict selinux policy
> doesn't presently have this already oh well.

See the cron_can_relabel boolean in crond.te and the fixfiles.cron
script in policycoreutils.  If CRONTYPE=relabel is in
/etc/selinux/config and the cron_can_relabel boolean is enabled, then
cron will (and can) relabel.  Otherwise, cron will merely check file
contexts and mail a report about incorrect contexts.  It doesn't need to
access policy sources; there is an installed file_contexts file in
/etc/selinux/$SELINUXTYPE/contexts/files that is used at runtime for
restorecon, fixfiles, etc.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
