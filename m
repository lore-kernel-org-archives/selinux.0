Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04HNL5e013468
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 12:23:21 -0500
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l04HO6VJ028842
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 17:24:07 GMT
Date: Thu, 4 Jan 2007 09:24:00 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Latest diffs
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701050407.14369.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <158008.45123.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> Could we have a version of locate that is a little
> slower than usual and which 
> just calls find without telling the user?  :-#

One of the first things I noticed as an important
difference between Unix and Linux is how much
faster (the second) find / is on Linux than it is
on Unix. I say go for it. As mentioned before,
locate is a holdover from the days when a MIPS
was a lot of compute power and disc platters
were a foot across.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
