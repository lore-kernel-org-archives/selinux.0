Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i749JHrT026795
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 05:19:17 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i749Ih0G003813
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:18:43 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 4 Aug 2004 09:19:10 -0000
Date: Wed, 4 Aug 2004 10:30:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@redhat.com>
Cc: rcoker@redhat.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [patch] fix /var/run/console bits
Message-ID: <20040804093019.GB3575@lkcl.net>
References: <1091584911.8312.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091584911.8312.7.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 10:01:51PM -0400, Colin Walters wrote:

> requisite permissions to login and xdm.  I still think we need a nicer
> way of mapping the PAM permissions in policy.  The only reason that
> 

 someone on advogato suggested porting bsd_auth to linux.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
