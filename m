Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2111lRT017169
	for <selinux@tycho.nsa.gov>; Sun, 28 Feb 2010 20:01:47 -0500
Received: from g4t0015.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o211283j012941
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 01:02:08 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Roys <joshua.roys@gtri.gatech.edu>
Subject: Re: [PATCH] netlabel: fix export of SELinux categories > 127
Date: Sun, 28 Feb 2010 20:01:44 -0500
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <1267030357-26366-1-git-send-email-joshua.roys@gtri.gatech.edu> <201002241852.44136.paul.moore@hp.com> <4B880E03.1040903@gtri.gatech.edu>
In-Reply-To: <4B880E03.1040903@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002282001.45034.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 February 2010 01:08:03 pm Joshua Roys wrote:
> On 02/24/2010 06:52 PM, Paul Moore wrote:
> > On Wednesday 24 February 2010 11:52:37 am Joshua Roys wrote:
> >> This fixes corrupted CIPSO packets when SELinux categories greater
> >> than 127 are used.  The bug occured on the second (and later) loops
> >> through the while; the inner for loop through the ebitmap->maps array
> >> used the same index as the NetLabel catmap->bitmap array, even though
> >> the NetLabel bitmap is twice as long as the SELinux bitmap.
> >> 
> >> Signed-off-by: Joshua Roys<joshua.roys@gtri.gatech.edu>
> > 
> > Ha!  I came to the same conclusion and sent you a similar patch a few
> > hours ago (should have checked my SELinux email folder first it seems).
> > 
> > Acked-by: Paul Moore<paul.moore@hp.com>
> > 
> > This should also be sent to stable - James or Josh do one of you guys
> > want to do that?
> 
> Cool!  I'm glad we came to the same solution, although next time I'll CC
> you directly to avoid doing duplicate work.

Okay, no problem either way - the important part is that the problem is now 
fixed.

> Thanks for your help,

Thanks to you as well, it's always nice to see others get involved.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
