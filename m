Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NElXRb017109
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 09:47:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1NElVQQ008284
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:47:31 GMT
Received: from petrus.dynamic.digitasaru.net (hb6.lcom.net [216.51.236.182])
        by jazzband.ncsc.mil  with ESMTP id i1NElUP0008276 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:47:30 GMT
Date: Mon, 23 Feb 2004 08:47:29 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: identity
Message-ID: <20040223144726.GD9438@digitasaru.net>
Reply-To: trelane@digitasaru.net
References: <200402231535.26738.russell@coker.com.au> <20040223060220.GC9438@digitasaru.net> <200402231722.11587.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200402231722.11587.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From Russell Coker on Monday, 23 February, 2004:
>On Mon, 23 Feb 2004 17:02, Joseph Pingenot <trelane@digitasaru.net> wrote:
>> Sounds like a good idea.  One question:
>> Could you also record a signature of the data?  This would help distinguish
>>        processes who aren't supposed to be letting users on the system
>>        (since they'd not have a valid signature).  That'd potentially
>>        be able to plug a standard usage of rooted systems: leave open a
>>        port to the outside world to log in from.
>That wouldn't work.
>If a regular user shell process running as user_u:user_r:user_t can access the 
>network then it can also launch other shells.  There is no way of stopping 
>this.
>How do you distinguish a copy of bash launched as a shell for an interactive 
>session from an interpreter for a shell script?
>How do you distinguish programs such as "script" from a wrapper for a UDP 
>based terminal system?

Heh.  That's what I get for posting after just a moment's thought, right
  before I hit the hay.  :)
Excellent points.  I had originally been thinking that the info would
  be inherited by children (as would be logical), but it'd not actually
  prevent any such thing.  Dang.
Hmm.  Thinking about it again, maybe one could add a 'tainted' flag to
  a process that gets set when it listens to a socket?  Servers would
  be accompanied by a signature that verifies the integrity of the binary
  and are then not tainted on socket opening *if* they match?
Eh.  It seems like a good thing to eventually work towards.  :)

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
