From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Shaz <shazalive@gmail.com>
Subject: Re: questions
Date: Mon, 16 Mar 2009 21:37:23 +1100
Cc: SELinux@tycho.nsa.gov
References: <19716145.1610101236870456814.JavaMail.coremail@bj126app71.126.com> <200903150424.13140.russell@coker.com.au> <7b740b700903152334g70c7f421y88e9e0a7852cfb23@mail.gmail.com>
In-Reply-To: <7b740b700903152334g70c7f421y88e9e0a7852cfb23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903162137.29582.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Mar 2009, Shaz <shazalive@gmail.com> wrote:
> I have been trying some of the SELinux packages from the repos but can't
> even enable it on boot! I wanted to have multiple platform experience
> although I am pretty easy with FC8. Next I will try Gentoo.

Which distributions did you try?

Debian/Lenny should work well if you follow my instructions:
http://doc.coker.com.au/computers/installing-se-linux-on-lenny/

> I am also working on getting SELinux enabled in some of our mobile devices
> so if there is any useful public domain work then please indicate it.

In the past I did some work on getting it running on Familiar on the iPaQ 
platform (ARM).  But when SE Linux migrated to XATTRs that was broken because 
JFFS2 didn't have XATTR support.  Recently XATTR support has been written, so 
it should be possible to get it going.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
