Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8EdZIi015941
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 09:39:35 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8Ec9C6008645
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 14:38:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: dynamic context transitions
Date: Tue, 9 Nov 2004 01:39:23 +1100
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
References: <418662EE.5090001@trustedcs.com> <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com> <20041101203524.GJ9643@lkcl.net>
In-Reply-To: <20041101203524.GJ9643@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411090139.24391.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 November 2004 07:35, Luke Kenneth Casson Leighton 
<lkcl@lkcl.net> wrote:
> > Is there any reason why smbd can't exec a simple helper application in
> > the required context which only does what needs to be done?
>
>  no there is no reason why [a helper application should] not [be used].
>
>  i am not sure if the simple solution [that andrew and russell
>  came up with] was fully enumerated: it involves exec'ing a
>  per-user helper application which does a setuid.
>
>  the helper application opens files as-and-when they are needed,
>  [and also does mkdirs? and rmdirs?] and then passes the file

Yes, it would also do mkdir, rmdir, link, unlink, rename, and symlink.  For 
best functionality it would do stat, but that would have performance issues 
or require file handle caching code which would be more work to write and 
maintain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
