Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85AjqrT017092
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 06:45:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85Ajnt0027949
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 10:45:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: log file names (was Additional rule files)
Date: Sun, 5 Sep 2004 20:45:46 +1000
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com,
   Debian Devel <debian-devel@lists.debian.org>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de>
In-Reply-To: <1094260356.29689.44.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409052045.46899.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Sep 2004 11:12, Erich Schubert <erich@debian.org> wrote:
> The next two rule sets are for the statistic tools "bindgraph" and
> "mailgraph". The first parses bind query logs and does nice graphs out
> of them, the second does the same for postfix+amavis logs.

Do we need to have two different domains for programs that do the same thing?

Both bindgraph and mailgraph can read the same file types as input and their 
output can be accessed by cgi-bin scripts.  It seems that there is little (if 
any) benefit in isolating them.

If we were to assign different types to different log files (may require code 
changes in syslogd) then we could deny the mailgraph program the ability to 
read log files other than mail.log and deny the bindgraph program the ability 
to read mail.log.

Also note that in your policy both those programs can read /var/log/auth.log 
(Debian) and /var/log/secure (Fedora).  This is not desirable, we probably 
should make changes to the syslog setup.

One possible change is greater use of sub-directories in /var/log.  We could 
have /var/log/security/ for auth.log, secure, and any other security critical 
log files and /var/log/mail/ for mail server log files (including POP server, 
and maybe webmail), etc.  Doing this would allow different types for the log 
files with no code changes to syslogd, and this would make it more beneficial 
to have separate domains for mailgraph and bindgraph.

I've CC'd this to fedora-selinux and debian-devel because if we make such 
changes then we want to get some cross-distribution agreement on file names.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
