Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MCnXdW022302
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 07:49:34 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MCitMK012745
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 12:44:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jayendren@mweb.co.za
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Tue, 22 Feb 2005 23:46:59 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <200502220809.40631.jayendren@hivsa.com> <200502221752.34349.russell@coker.com.au> <200502221151.19612.jayendren@hivsa.com>
In-Reply-To: <200502221151.19612.jayendren@hivsa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502222347.02398.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 20:51, Jayendren Anand Maduray 
<jayendren@hivsa.com> wrote:
> syslogd reports it is unable to start, error:
> ´Access Denied´
> the same message for portmapper.
>
> do u want a copy of the syslog?

Not the entire syslog.  Just run "dmesg" and look for entries that seem 
relevant.

>From your other message it seems that /etc/passwd has lost it's label somehow.  
Please try running "restorecon /etc/passwd" and see if things work properly 
after that.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
