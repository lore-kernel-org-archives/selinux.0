Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1IHfXZ028514
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:17:41 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1IGKCC021828
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 18:16:20 GMT
Subject: Re: patch: add assert statement for syslog
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <200411011745.iA1HjGZ0004102@turing-police.cc.vt.edu>
References: <20041101102345.GA3377@jmh.mhn.de>
	 <200411011745.iA1HjGZ0004102@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1099332844.21386.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 13:14:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 12:45, Valdis.Kletnieks@vt.edu wrote:
> Unless I'm missing a 'privlog' entry on a 'type' line someplace, this
> basically means that unless you write some policy, an arbitrary program can't
> syslog() at all.  This does help prevent "flood the syslog" attacks, but
> I'm not sure we want to be *that* draconian without a site-settable flag.
> 
> It sort of renders /usr/bin/logger in a shell script useless, for starters...

The patch merely adds an assertion to verify what should already be true
in the policy, i.e. that every domain authorized to write to the
/dev/log socket has the privlog attribute. syslogd.te includes the
following rules that allow this to happen for such domains:

# Domains with the privlog attribute may log to syslogd.
allow privlog devlog_t:sock_file rw_file_perms;
can_unix_send(privlog,syslogd_t)
can_unix_connect(privlog,syslogd_t)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
