Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8U00VsJ015432
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 20:00:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8U00UCG027956
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 00:00:30 GMT
Received: from moss-tarheels.epoch.ncsc.mil (moss-tarheels.epoch.ncsc.mil [144.51.25.3])
        by jazzband.ncsc.mil  with ESMTP id h8U00UqJ027953 for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 00:00:30 GMT
Subject: X Windows discussion
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 20:00:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[This continues the X discussion that was under the "Emacs major mode" thread]


On Fri, 2003-09-26 at 22:09, Bill Laut wrote:
> An estimate of six months strikes me as "contingency planning" and which is 
> certainly acceptable.  My personal implementation schedule, however, will be 
> considerably more aggressive.

Some of the points I make below are taken from the document "Securing the X 
Window System with SELinux" ( http://www.nsa.gov/selinux/x11-abs.html ).  I'm
largely working from this document in terms of looking at the problem.


> I think you're going too far up the tree.  You want to be closer to the root.  
> 
> X has a well-defined protocol interfacing the client's Xlib and the XServer 
> via a "Transport Layer" that implements the Event and Request Queues.  In 
> fact, with some implementations (such as DECWindows under VMS) there is a 
> bona fide formal Transport Layer in which you can implement your own 
> Transports to handle whatever abstraction you want to speak X over.
> 
> Everything going into and out of the XServer (with the obvious exception of 
> the monitor, keyboard, and mouse, etc.) goes through those Queues via that 
> Transport layer.  Therefore, it makes more sense to install the "gatehouse" 
> at the XServer's main dispatcher because (1) we can enforce policy on ALL 
> Requests and Events to/from ALL Xclients, local and remote; and (2) in so 
> doing minimize the changes needed to XFree86.


Why do you think the XSecurity extension isn't close enough "to the root?"  
It installs its own dispatch table and is thus positioned to see every request 
that comes in, including SendEvent requests.

I think that building on XSecurity is the way to go.  My impression so far
is that it has hooks in good places and that using it will reduce the
changes we have to make to the core server.  It will also look better if one
can say to the XFree86 maintainers "Here's a new security extension" than 
"Here's a bunch of new code for the dix and os layers."

There are some XSecurity fields in the Client structure that may be very
useful if we can store the security context in them and then get from an
arbitrary resource (GC, colormap, drawable, whatever) back to the client that
created it.  We could then do labeling with a minimum of new fields in the
internal X structures.

Some links to XSecurity documentation:
http://ftp.x.org/pub/R6.4/xc/doc/hardcopy/Xserver/secint.PS.gz
http://davinci01.man.ac.uk/aix433/x11/specs/pdf/security.htm


> 
> As an "extra homework assignment," this could also be a good excuse to go 
> through the code to hunt down potential buffer overruns and nail them in the 
> Gatehouse, but that could be for another topic.


As a policy enforcer, the X server will have to be vetted for security holes.
I don't think we have to worry about that for now, however.  See Section 3.0
of the SElinux/X paper.

> 
> Of course, there will undoubtedly be some things that won't fit this paradigm 
> and will have to be handled within their own modules.  However, the majority 
> of tasks will fit within the "gatehouse" and so it makes sense to "kill as 
> many birds with one stone" as is possible.

> I'm suspecting it will depend on how "messy" you want to get with it.  
> Personally, for now, I don't think it will be a major issue.


I'm afraid of Cut & Paste because I don't know much about it, yet.  There's
the old method of setting properties on windows to pass clipboard data and
do drag & drop, then there's Clip Extension, and I have a vague notion that 
the desktops are doing their own thing.  It's very much a moving target.

> 
> The scenario I consider a paradox is how to enforce policy on remote clients.  
> To wit, where all the clients are local on the same box with the XServer, it 
> is trivial to independently authenticate each client via the kernel.  Kind of 
> like Kerberos' use of the "trusted third-party" model, but where our 
> third-party is the kernel itself.  Piece of cake:  The XServer doesn't use 
> anything the client could possibly say about itself to decide whether or not 
> to allow a given Request to be accepted, because the authenticating data was 
> never within the client's reach to possibly taint.
> 
> On the other hand, what do we do with remote clients connecting via the 
> network?  Anything more than a summary policy decision will require 
> authentication data not stored on the XServer's box.  How do we protect 
> ourselves from being spoofed?
> 

The existing SELinux policy in the kernel controls who can connect to the X
server.  All we have to worry about is what goes on over the connection once 
it's established.  

You're right about the authentication problem though.  We need a way of 
associating the security context of a client application with its objects in 
the X server.  Unfortunately, there doesn't seem to be an easy, secure way of 
doing this.  The client can't be trusted to send it over.  If there were a way 
of getting the remote security context from a (unix domain) socket, we could 
use that, but the kernel has to be involved somehow, and with functionality
that it doesn't currently have.  Unless I'm missing something.

The cop-out solution, and probably the only solution for remote clients, is
to treat all clients the same way.  This may be too inflexible: screen-shot 
applications, for example, would no longer be possible.

-- 
Eamon Walsh <ewalsh@epoch.ncsc.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
