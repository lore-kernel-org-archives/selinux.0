Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1M6t4dW020989
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 01:55:04 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1M6qmZE017767
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 06:52:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jayendren@mweb.co.za
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Tue, 22 Feb 2005 17:52:31 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <200502220809.40631.jayendren@hivsa.com>
In-Reply-To: <200502220809.40631.jayendren@hivsa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502221752.34349.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 17:09, Jayendren Anand Maduray 
<jayendren@hivsa.com> wrote:
> 1. however when i try to change my password, i get the ffg error:
> SystemError: couldn't get security context of `/etc/passwd': No data
> available

Do you get any AVC messages?  If so what are they?

What is the output of "ls -lZ /etc/passwd"?

> 2. also, when i boot up, syslogd, and portmap cannot start, so i disabled
> it in SELinux. i would like to get this to work, though.

How are they unable to start?  Are there any AVC messages?  Is there something 
in syslog?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
