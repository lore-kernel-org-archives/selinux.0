Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01265
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 10:35:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA22878
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 15:32:35 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA22874
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 15:32:34 GMT
Message-Id: <200303031543.KAA18309@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 10:43:24 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, third pass
To: selinux@tycho.nsa.gov, wsalamon@tislabs.com
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

Sorry, I must have missed it earlier, but I'd exclude portmap.te from
core as well.  I'm also not sure about inetd.te; is it worth retaining
it in "core", since we are excluding the inetd-started services
(and the crucial ones are superseded by sshd)?

>   We plan on tagging the current Sourceforge selinux tree 'preCore', then
> moving non-core .te files to domains/program/unused. The next phase is to
> then audit/reduce the core policy.

This sounds fine to me.  I'd expect that the audit/reduction should
start with the global macros, with corresponding updates to the core
domains to keep them functioning (but hopefully with fewer
permissions), and then proceed to audit/reduce the individual rules in
the core domain .te files.  The non-core domains will be temporarily
broken as you reduce or remove global macro definitions, but they can
be addressed after the core policy is in good shape.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
