Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71GdlrT007725
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 12:39:47 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71GdE52024432
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 16:39:14 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 16:39:46 -0000
Date: Sun, 1 Aug 2004 17:50:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Message-ID: <20040801165051.GB20103@lkcl.net>
References: <20040801103252.GC7384@lkcl.net> <200408012254.15553.russell@coker.com.au> <20040801135421.GE15205@lkcl.net> <200408020028.28909.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408020028.28909.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 12:28:28AM +1000, Russell Coker wrote:
> On Sun, 1 Aug 2004 23:54, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > Your /etc/selinux/config file should have the following line:
> > > SELINUXTYPE=.
> >
> >  ah... there isn't an /etc/selinux/config file...
> >
> >  perhaps that is the cause of the problem?
> 
> selinux-policy-default version 1.14-1 has the file, you can verify this with 
> "dpkg -c".
> 
> # dpkg -c /var/cache/apt/archives/selinux-policy-default_1%3a1.14-1_all.deb |
> grep /etc/selinux/config
> -rw-r--r-- root/root       120 2004-07-13 19:33:09 ./etc/selinux/config
 
 ..+*?  how very very odd.

 i wonder what happened.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
