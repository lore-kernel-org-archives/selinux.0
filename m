Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8IDBhxF005864
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 09:11:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8IDA1LY004225
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 13:10:02 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8IDA0sG004217
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 13:10:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Boot time avc messages
Date: Thu, 18 Sep 2003 23:11:36 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <200309172014.59503.russell@coker.com.au> <20030918130748.GC22480@vnl.com>
In-Reply-To: <20030918130748.GC22480@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309182311.36622.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Sep 2003 23:07, Dale Amon wrote:
> On Wed, Sep 17, 2003 at 08:14:59PM +1000, Russell Coker wrote:
> > On Wed, 17 Sep 2003 00:53, Dale Amon wrote:
> >
> > Here's a new syslogd.te that should solve most of the problems you had.
>
> I'm working on a merged policy and I'm curious why you ifdef on
> klogd.te. syslog-ng subsumes klogd, so I've not installed it and
> thus not installed klogd.te.

Which is why you need the ifdef so that syslogd_t gets the access that klogd_t 
would have if it was installed.

Check out the results of the policy once the macros are expanded.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
