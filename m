Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89GY2rT012856
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:34:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89GX5o3014719
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:33:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: at last: info regarding boot problems on multiple partitions
Date: Fri, 10 Sep 2004 02:33:47 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040908224949.GK7717@lkcl.net>
In-Reply-To: <20040908224949.GK7717@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409100233.47416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Sep 2004 08:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> FINALLY i got a useable system when i encountered a boot problem
> [well, i got a console login].
>
> the issue is that partitions fail to be mounted.
>
> i had noticed over a period of time that programs like pump and dhclient
> and some others would stop partitions from being unmounted during
> shutdown.
>
> [remember i have /boot, /, /usr, /var and /home]
>
> for some reason, this also caused the partitions to fail to MOUNT on
> startup.

I've seen a very similar problem, but it was intermittent and didn't occur 
enough to let me debug it.  I'm not certain that I saw the same problem but 
the result of file systems not being mounted was similar.

I would be very interested in any further information you may find on this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
