Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02786
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 17:07:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA25444
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 22:05:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA25440
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 22:05:19 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8B74C924EE
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 09:07:26 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CD2322515
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 23:07:20 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Date: Thu, 19 Dec 2002 23:07:20 +0100
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org>
In-Reply-To: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org>
MIME-Version: 1.0
Message-Id: <200212192307.20386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This type of thing could affect Linux in the same way as it affects Windows.

Currently we have "risky" programs such as netscape, games, and IRC clients in 
their own domains that have types for read-only and for read-write files (and 
no ability to run gpg or other important programs).

The problem about doing the same for audio/video programs such as players for 
avi, mp3, and vob files is that their typical use involves downloading files 
from the net to play immediately so that denying them read access to 
user_home_t files will give a large decrease in functionality.  I believe 
that there are two major categories of SE Linux users, those who will never 
run such A/V programs on Linux, and those who won't use any security software 
that gets in the way of their entertainment.

So I think that having a domain for A/V programs such as $1_av_t that has read 
access to $1_home_t and can create files with the type $1_home_av_t may not 
be as tightly secured as we might like, but the people who are concerned 
about that won't use it anyway.

On Thu, 19 Dec 2002 09:58, InfoSec News wrote:
> http://news.com.com/2100-1001-978403.html?tag=fd_top
>
> By Robert Lemos
> Staff Writer, CNET News.com
> December 18, 2002, 5:12 PM PT
>
> A security firm on Wednesday warned that people using Windows XP or
> popular music player WinAmp could fall prey to a vulnerability,
> enabling a modified music file to take control of a person's PC.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
