Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03189
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 13:07:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA03016
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:04:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA03012
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:04:31 GMT
Message-Id: <200303031815.NAA18399@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 13:15:23 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, third pass
To: wsalamon@tislabs.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wayne Salamon wrote:
> checkpolicy.te  getty.te     ldconfig.te     netutils.te  su.te
> chkpwd.te       ifconfig.te  load_policy.te  newrole.te   syslogd.te
> crond.te        inetd.te     login.te        passwd.te    tmpreaper.te
> crontab.te      initrc.te    logrotate.te    portmap.te
> init.te         modutil.te   setfiles.te     useradd.te
> fsadm.te        klogd.te     mount.te        ssh.te
> 
>   This policy will build as long as the recent su_macros.te and
> lpr_macros.te files are used.

As a side note, netutils.te should likely be split up into separate
domains for the differing needs of these utilities, and some of the
other networking utilities should likely be placed into one of these
domains.  The current netutils.{te,fc} isn't very well-defined.
We should likewise look into whether the existing ping.te and traceroute.te
domains should be folded into a single 






--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
