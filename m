Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2NN48mu005284
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 19:04:08 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2NN3vBr013747
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 23:04:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "cinthya aranguren" <cinthya.aranguren@gmail.com>
Subject: Re: Removing DAC.
Date: Mon, 24 Mar 2008 09:34:14 +1100
Cc: selinux@tycho.nsa.gov
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
In-Reply-To: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803240934.16380.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 March 2008 02:54, "cinthya aranguren" 
<cinthya.aranguren@gmail.com> wrote:
> Is there any way to avoid o remove DAC controls ? I'd like to have only one
> security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
> only MAC.

Back in about 2003 as an experiment I changed the ownership of all files on a 
SE Linux strict system to root and changed the permission to 777.  It didn't 
work very well.  One problem was that many programs rely on the Unix 
permissions to identify the difference between a configuration file and a 
shell script.  In directories such as /etc there is not sufficiently 
fine-grained SE Linux labelling to replace this use of Unix permissions.

It's possible that in the last 5 years things have changed significantly, but 
my last experiments showed enough obstacles to make me not want to bother 
going further with it.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
