Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA12108
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 19:56:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA24005
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 00:53:57 GMT
Received: from mail.unthought.net (unthought.net [212.97.129.24])
	by jazzswing.ncsc.mil  with ESMTP id AAA24001
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 00:53:56 GMT
Date: Mon, 27 Jan 2003 01:56:30 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, Don Marti <dmarti@zgp.org>
Subject: Re: box is back
Message-ID: <20030127005630.GA14156@unthought.net>
References: <200301211359.35581.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200301211359.35581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 21, 2003 at 01:59:35PM +0100, Russell Coker wrote:
> I have a new SE Linux play machine online.
> ssh -p 222 root@adsl.coker.com.au
> Password "1234"
> 

Hello Russel,

And thanks for putting the box up, for us newbies to toy with  ;)

Two (minor, allright) things that caught my attention;
1) One can see dmesg, when in the user_r role. This means, I can see
   what everyone else tried and did - which may (?) in turn reveil
   information about which files exist in places I'm not supposed to
   know about.
2) One can see all PIDs in /proc
   Yes, it's not possible to look further than that - but it still gives
   valuable information (such as, how much logging is this box likely to
   run - by looking at which low-numbered PIDs exist).  It's a fairly
   high bandwidth covert channel as well, but I guess that's not really
   a concern for the moment  ;)

I don't know if any of this is a concern - I think the dmesg one is the
serious one (if I'm not completely mistaken about it).

Anyways, Cheers!, and thanks again,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
