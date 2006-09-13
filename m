Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DIo5WI005997
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 14:50:05 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8DIndPv029264
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 18:49:39 GMT
Subject: Re: More policy changes from Debian
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158157098.1594.29.camel@wintermute.xmldesign.de>
References: <1158157098.1594.29.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 14:45:14 -0400
Message-Id: <1158173114.26420.93.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 16:18 +0200, Erich Schubert wrote:
> Attached are three more diffs.
> - moving logcheck from logrotate policy to logwatch. Seems more
> appropriate. Since logcheck runs as user logcheck, cron will search
> the home directory.  I don't want cron to search the logrotate dirs.

Merged.

- moved up the cron.te change.
- rearranged the additions logwatch.te a little.

One thing that needs to be investigated is the logrotate_lock_t type.
Since you added logcheck_lock_t, my guess is that logrotate_lock_t can
be removed.

> - apt needs getattr_all_fs, to check for free diskspace.

Merged.

> - sxid wants to read the /etc/localtime symlink. I guess access
> to /etc is okay.

Fixed miscfiles_read_localization() instead.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
