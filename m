Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QH2VrT027963
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:02:31 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QH1T76017084
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 17:01:29 GMT
Date: Sun, 26 Sep 2004 18:13:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev_uses_tmpfs
Message-ID: <20040926171336.GC28076@lkcl.net>
References: <20040926120608.GG26338@lkcl.net> <200409262324.29324.russell@coker.com.au> <20040926142002.GA28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040926142002.GA28076@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 26, 2004 at 03:20:02PM +0100, Luke Kenneth Casson Leighton wrote:
> On Sun, Sep 26, 2004 at 11:24:29PM +1000, Russell Coker wrote:
> > On Sun, 26 Sep 2004 22:06, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > if there are _really_ some redhat-specific things such as "only redhat
> > > does udev+tmpfs from its initial ramdisk" then fine.
> > 
> > That's what it is.
> > 
> > If tmpfs is mounted after the machine boots (as done in Debian) then it can be 
> > correctly labelled before use.
>  
>  ... sorry for being thick, but how do i achieve that?

 okay, i get it: as soon as you do a mount of tmpfs on /dev, do
 a restorecon /dev.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
