Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JLsERb014517
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 17:54:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JLsBAR015483
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 21:54:11 GMT
Received: from fury.moregruel.net (fury.moregruel.net [64.62.190.193])
        by jazzband.ncsc.mil  with ESMTP id i4JLsBHn015480 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 21:54:11 GMT
Date: Wed, 19 May 2004 16:54:09 -0500
From: Steve Greenland <steveg@moregruel.net>
To: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040519215409.GA7459@moregruel.net>
Reply-To: Steve Greenland <steveg@moregruel.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519200057.GD24597@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 19-May-04, 15:00 (CDT), Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote: 
> 
>  ... therefore, i take it that you mean that the letters "system_u"
>  _could_ be used as a username, whereas "*" is an invalid character
>  which, _if_ used in /etc/passwd, would cause a login error.

Yes.

>  and i take it that _that_ is why you object to its use, yes?

No. How many times do I have to say this? It's the WRONG FSCKING FIELD.
The field the SE linux people are so obsessed with changing is NOT
THE USERNAME field. The username field is available. Using it for
controlling the SE context would do the right thing, right? For the
real user crontabs, it would have the real username, even for root. For
the system crontabs, under /etc, it could be system_u. Then calling
SE_get_security_context(username) (or whatever the function/terminology
is) would always be the right thing to do, yes?

(And no, it's not the same as the UID associated with a particular job.
That's yet another field.)

Steve

-- 
Steve Greenland
    The irony is that Bill Gates claims to be making a stable operating
    system and Linus Torvalds claims to be trying to take over the
    world.       -- seen on the net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
