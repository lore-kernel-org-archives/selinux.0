Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3RHFkI4021084
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 13:15:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3RHFdVf013877
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 17:15:39 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3RHFV4D013874
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 17:15:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Robert Bihlmeyer <robbe@orcus.priv.at>, selinux@tycho.nsa.gov
Subject: Re: broad domains
Date: Mon, 28 Apr 2003 03:14:59 +1000
References: <87n0ilej7x.fsf@orcus.priv.at> <200304251321.07207.russell@coker.com.au> <87of2r9apb.fsf@orcus.priv.at>
In-Reply-To: <87of2r9apb.fsf@orcus.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304280314.59792.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Apr 2003 02:17, Robert Bihlmeyer wrote:
> > > A have the same problem with the games domain provided in the default
> > > policy (or at least in Russell's package). As is, it doesn't fit half
> > > the stuff in my /usr/games.
> >
> > How does it not fit them?
>
> I simply don't think it makes sense to put a class as diverse as games
> into one domain. Some games, need X access (provided by the default
> policy), some none. Some need direct video access, or want to output

The problem is in categorising the games.  There are a huge number of games, 
they are being written and re-written all the time.  For something that's 
easy to setup having a single domain for all of them works reasonably well.

> (in rare cases input) sound. Some need read access to game data, or
> r/w access to state (hiscore, save games), that may be located in a
> shared area or in a fixed or variable location below the user's home.
> Sometimes even the game data or the game itself is in a user-specified
> location (think: Doom WADs or Infocom zcode).

I think that my policy covers this reasonably well.

> Basically, I think most games should just run under user_t, and the
> blanket specification putting everything in /usr/games into this
> domain is wrong.

So if you run a network game that is compromised then it can run "ssh host" 
and use your ssh authorized key.  It can ptrace other processes that you run, 
send all your files out over the network, and do every other bad thing you 
can imagine.

Of course with the current situation regarding X a cracked game could sniff 
the keyboard when you are entering a password.  But this is more difficult to 
arrange, and we do plan to solve the X problem eventually.

If you want games to run in user_t then simply don't install games.te.

> > > On the other hand, having a domain for every teensy toy out there
> > > seems a bit excessive.
> >
> > Yes, it becomes a management nightmare which isn't good for security.
>
> If we had a stronger inheritance model (maybe just through m4 macros)
> I'm not so sure it's too hard to handle.

Go for it.  Write some sample policy and demonstrate to us how easy it is!

> > > BTW, can't setfiles assume some default user & role if none is given?
> > > Repeating system_u:object_r: a million times is superflous.
> >
> > I did that once and Steve convinced me to stop doing it.
>
> Any subject keywords or URL so I can find the arguments?

Just search the mailing list archives for devfsd, I think the early discussion 
of the devfsd module contains the relevant information.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
