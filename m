Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA29151
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:50:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PLokI05351
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 21:50:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1PLoif05345 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 21:50:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Trent Jaeger <jaegert@us.ibm.com>
Subject: Re: Core policy and TCB
Date: Tue, 25 Feb 2003 22:50:31 +0100
Cc: selinux@tycho.nsa.gov
References: <OF4A38669D.D36073FC-ON85256CD8.0061512D-85256CD8.0063FC56@us.ibm.com>
In-Reply-To: <OF4A38669D.D36073FC-ON85256CD8.0061512D-85256CD8.0063FC56@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302252250.31098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Feb 2003 19:12, Trent Jaeger wrote:
> I would like to prove that the TCB subject types are protected from the
> rest of the system (i.e., the integrity of these TCB subject types should
> only be dependent on input from other TCB subject types) .  As a first
> step, I have used Biba integrity as the basis to see where integrity issues
> are.  I have used my policy analysis prototype to collect the Biba
> integrity violations in the policy.  I could provide a table of such
> violations to those that are interested or to the list if enough interest.

I think it would be appropriate for the list.  Please send me a private copy 
if you decide not to post to the list.  If you feel it's too big for the list 
then perhaps a web page for it would be suitable.

> As a summary, there are some ad hoc issues (like dpkg discussed earlier --
> I included it in the TCB because I assumed that it was a fundamental system
> update tool)

dpkg is a fundamental system tool for Debian.  The rpm policy is not as 
important for Red Hat because AFAIK no-one has attempted to do the types of 
live updates on Red Hat systems that I routinely do on Debian systems.

> dictate a resolution strategy (deny, audit, etc.).  For example, sys admins
> have access to all files, but they should probably audited upon access to
> low integrity files (and denied altogether on some).  This could be
> relative to the integrity spec rather than changing the attribute
> relationships...

Currently the only file that the system administrator is denied access to is 
/etc/shadow (to prevent accidentally re-labelling it to the wrong type).  
Also much access of device nodes is denied.  Are there any other areas that 
you think should be denied?

I have experimented with denying sysadm_t read access to tmpfile:lnk_file but 
that gets annoying quickly when "ls -l" doesn't return correct results.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
