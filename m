Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AMG3rT002229
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:16:04 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AMFwP2000790
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:15:58 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 22:16:01 -0000
Date: Thu, 10 Jun 2004 22:13:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610221321.GW2861@lkcl.net>
References: <20040610202615.GC2861@lkcl.net> <20040610203956.A59FC3A4069@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610203956.A59FC3A4069@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 04:39:54PM -0400, Ed Street wrote:
> Hello,
> 
> As stated numerous times in the past write access to etc_t is a horrible
> idea.  

 so bad it's banned by a special policy build-time auditing rule :)

> What would be better is maybe use postfix_etc_t or something similar,
> correct me if I'm wrong but are we not already using postfix_etc_t? if so
> then maybe a postfix_spool_etc_t.

 i was thinking along similar lines.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
