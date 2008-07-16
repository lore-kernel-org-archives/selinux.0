Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GBv0Rp015116
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 07:57:00 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GBuwWL023312
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:56:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Date: Wed, 16 Jul 2008 21:56:49 +1000
Cc: selinux@tycho.nsa.gov
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com> <200807161714.35195.russell@coker.com.au> <dd18b0c30807160047r23d6f795ua8d16ee2534000ab@mail.gmail.com>
In-Reply-To: <dd18b0c30807160047r23d6f795ua8d16ee2534000ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807162156.53554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 16 July 2008 17:47, "Justin Mattock" <justinmattock@gmail.com> 
wrote:
> I always for some reason put that in fstab just as a good practice,
> from what I remember like what you had said "you probably need to fix
> something else".

Some years ago that probably was a good idea (I probably recommended it in the 
past).

However now we have /proc, /dev, /dev/pts, /dev/.static/dev (on Debian and 
derivatives), /dev/shm, and /sys as well.

While there is generally no real performance requirement for making /etc/fstab 
small and anything less than 4K won't make a difference to the amount of free 
space on most systems, I think it's best to avoid clutter (it helps when 
reading such a file while doing late-night support).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
