Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8IMqjNs013035
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 18:52:45 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8IMmq1I003159
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 22:48:53 GMT
Date: Sun, 18 Sep 2005 23:48:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Dale Amon <amon@vnl.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918224850.GZ9092@lkcl.net>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net> <20050918095806.GC25649@vnl.com> <20050918104219.GW9092@lkcl.net> <20050918215841.GA7480@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050918215841.GA7480@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 18, 2005 at 10:58:41PM +0100, Dale Amon wrote:

> >  selinux=1 enabled=0
> 
> Actually, its enforcing=0. 

 it's been a while :)

> And unfortuneately that doesn't help.
> I still get the same error messages as before.  


> >  it's something to do with failures in the make process which i never
> >  got to the bottom of - probably some of the libselinux / sepol
> >  libraries detecting that selinux wasn't enabled, and not allowing
> >  the build process to proceed properly.
> 
> There is definitely something I am missing with libsepol because
> there is an error about it which means absolutely nothing to me
> that causes dselect to give up on installing the default policy.

 dselect? ha!  dselect is for wimps.

 okay.

 describe _exactly_ where you got everything from - what the packages
 are, etc. how you did the install (you _should_ ideally be messin with
 the latest linux2.6 nsa source code - kernel, library, etc. but hey if
 you have found dpkg packages that's cool).
 
 send all info to list.

 then hopefully someone will know what's up.

 i've no real pressing need to install debian/selinux right now
 (as i did last year) otherwise i would try / see what happens.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
