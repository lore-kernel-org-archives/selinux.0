Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BNE2rT007962
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:14:03 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5BNDvP2009622
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:13:57 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 11 Jun 2004 23:14:00 -0000
Date: Fri, 11 Jun 2004 23:11:19 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Ed Street <edstreet@street-tek.com>, "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040611231119.GL2861@lkcl.net>
References: <20040610022221.7796D3A4063@abyss.simplyaquatics.com> <200406101510.31547.russell@coker.com.au> <20040610202134.GB2861@lkcl.net> <200406111046.51540.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111046.51540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 10:46:51AM +1000, Russell Coker wrote:
> On Fri, 11 Jun 2004 06:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > issue in version 1.1.7-5 by making the files not be copied to the chroot
> > > if master.cf does not specify any services to be chrooted.
> >
> > ?ah - ah... do you know if he addressed the issue of the context of
> > ?those files being copied over from /etc/ to /var/spool/postfix/etc
> 
> Of course not.  He just made the scripts not copy them if they are not needed.

 ah!  great.

> > ?as well, such that of course initrd_t then needs to have permission
> > ?to rm etc_t and such?
> 
> There is no initrd_t, I presume you mean initrc_t.
 
 *blink*.  yes.  i really must apologise for rushing that set of
 messages a couple of days ago.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
