Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAIBMIi022137
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 13:11:22 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAI9gwg012864
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 18:09:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: can_network patch.
Date: Sat, 11 Dec 2004 05:11:07 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
References: <41741A2C.8040408@redhat.com> <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil> <41B9E48A.8010204@redhat.com>
In-Reply-To: <41B9E48A.8010204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412110511.12960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 11 December 2004 05:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Stephen Smalley wrote:
> >On Fri, 2004-12-10 at 12:06, Daniel J Walsh wrote:
> >>When installing a package within firefox, it attemps to exec
> >>system-config-packages which blows up because
> >>*-mozilla-t can not run userhelper apps.
> >
> >Installing a package within firefox?  If you are talking about something
> >firefox downloaded, then why does it use system-config-packages?  And I
> >would expect that you would end up installing any such packages local to
> >the user's home directory at most (and even then only if policy allows
> >writing to it), not on a system-wide basis.
>
> You can trigger it by executing
>  firefox selinux-policy-strict-1.19.12-1.src.rpm

We have mozilla running in it's own domain to limit the risk of exploits of 
mozilla taking over the rest of the system.  Allowing mozilla to install 
packages seems to directly contradict this aim.

Maybe we should just remove the mozilla policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
