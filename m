Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9U5sQWt011405
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 00:54:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9U5s9Uf013809
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 05:54:09 GMT
Received: from mail.rollinghorse.com (dsl093-033-002.snd1.dsl.speakeasy.net [66.93.33.2])
	by jazzswing.ncsc.mil  with ESMTP id h9U5s8tU013806
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 05:54:08 GMT
Message-Id: <5.2.1.1.2.20031029220923.0a743d10@Shire>
Date: Wed, 29 Oct 2003 22:11:13 -0800
To: russell@coker.com.au, "SE Linux" <selinux@tycho.nsa.gov>
From: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: Re: When to use SEL kernel
In-Reply-To: <200310271010.40888.russell@coker.com.au>
References: <5.2.1.1.2.20031024155304.0c94a990@Shire>
 <5.2.1.1.2.20031024155304.0c94a990@Shire>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At 15:13 26-10-03, Russell Coker wrote:
>On Sat, 25 Oct 2003 08:58, Carsten P. Gehrke wrote:
> > to this system (notably iptables).  My question is:  Does it matter if I
> > install additional packages before or after I install (and use) the SE
> > Linux kernel?
>
>When you install a new package (or upgrade an existing package) on a live SE
>Linux system then after installing the package you must relabel all files in
>it.  Discovering which files were installed from the source will be a
>challenge for you on a source-based distribution, so relabeling the root file
>system might be easier.
>
>If you do all your package installation before going live on SE Linux then it
>may be easier.
>
>--
>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
>http://www.coker.com.au/~russell/  My home page

Thank you Kamal and Russel.  I'll install the SE Linux package after I have 
installed everything else.  Then I'll probably have more questions... :-)


--
========================================================================
                             Carsten P. Gehrke
                      mailto:Carsten@RollingHorse.com
======================================================================== 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
