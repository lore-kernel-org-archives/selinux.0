Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8K6XGsJ002462
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 02:33:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8K6VYd0020813
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 06:31:34 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8K6VWVY020810
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 06:31:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Boot time avc messages
Date: Sat, 20 Sep 2003 16:32:59 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <200309172245.18594.russell@coker.com.au> <20030919154123.GF22480@vnl.com>
In-Reply-To: <20030919154123.GF22480@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309201632.59282.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Sep 2003 01:41, Dale Amon wrote:
> On Wed, Sep 17, 2003 at 10:45:18PM +1000, Russell Coker wrote:
> > It will work on any recent policy tree of mine or of a NSA tree with the
> > patches and revisions I have recently posted to the list.
> > I am not sure of what is in Colin's tree at the moment.
>
> Okay, I merged it, although I had to comment out the crond_log_t
> dependance since that type isn't here.

For best results change that to cron_log_t or whatever the cron logfile type 
is in your policy.

> Still loads of messages from syslog-ng. I wonder if I'm the
> first user of this policy who actually uses the full capability
> of remote logging with syslog-ng? I'm going to see if I can

Probably.  Let me know what you are getting and I'll change my policy 
accordingly.

> figure out how much of the error output is related to that.
> I know at least the one complaining about port=999 is due
> to that.

Why does it use port 999?

> Colin seems to have left out newrules.pl from his packages,
> or else it's in one I don't know about.

It should be named newrules-selinux.  Having binaries ending in .pl is a bad 
idea, when you run a program you don't want to concern yourself with what 
language it was written in.  Also when you upgrade to a new version of a 
program you shouldn't be bothered by any change in language.

Calling the program simply "newrules" is a bad idea, it's too ambiguous, there 
could be hundreds of programs that require new rules.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
