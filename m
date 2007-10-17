Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9HLNYY4016295
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2007 17:23:34 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9HLNVla027659
	for <selinux@tycho.nsa.gov>; Wed, 17 Oct 2007 21:23:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: configured virtual environment with SElinux
Date: Thu, 18 Oct 2007 07:23:03 +1000
Cc: Jax <cybercorecentre@gmail.com>, selinux@tycho.nsa.gov
References: <4710018B.20607@gmail.com> <1192455622.2913.3.camel@localhost.localdomain>
In-Reply-To: <1192455622.2913.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710180723.06654.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 15 October 2007 23:40, Karl MacMillan <kmacmillan@mentalrootkit.com> 
wrote:
> Installing Fedora (or one of the other supported distros) will get you a
> fully configured selinux system.

http://www.jailtime.org/ has Xen images, I haven't tested what the CentOS5 
image is like (I hope it has SE Linux in the default configuration) and there 
is no Debian 4.0.  It's not difficult to re-enable SE Linux if they happen to 
have disabled it.

Of course this relies on you using Xen, but most people seem to be using Xen 
for such things at the moment.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
