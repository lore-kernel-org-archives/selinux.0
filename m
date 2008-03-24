Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OLolIF022436
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:50:47 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2OLodoL015165
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 21:50:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: Removing DAC.
Date: Mon, 24 Mar 2008 23:48:51 +1100
Cc: selinux@tycho.nsa.gov
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com> <200803240934.16380.russell@coker.com.au> <47E79AC2.8040606@manicmethod.com>
In-Reply-To: <47E79AC2.8040606@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803242348.53429.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 March 2008 23:12, Joshua Brindle <method@manicmethod.com> wrote:
> we certainly have alot more types today, I'm not sure if that was the
> real obstacle though.

The real obstacle is bad design.

I don't think that there has ever been a time when it made sense to use the 
same file name for either a program or a plain text config file.

It might make some sense to try to execute /etc/daemon-config.sh and then 
read /etc/daemon-config if that fails (or the other way around).  Having a 
one-line config file which says "execute program X" would also make sense.

Using the same file name for both such that a horrible disaster is only a 
single chmod command away is just a bad idea.  I recall reading in a version 
of the Unix Horror stories about how someone accidentally made some C source 
code executable, and somehow when the C source in question was executed as a 
shell script it gave the same result as "rm -rf /".

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
