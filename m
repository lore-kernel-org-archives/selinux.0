Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5C8curT009828
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:38:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5C8cmP2018164
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:38:49 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Regular Expression Problem
Date: Sat, 12 Jun 2004 18:38:48 +1000
Cc: selinux@tycho.nsa.gov
References: <20040612063426.65218.qmail@web51509.mail.yahoo.com>
In-Reply-To: <20040612063426.65218.qmail@web51509.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406121838.48401.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 12 Jun 2004 16:34, Park Lee <parklee_sel@yahoo.com> wrote:
> As I know: '.' stands for any character;
> Let's suppose '.' now stands for character 'a'.
> then '/var(/.*)' can mean:
> '/var/a','/var/aa','/var/aaa','/var/aaaa','/var/aaaaa', ... ...

The '*' is evaluated before the '.'.  So /var(/.*) expands to '/var/.', 
'/var/..', '/var/...', and then in each case the '.' characters are expanded 
independently.

See regex(7) for all the details.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
