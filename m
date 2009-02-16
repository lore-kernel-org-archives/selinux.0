Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1GMZTOY030992
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 17:35:29 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1GMZQ8w000667
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 22:35:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: sysvinit doesnt see libselinux/libsepol (LFS system);
Date: Tue, 17 Feb 2009 09:35:14 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com> <dd18b0c30902152208r46e439e5r6bcabfc299bc2ac8@mail.gmail.com> <dd18b0c30902160618p5501ecdaie3ffefd96b66188a@mail.gmail.com>
In-Reply-To: <dd18b0c30902160618p5501ecdaie3ffefd96b66188a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902170935.19429.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Feb 2009, Justin Mattock <justinmattock@gmail.com> wrote:
> The issue I have is using dpkg/or apt-get already has the right
> patch applied and init already compiled in, in accordance to the distro.

If you take the original source plus the Debian patch and use it in place of 
the original source for your LFS build then it should be fine.

> doing a (LFS) tutorial, under the documentation
> has me building everything from the source.
> (a lot of work, but worth the learning experience);

It's also a learning experience to contribute to the integration of SE Linux 
in a major distribution such as Debian, Gentoo, or Fedora.  I think that in 
the long run there would be more benefits to both you personally and the 
community if you were to contribute to one of these projects.  I suggest that 
you choose Debian, but I admit to being biased in this regard.  ;)

> In any case, I suppose I can just copy /sbin/init from an existing
> debian system but, then I might have issues with the
> arch being different.

No, that should work.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
