Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PCpp3C000962
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 08:51:55 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9PCpqQx001663
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 12:51:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Shaz <shazalive@gmail.com>
Subject: Re: [refpolicy] load_policy() with upstart on mint 9 fluxbox
Date: Mon, 25 Oct 2010 23:16:03 +1100
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
References: <4CBE21ED.4050706@gmail.com> <201010251039.58440.russell@coker.com.au> <AANLkTikfs13Ck937X1VVsy3CB=4KMOYEKVDSFr+7GUy=@mail.gmail.com>
In-Reply-To: <AANLkTikfs13Ck937X1VVsy3CB=4KMOYEKVDSFr+7GUy=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201010252316.03872.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Oct 2010, Shaz <shazalive@gmail.com> wrote:
> I would like to have a look at the Debian init solution for SELinux. Can
> you attach or link to a sample inittab and substitute for what is done at
> initrd?

In Debian sysvinit loads the policy, as everyone has done with sysvinit for 5+ 
years.  Upstart didn't, but I believe that there has been progress towards 
getting it to do so too.  There are quite a few Debian users who don't use an 
initrd and we want to support them.

There was never a need to change inittab.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
