Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA03079
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 08:58:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1QDwrI28663
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 13:58:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h1QDwrf28659 for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 13:58:53 GMT
Received: from localhost (wsalamon@localhost)
	by vox.gw.tislabs.com (8.11.2/8.11.2) with ESMTP id h1QDw7r03779
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 08:58:07 -0500
Date: Wed, 26 Feb 2003 08:58:07 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Core policy, second pass
Message-ID: <Pine.LNX.4.33.0302260856550.3682-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Sorry about that last empty message.

I've done some experimentation with a subset of the policy files. This
policy builds (with some changes required as attached). I need to further
examine denials, but so far there doesn't appear to be very many.

Here's a list of policy files I used:

atd.te          dhcpc.te     ldconfig.te     newrole.te     su.te
automount.te    fsadm.te     load_policy.te  sxid.te
bootloader.te   getty.te     login.te        passwd.te      syslogd.te
checkpolicy.te  ifconfig.te  logrotate.te    ping.te        tmpreaper.te
chkpwd.te       inetd.te     lpd.te          portmap.te
crond.te        initrc.te    lpr.te          rpm.te         useradd.te
crontab.te      init.te      modutil.te      selopt.te      utempter.te
ipchains.te     mount.te     setfiles.te
devfsd.te       klogd.te     netutils.te     ssh.te

  I needed to change two of the macros so far (see attached patch). Being
that you can run lpr without lpd, the lpr_macros.te file conditionally
uses types from lpd.te.

  I left selopt.te in for now, but it can be removed. If core is defined
to allow SELinux experimentation, then selopt can stay.

  Comments? Any of the above that are unnecessary? Any not included that
are necessary? I know rpm.te could probably be removed as well, but if
users typically query installed packages, I think it's needed.


-- 
Wayne Salamon
wsalamon@tislabs.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
