Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TBSWrT014328
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 07:28:32 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TBRRnY000104
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 11:27:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Patch for strict policy
Date: Wed, 29 Sep 2004 21:28:18 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux <selinux@tycho.nsa.gov>
References: <41542FF5.2090502@redhat.com> <41584D2F.5020902@redhat.com> <20040927205512.GA2574@jmh.mhn.de>
In-Reply-To: <20040927205512.GA2574@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409292128.18559.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Sep 2004 06:55, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> * Daniel J Walsh <dwalsh@redhat.com> [2004-09-27 21:12]:
> > diff --exclude-from=exclude -N -u -r
> > nsapolicy/domains/misc/screensaver.te
> > policy-1.17.22/domains/misc/screensaver.te ---
> > nsapolicy/domains/misc/screensaver.te 1969-12-31 19:00:00.000000000 -0500
> > +++ policy-1.17.22/domains/misc/screensaver.te 2004-09-27
> > 10:19:13.000000000 -0400 @@ -0,0 +1,18 @@
> > +#
> > +# Alias file to stop blow up during policy upgrade, since
> > +# screensaver policy is being removed.
>
> How will screensavers be able to authenticate users (think screen lock)
> if this policy is removed? screensavers had the auth_chkpwd attribute to
> do this; I do not think that we should grant this capability to user_t.

In macros/base_user_macros.te:
ifdef(`chkpwd.te', `chkpwd_domain($1)')

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
