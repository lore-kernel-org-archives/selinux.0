Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6N2h3VB019069
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 22:43:04 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6N2gtT2026638
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 02:43:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: what is the point of semodule -u?
Date: Wed, 23 Jul 2008 12:42:49 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200807231017.30237.russell@coker.com.au> <1216779113.3580.6.camel@sulphur>
In-Reply-To: <1216779113.3580.6.camel@sulphur>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807231242.51484.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 23 July 2008 12:11, Stephen Smalley <stephen.smalley@gmail.com> 
wrote:
> So for example if you ran semodule -u *.pp on some directory full of .pp
> files, it would only actually install modules that already had prior
> versions of the same module installed and that were newer in version
> number.

Have you found it to work like that?

I tested on Debian/Etch and CentOS 5.2 and found that it would abort on the 
first error.

Of course you could do:
for n in *.pp ; semodule -u $n ; done

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
