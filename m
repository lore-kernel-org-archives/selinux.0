Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91B9LrT000480
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 07:09:22 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91B8E4L001856
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 11:08:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: Access to xdm_t
Date: Fri, 1 Oct 2004 21:09:16 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <20040930192935.GA6063@lkcl.net> <1096591648.5736.3.camel@nexus.verbum.private>
In-Reply-To: <1096591648.5736.3.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410012109.16844.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 10:47, Colin Walters <walters@verbum.org> wrote:
> I think the idea with doing it inside ?dm was to keep common
> functionality inside the display manager; also it ensures you get an
> error log even if your session script fails early on (and gdm will offer
> to display the error log for example if your session lasts less than 10
> seconds, which it can really only do if it knows the name of the error
> log).
>
> So putting it inside each session script is generally wrong I think.

OK, we can have another script which just creates the error log file and 
launches the session script.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
