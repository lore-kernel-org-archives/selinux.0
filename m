Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ACJerT026787
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:19:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ACJWP2020031
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:19:35 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 22:20:19 +1000
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
References: <20040610114741.2796A3A4066@abyss.simplyaquatics.com>
In-Reply-To: <20040610114741.2796A3A4066@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406102220.19165.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 21:47, "Ed Street" <edstreet@street-tek.com> wrote:
> Then shouldn't it be postfix_etc_t instead of etc_t?

We could do something like that, although it would still require breaking the 
design aim of "application should not have write access to it's own config 
files".

I think that the ideal solution would be to have a better mechanism of turning 
off chroot operation.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
