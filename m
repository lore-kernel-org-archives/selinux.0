Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BN66rT007890
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:06:06 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5BN60P2009377
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:06:00 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 11 Jun 2004 23:06:00 -0000
Date: Fri, 11 Jun 2004 23:03:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] - installation of mysqld requires chfn
Message-ID: <20040611230314.GJ2861@lkcl.net>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au> <20040610203006.GD2861@lkcl.net> <200406111053.57914.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111053.57914.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 10:53:57AM +1000, Russell Coker wrote:
> On Fri, 11 Jun 2004 06:30, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > yerss, i noticed that if i run with "enforcing=0" and run chfn as
> > sysadm_r, i end up with /etc/shadow labelled as root:object_r:system_t
> 
> How does that happen?  There is no system_t type in the default policy!
 
 ohohoh, yes.

> The usual problem with chfn etc on Debian is of getting /etc/passwd labeled as 
> root:object_r:shadow_t...

 yesyou'reright i was rushing when i wrote that.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
