Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1T4lCRb020761
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 23:47:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1T4jYlK005778
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:45:34 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1T4jXOX005767
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:45:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Date: Sun, 29 Feb 2004 15:45:38 +1100
Cc: selinux@tycho.nsa.gov
References: <20040228181418.GO11147@vnl.com> <200402291344.28017.russell@coker.com.au> <20040229042610.GA11147@vnl.com>
In-Reply-To: <20040229042610.GA11147@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402291545.38528.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Feb 2004 15:26, Dale Amon <amon@vnl.com> wrote:
> On Sun, Feb 29, 2004 at 01:44:28PM +1100, Russell Coker wrote:
> > The syslog.te file has policy to allow syslog-ng to perform klogd
> > functionality.  Why don't you have syslogd working in that manner?
>
> I just thought about what you said here. Are we on the
> same page? The problem I'm seeing is to do with Colin's
> script deciding to remove klogd.te because there is no
> klogd debian package installed... which is because the
> debian syslog-ng package doesn't need the klogd package.

That should be OK, the policy is written to support this.

> This causes a problem later because the POLICY files
> require klogd.te regardless of whether there is a
> klogd debian package or not.

What is the problem?  When I compile a policy without klogd (suitable for a 
syslog-ng system) it works.

Problems can't be fixed until they are correctly described.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
