Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Tom <tom@lemuria.org>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 16:34:20 +0200
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204121019570.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204121019570.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412143420.70F66281EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 16:21, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Tom wrote:
> > One thing that I noticed during this setup was that the patched login
> > and ssh tools do not appear to work if they run on a non-lsm kernel.
> > While this is probably the right thing to do security-wise, it also
> > means that keeping a non-SELinux kernel as "rescue system" on-disk
> > doesn't help a thing.
>
> I can't speak for the Debian selinux packages, but the upstream SELinux
> modified daemons and utilities run fine on non-SELinux kernels and non-LSM
> kernels.  They simply fall back to the ordinary processing in that case.

That is my aim too, and as of my last test they worked.

I'll have to test the latest versions of those packages.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
