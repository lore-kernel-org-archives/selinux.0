Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RKLrsJ006754
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 16:21:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8RKLqCG020645
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:21:52 GMT
Received: from out003.verizon.net (out003pub.verizon.net [206.46.170.103])
        by jazzband.ncsc.mil  with ESMTP id h8RKLpqJ020642 for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 20:21:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au
Subject: Re: Emacs major mode for policy editing
Date: Sat, 27 Sep 2003 16:24:17 -0400
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <1064504193.3885.14.camel@moss-tarheels.epoch.ncsc.mil> <200309262209.36797.wlsel@verizon.net> <200309272024.54251.russell@coker.com.au>
In-Reply-To: <200309272024.54251.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200309271624.17976.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 27 September 2003 06:24 am, Russell Coker wrote:
> On Sat, 27 Sep 2003 12:09, Bill Laut wrote:
> > Yes, I had posted to the list that I was working on Security-Enhanced X
> > (or "s-ex," as Russell puckishly termed it) some time ago.
>
> Surely I can't have been the first person to notice the SE-X acronym!
>

Yours is the first use of it that I'm aware of.  I probably noticed it at some 
unconcious level, but didn't pay it much attention until you used it.  One of 
the signs of approaching middle age on my part, no doubt!  :-(

>
> At this point I should mention that Security Enhanced X is an important
> development for Linux, it's something that we've been waiting far too long
> for, and when it's available I'm sure we won't be able to get enough of it.
>

I couldn't agree with you more.  That's why, for my contribution, I want 
everyone who is interested to review it and tell me where I'm in error, or 
where something could be better designed, so that what I eventually release 
to the group is a polished gem.

I have no ego problems with peer review/criticism whatsoever.

>
> We just have to make sure that it's correctly implemented to avoid viruses
> and unwanted child processes.
>

That's also why I threw in the reference to "extra homework" in my previous 
post.  For example, this could be a good excuse to go through XFree86 and 
insure that there aren't any unrecognized buffer-overflow vulnerabilities.  
It would be embarassing to say the least to release SE-X, only to have it 
contain exploitable BO vulnerabilities--the very thing that SELinux is 
advertised as protecting against.

The tact I intend to take is to break the implementation down into small, 
manageable pieces that can progressively be built upon, until the project is 
finally completed.  This should help making the "lessons learned" from each 
piece easier to integrate as well as speed up the overall implementation.

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
