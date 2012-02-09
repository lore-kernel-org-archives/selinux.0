Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q19DD5pZ013754
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2012 08:13:05 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q19DD3Zw020324
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2012 13:13:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Subject: Re: SELinux on Wheezy
Date: Fri, 10 Feb 2012 00:12:59 +1100
Cc: Dominick Grift <dominick.grift@gmail.com>,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <1328502407.14110.7074.camel@calcifer> <1328543813.1905.2.camel@x220.mydomain.internal> <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
In-Reply-To: <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201202100012.59322.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Feb 2012, "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org> wrote:
> > Does it work if you set it to off?
> >
> > 
> >
> > setsebool -P xserver_object_manager off
> >
> > 
> >
> > http://selinuxproject.org/page/NB_XWIN
> 
> Thank you Dominick.  I will give this a try when I re-boot.
> 
> Russell, do you think this is something we should patch in to the xorg
> debian packaging?

Yes, I want to get XACE supported.  It's just a matter of time...

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
