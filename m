From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Date: Sat, 23 Aug 2003 11:16:19 +1000
Cc: Colin Walters <walters@verbum.org>
References: <20030822201709.GE12548@vnl.com>
In-Reply-To: <20030822201709.GE12548@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308231116.19099.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Aug 2003 06:17, Dale Amon wrote:
> > Why can't you install the new selinux package?
>
> Ah, I see, it's not a kernel package. This is the first time I've
> gone from packages instead of direct from the NSA tgz. But even so,
> there is a conflict. I presume I can just --force-conflicts.

In another message you mention that you are using 2.6.

I will have to make my selinux-policy-default package have an alternate 
dependency on something from Colin.

Colin, which of your packages should it depend on, and what version?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
