Date: Sun, 16 Feb 2003 23:43:39 -0800 (PST)
From: Thomas Walcott <walcott@cs.ucdavis.edu>
To: Joshua Brindle <JBrindle@snu.edu>
cc: SELinux@tycho.nsa.gov
Subject: Re: user transparent encryption
In-Reply-To: <se502174.064@atlas.snu.edu>
Message-ID: <Pine.LNX.4.44.0302162337530.18801-100000@pc33.cs.ucdavis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pardon the top posting.

Executive summary:

This is a topic I've given some thought to.  I think the problem is 
fundamentally intractible.  

Rationale:

Let us imagine that you produce such a system running on off-the-shelf 
hardware.  Your solution for absolute security is written in software.  
This software has to be interpreted; it can be taken apart by hand and 
turned into a key that would effectively open up the system.  I can't 
think of any way that is provably effective.

While you may be able to slow down an attacker, I don't think there's any 
perfect solution.  This has been a problem with a lot of security models.  
For example, if you look at the canonical systems, they all make a lot of 
(reasonable) assumptions that simply have to hold true for the system to 
be effective.  Consider the Bell-LaPadula model.  If person A doesn't 
bother trying to copy the file, but instead either prints it out and 
passes it around to unauthorized users, your game is over.  We have to 
consider a restricted environment and make some reasonable assumptions.

Now, to leap merrily back to my earlier comment about software.  This same 
process can be considered for hardware.  The ability to test pin-outs, 
etc., means that any 'solution' becomes extremely expensive.  You can't 
give your adversary infinite time to play with the system.  If you want to 
limit their time, you have to make the system such that it can cease 
operation -- i.e., it has to self-destruct.  This is a tough problem.

If you think of anything, please let me know; I'd be interested in 
hearing about it.  I'm also happy to bat around ideas, but it's probably 
best kept to private correspondence, since this commentary is apt to drift 
quite considerably off SE-Linux topic.

HTH,

Tom



On Sun, 16 Feb 2003, Joshua Brindle wrote:

> I've pondered this myself, suppose you have a great selinux setup very
> secure, no easy way to compromise it, but the machine itself was in a
> hostile environment (not able to be protected from others well). What is
> to stop someone from booting up a non-selinux kernel and having at it
> with your filesystems? Nothing. I've often wondered if there is a way to
> lock down the drive contents so it is not accessible (at least easily)
> by a non-selinux kernel, or even the encrypted fs where the key is
> compiled securely into a selinux-enabled kernel so that with a new
> (possible non-selinux) kernel the filesystem would not be readable. Do
> you guys think this is possible? granted it would make system recovery
> next to impossible but maybe it would be a good option for folks with
> malicious or ignorant users/-co admins?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
