Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1T3KrRb020486
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 22:20:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1T3JFlK004678
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 03:19:15 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1T3IxOX004666
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 03:19:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Date: Sun, 29 Feb 2004 13:44:28 +1100
References: <20040228181418.GO11147@vnl.com>
In-Reply-To: <20040228181418.GO11147@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402291344.28017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Feb 2004 05:14, Dale Amon <amon@vnl.com> wrote:
> Colin's /usr/sbin/policy-remove-unwanted gets into trouble
> when you are using syslog-ng and do not have klogd installed:

The syslog.te file has policy to allow syslog-ng to perform klogd 
functionality.  Why don't you have syslogd working in that manner?

> I think he needs to special case this and either test
> for syslog-ng if the .te to be removed is klogd and
> klogd is not found; or else simply never remove klogd.te
> under any circumstance.

Making klogd.te depend on syslog-ng would be easy enough.  But why is it 
necessary?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
