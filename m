Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7A6jfrT000842
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 02:45:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7A6jVlU021787
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 06:45:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
Date: Tue, 10 Aug 2004 16:45:28 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, g@lkcl.net,
   SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
References: <20040809175246.GK3868@lkcl.net> <1092078176.29199.179.camel@moss-spartans.epoch.ncsc.mil> <20040809194321.GO3868@lkcl.net>
In-Reply-To: <20040809194321.GO3868@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408101645.28470.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Aug 2004 05:43, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > /dev/null should show up as chr_file, and should be created with
> > null_device_t anyway.  Is this actually an attempt to unlink udev.tbl?
>
> no, it's definitely an attempt to unlink /dev/null (!).
>
> and it's definitely saying device_t:file.

In that case you probably have a non-SE Linux bug.  I guess that some program 
is trying to send output to /dev/null when there is no /dev/null device.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
