Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA24465
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 19:07:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA09552
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 23:06:09 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id XAA09546
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 23:06:06 GMT
Date: Thu, 12 Sep 2002 09:07:17 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: azeredo@qmc.ufsc.br, selinux@tycho.nsa.gov
Subject: Re: Problems compiling selinux on SuSe 7.2
Message-ID: <20020911230717.GA17728@snoopy.apana.org.au>
References: <1031756508.3d7f5adca337f@qmc.ufsc.br> <200209111753.37846.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209111753.37846.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 11, 2002 at 05:53:37PM +0200, Russell Coker wrote:
> On Wed, 11 Sep 2002 17:01, azeredo@qmc.ufsc.br wrote:
> >  I am trying to compile selinux on SuSe 7.2. I got the last package version
> > of lsm-2.4-selinux-2002082308.tgz with kernel 2.4.19 and got the following
> > error: I have tried with kerberos 5 from mandrake distribution and also
> > with heimdal that comes with suse. But the error is the same, namely

What version of heimdal is this? I am not familiar with Suse.

> Probably better to ask Brian than me, Brian's the Heimdal expert.

The API from Heimdal and MIT Kerberos isn't 100% compatable.

It is possible that openssh needs to be patched before it
will compile against Heimdal.

I know other people have compiled openssh with Heimdal, I haven't
done it myself though.

> Do you REALLY need kerberos?  If not then it's probably best to compile 
> without support.

If you wish to use Kerberos, and know what Kerberos is, then you
probably want it.

Otherwise, if the only reason you got here is because it tried to
automatically link in the Kerberos libraries, you would be better off
disabling kerberos support in openssh.

> If you do need kerberos then you'll probably want SE support on the kerberos 
> ticket server first and we don't seem to have a policy for that yet, maybe 
> you or Brian should write it first...

Its on my TODO list. Along with other items like "update Debian Heimdal
to latest upstream version" and "help get the latest krb4 into testing,
as it is holding up lots of other packages (including Heimdal)".
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
