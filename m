Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NHEqRb018106
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 12:14:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1NHD2lK002911
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 17:13:02 GMT
Received: from lakemtao08.cox.net (lakemtao08.cox.net [68.1.17.113])
	by jazzswing.ncsc.mil  with ESMTP id i1NHCeOX002892
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 17:12:48 GMT
Message-ID: <403A34DD.6000108@snu.edu>
Date: Mon, 23 Feb 2004 11:14:05 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: trelane@digitasaru.net
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: identity
References: <200402231535.26738.russell@coker.com.au> <20040223060220.GC9438@digitasaru.net> <200402231722.11587.russell@coker.com.au> <20040223144726.GD9438@digitasaru.net>
In-Reply-To: <20040223144726.GD9438@digitasaru.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joseph Pingenot wrote:

> From Russell Coker on Monday, 23 February, 2004:
> 
>>On Mon, 23 Feb 2004 17:02, Joseph Pingenot <trelane@digitasaru.net> wrote:
>>
>>>Sounds like a good idea.  One question:
>>>Could you also record a signature of the data?  This would help distinguish
>>>       processes who aren't supposed to be letting users on the system
>>>       (since they'd not have a valid signature).  That'd potentially
>>>       be able to plug a standard usage of rooted systems: leave open a
>>>       port to the outside world to log in from.
>>
>>That wouldn't work.
>>If a regular user shell process running as user_u:user_r:user_t can access the 
>>network then it can also launch other shells.  There is no way of stopping 
>>this.
>>How do you distinguish a copy of bash launched as a shell for an interactive 
>>session from an interpreter for a shell script?
>>How do you distinguish programs such as "script" from a wrapper for a UDP 
>>based terminal system?
> 
> 
> Heh.  That's what I get for posting after just a moment's thought, right
>   before I hit the hay.  :)
> Excellent points.  I had originally been thinking that the info would
>   be inherited by children (as would be logical), but it'd not actually
>   prevent any such thing.  Dang.
> Hmm.  Thinking about it again, maybe one could add a 'tainted' flag to
>   a process that gets set when it listens to a socket?  Servers would
>   be accompanied by a signature that verifies the integrity of the binary
>   and are then not tainted on socket opening *if* they match?
> Eh.  It seems like a good thing to eventually work towards.  :)
> 

Mine are inherited by children, i see what you are asking for but this 
seems far outside of the scope of selinux (not that mine are within 
scope per se. I don't like the idea of sticking this into userland 
becuase that requires modifying all login apps wheras mine is generic 
and works with anything that creates a socket. Another problem I see 
with this is, there is nothing that keeps a malicious userland app from 
reproducing that 'signature' so it's not incredibly useful.

I've looked at the selinux code for implementing something like this 
without reaching outside of selinux/lsm and I just don't see any way for 
it to be done since the sid is created in selinux and used to resolve to 
a string context (including identity). It would have been ideal to have 
an identity struct that arbitrary data could be added to but this isn't 
done in selinux.

Furthermore, I just did this patch because it's far easier to track down 
   the culprit of a rogue process if the ip information is available in 
addition to the context and UID.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
