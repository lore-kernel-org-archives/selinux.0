Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA21587
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 11:54:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23643
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 15:52:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA23639 for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 15:52:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: azeredo@qmc.ufsc.br
Subject: Re: Problems compiling selinux on SuSe 7.2
Date: Wed, 11 Sep 2002 17:53:37 +0200
Cc: selinux@tycho.nsa.gov
References: <1031756508.3d7f5adca337f@qmc.ufsc.br>
In-Reply-To: <1031756508.3d7f5adca337f@qmc.ufsc.br>
MIME-Version: 1.0
Message-Id: <200209111753.37846.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Sep 2002 17:01, azeredo@qmc.ufsc.br wrote:
>  I am trying to compile selinux on SuSe 7.2. I got the last package version
> of lsm-2.4-selinux-2002082308.tgz with kernel 2.4.19 and got the following
> error: I have tried with kerberos 5 from mandrake distribution and also
> with heimdal that comes with suse. But the error is the same, namely

Probably better to ask Brian than me, Brian's the Heimdal expert.

Do you REALLY need kerberos?  If not then it's probably best to compile 
without support.

If you do need kerberos then you'll probably want SE support on the kerberos 
ticket server first and we don't seem to have a policy for that yet, maybe 
you or Brian should write it first...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
