Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p05Mko0M009851
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 17:46:50 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p05Mklu2026739
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 22:46:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joe Nall <joe@nall.com>
Subject: Re: libsemanage patch for MCS/MLS in user files
Date: Thu, 6 Jan 2011 09:46:41 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201101051930.26082.russell@coker.com.au> <0BDFF5FB-FDA3-4AAC-A851-D534AF4402E0@nall.com>
In-Reply-To: <0BDFF5FB-FDA3-4AAC-A851-D534AF4402E0@nall.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201101060946.41588.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 6 Jan 2011, Joe Nall <joe@nall.com> wrote:
> We don't have any users that are single level > SystemLow. I do think that
> is a legitimate use case. We currently symlink most dot files into a
> polyinstatiated directory to allow terminal windows and preferences to
> work at multiple levels.
> 
> You could polyinstantiate the home directory and not worry about the
> specific level.

I want to support a fairly simplistic use case where PI isn't required, all 
that's required is that a few users who access sensitive data can't share it 
easily.

Thanks for your comment, I'll upload this package to Debian.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
