Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA25400
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 02:43:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA01455
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 06:41:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id GAA01451 for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 06:41:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Problems compiling selinux on SuSe 7.2
Date: Thu, 12 Sep 2002 08:43:20 +0200
Cc: azeredo@qmc.ufsc.br, selinux@tycho.nsa.gov
References: <1031756508.3d7f5adca337f@qmc.ufsc.br> <200209111753.37846.russell@coker.com.au> <20020911230717.GA17728@snoopy.apana.org.au>
In-Reply-To: <20020911230717.GA17728@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200209120843.20157.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 01:07, Brian May wrote:
> > Do you REALLY need kerberos?  If not then it's probably best to compile
> > without support.
>
> If you wish to use Kerberos, and know what Kerberos is, then you
> probably want it.

Of course.

> Otherwise, if the only reason you got here is because it tried to
> automatically link in the Kerberos libraries, you would be better off
> disabling kerberos support in openssh.

Yes, I got the impression that the person asking the questions may have had 
this problem (or alternately they may have patched a copy of the SSH source 
that was prepared by someone who uses kerberos).

> > If you do need kerberos then you'll probably want SE support on the
> > kerberos ticket server first and we don't seem to have a policy for that
> > yet, maybe you or Brian should write it first...
>
> Its on my TODO list. Along with other items like "update Debian Heimdal
> to latest upstream version" and "help get the latest krb4 into testing,
> as it is holding up lots of other packages (including Heimdal)".

Sounds like you're really busy.

Are you sure you want to take over the woody port of SE Linux?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
