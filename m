Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7T7SfFK018758
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 03:28:42 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Raul da Silva {Sp4wn}" <sp4wn.root@gmail.com>
Subject: Re: proof selinux
Date: Wed, 29 Aug 2012 17:28:09 +1000
Cc: selinux@tycho.nsa.gov
References: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
In-Reply-To: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208291728.10022.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Aug 2012, "Raul da Silva {Sp4wn}" <sp4wn.root@gmail.com> wrote:
> I know that we have a lot of ways to prove how effective is SELinux as cgi,
> perl, shell scripts and I know that is effective but I'd like to know if
> someone already tested some kind of exploit of buffer overflow attack as
> demo to show how effective could be SELinux.
> Any information I really appreciate

A simple test of this would be to run a program like telnetd as httpd_t (or 
some other domain that takes remote connections) and configure it to launch a 
shell with no password.

http://www.coker.com.au/selinux/play.html

Also I have a Play Machine online right now to demonstrate how the root 
account can be locked down.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
