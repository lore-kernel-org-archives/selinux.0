Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IEFYlb011792
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 10:15:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7IEF9x0017100
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 14:15:09 GMT
Subject: Re: refpoliy issues
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155863972.7443.36.camel@wintermute.xmldesign.de>
References: <1155863972.7443.36.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 10:15:38 -0400
Message-Id: <1155910539.14126.17.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-18 at 03:19 +0200, Erich Schubert wrote:
> Reference policy issues I've come around recently:
> 
> - sxid not in role system_r, missing access to /dev

Already fixed the role.  You'll have to be more specific about access
to /dev.

> - cron needs to su for certain cronjobs

Can you be more specific?

> - semanage writes netfilter_contexts to default_contexts instead of the
> files subdir (default contexts is read only for semanage)?

Already added the rule.  Putting netfilter_contexts in files doesn't
make any sense because its not for file labeling.

> - load_policy tries to contact setrans, but I don't have setrans (found
> also no docs on it or source...) - but the rules to search /var/run are
> only active when setrans policy was loaded. This probably applies to
> other apps as well.
> and it tries to make a unix_stream_socket

I believe setrans is in fedora cvs.  The access looks like its only due
to libselinux's init; however, if you're using MLS or MCS, you're really
going to want the translation daemon anyway.

> I don't know much about this one:
> 
> kernel: audit(1155735318.128:5897): avc:  denied  { relabelfrom } for
> pid=3325 comm="sshd" name="0" dev=devpts ino=2
> scontext=system_u:system_r:sshd_t:s0-s0:c0.c255
> tcontext=root:object_r:sysadm_devpts_t:s0 tclass=chr_file
> 
> on each ssh login.

Based on the evidence that relabelfrom on unpriv user ptys is
dontaudited, my guess is this is also a dontaudit.  I'm guessing you
have sysadm ssh login on?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
