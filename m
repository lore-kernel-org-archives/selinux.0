Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8R27CsJ004483
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2003 22:07:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8R25RZt003922
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 02:05:27 GMT
Received: from out002.verizon.net (out002pub.verizon.net [206.46.170.141])
	by jazzswing.ncsc.mil  with ESMTP id h8R25QM3003916
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 02:05:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Eamon Walsh <ewalsh@epoch.ncsc.mil>
Subject: Re: Emacs major mode for policy editing
Date: Fri, 26 Sep 2003 22:09:36 -0400
References: <1064504193.3885.14.camel@moss-tarheels.epoch.ncsc.mil> <200309261743.58567.wlsel@verizon.net> <1064614177.5342.7.camel@moss-tarheels.epoch.ncsc.mil>
In-Reply-To: <1064614177.5342.7.camel@moss-tarheels.epoch.ncsc.mil>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200309262209.36797.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 September 2003 06:09 pm, you wrote:
> On Fri, 2003-09-26 at 17:43, Bill Laut wrote:
> > On Thursday 25 September 2003 11:36 am, Eamon Walsh wrote:
> > > My name is Eamon Walsh; I recently joined the NSA selinux team.
> > > I will be working on putting policy enforcement into XFree86.
> >
> > When do you anticipate having security-enhanced X completed?
> >
> > Bill
>
> I just came on board and have been studying the problem; no definite
> implementation strategy exists yet.
>

I've been looking at it off and on for a few months.  I used to heavily hack X 
about 10 to 13 years ago, so this is largely "old stomping grounds" for me.  
Bringing myself up to speed on the internals of SELinux is the bigger 
challenge to me.  

>
> We talked with an experienced X person who claims he can solve the
> problem (which consists of two parts: policy enforcement in the X server
> and "labeling" of windows by the window manager) in six months.  This
> person might get hired as well as myself.  I will be working on this for
> 8 months or so.
>

An estimate of six months strikes me as "contingency planning" and which is 
certainly acceptable.  My personal implementation schedule, however, will be 
considerably more aggressive.

Of course, I'm not under contract to NSA and therefore you cannot depend on me 
hitting my time estimate.  If I'm successful, great!  My stuff will get 
released under the GPL for all to benefit.  If not, well, you have eight 
months to get it working.

>
> I have been looking at the X Security extension and trying to figure out
> if this code could be used as a starting point.  It seems pretty good so
> far, but I'm concerned about how other extensions interact with it
> (notably Xag and XTrap).
>

I think you're going too far up the tree.  You want to be closer to the root.  

X has a well-defined protocol interfacing the client's Xlib and the XServer 
via a "Transport Layer" that implements the Event and Request Queues.  In 
fact, with some implementations (such as DECWindows under VMS) there is a 
bona fide formal Transport Layer in which you can implement your own 
Transports to handle whatever abstraction you want to speak X over.

Everything going into and out of the XServer (with the obvious exception of 
the monitor, keyboard, and mouse, etc.) goes through those Queues via that 
Transport layer.  Therefore, it makes more sense to install the "gatehouse" 
at the XServer's main dispatcher because (1) we can enforce policy on ALL 
Requests and Events to/from ALL Xclients, local and remote; and (2) in so 
doing minimize the changes needed to XFree86.

As an "extra homework assignment," this could also be a good excuse to go 
through the code to hunt down potential buffer overruns and nail them in the 
Gatehouse, but that could be for another topic.

Of course, there will undoubtedly be some things that won't fit this paradigm 
and will have to be handled within their own modules.  However, the majority 
of tasks will fit within the "gatehouse" and so it makes sense to "kill as 
many birds with one stone" as is possible.

>
> I think the hardest part will be cut & paste, which seems to be a big hack
> in X overall.
>

I'm suspecting it will depend on how "messy" you want to get with it.  
Personally, for now, I don't think it will be a major issue.

The scenario I consider a paradox is how to enforce policy on remote clients.  
To wit, where all the clients are local on the same box with the XServer, it 
is trivial to independently authenticate each client via the kernel.  Kind of 
like Kerberos' use of the "trusted third-party" model, but where our 
third-party is the kernel itself.  Piece of cake:  The XServer doesn't use 
anything the client could possibly say about itself to decide whether or not 
to allow a given Request to be accepted, because the authenticating data was 
never within the client's reach to possibly taint.

On the other hand, what do we do with remote clients connecting via the 
network?  Anything more than a summary policy decision will require 
authentication data not stored on the XServer's box.  How do we protect 
ourselves from being spoofed?

Furthermore, this requirement, in turn, could conceivably lead into 
discussions of crypto (to protect the TCP stream) that NSA employees may or 
may not be allowed to discuss within a mailing list.  This may be a point 
that an appropriate echelon should investigate and mention for our benefit at 
this project's outset, so that we don't violate any rules.

>
> Did you post to the list earlier this month and say you were also
> working on this problem?  Someone did and I lost the e-mail.
> Once the project gets rolling there will be more list traffic, for sure.
>
> --Eamon

Yes, I had posted to the list that I was working on Security-Enhanced X (or 
"s-ex," as Russell puckishly termed it) some time ago.

I have one other committment that I'm finishing this week, and then I can 
devote more time to s-ex.  In my last posting to the list I committed myself 
to delivering a first draft of an implementation strategy by mid-October, and 
I'm still shooting for that target.

The purpose of the document is to give everyone on the mailing list a chance 
to review it and identify errors, omissions.  Shoot arrows at it.  That sort 
of thing.  All contributions, ideas, suggestions are welcomed.  Then, once 
everything is identified I want to get started implementing the controls 
within X.


Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
