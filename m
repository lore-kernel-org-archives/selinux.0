Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6N2DXN1016638
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 22:13:33 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6N2DWT2022052
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 02:13:32 GMT
Received: by py-out-1112.google.com with SMTP id a78so6154044pyh.32
        for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 19:13:32 -0700 (PDT)
Subject: Re: what is the point of semodule -u?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200807231017.30237.russell@coker.com.au>
References: <200807231017.30237.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 22 Jul 2008 22:11:41 -0400
Message-Id: <1216779113.3580.6.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-23 at 10:17 +1000, Russell Coker wrote:
> semodule supports options "-i" for install and "-u" for upgrade.  It seems 
> that "semodule -i" will upgrade a module, so what is the point 
> of "semodule -u"?  Are we assuming that a user or script that calls semodule 
> doesn't know what it is doing and relies on the "-u" option refusing to 
> install the same (or an older) version for correct results?
> 
> If so then I doubt that it will work well as I don't think that versions can 
> be tracked accurately with the way the code is developed (EG a new release 
> from a distribution vendor might have a higher version number than your local 
> customisation even though your local changes are more relevant for your 
> environment).

I'm not entirely sure about the original rationale for it, but upgrade
appears to differ from install in two ways:
1) It will fail if a module of the same name isn't already installed
(vs. adding it), and
2) It will fail if a module with the same name and the same or higher
version number is installed already (vs. replacing it).

So for example if you ran semodule -u *.pp on some directory full of .pp
files, it would only actually install modules that already had prior
versions of the same module installed and that were newer in version
number.

Not sure if that is practically useful or not.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
