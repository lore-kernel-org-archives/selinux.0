Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ALP6rT001690
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:25:06 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5ALP1P2028609
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:25:01 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 21:25:04 -0000
Date: Thu, 10 Jun 2004 21:22:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610212224.GJ2861@lkcl.net>
References: <200406102220.19165.russell@coker.com.au> <20040610193218.8DD243A4066@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610193218.8DD243A4066@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Thu, 10 Jun 2004 21:47, "Ed Street" <edstreet@street-tek.com> wrote:

> > Then shouldn't it be postfix_etc_t instead of etc_t?
> 
> We could do something like that, although it would still require breaking
> the 
> design aim of "application should not have write access to it's own config 
> files".
> 
> I think that the ideal solution would be to have a better mechanism of
> turning 
> off chroot operation.

 i've raised a debian wishlist bugreport asking them to consider
 adding in a question "if installing under se/linux i really should
 set SYNC_CHROOT="" in /etc/default/postfix for you".

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
