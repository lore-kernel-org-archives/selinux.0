Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA06811
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 12:19:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27170
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 17:19:44 GMT
Received: from mail.thesportsregister.com ([208.53.250.139])
	by jazzband.ncsc.mil  with ESMTP id RAA27164
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 17:19:42 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.thesportsregister.com (Postfix) with ESMTP id 3B63EFE20
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 12:23:58 -0500 (EST)
Date: Mon, 12 Feb 2001 12:23:58 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: selinux@tycho.nsa.gov
Subject: Re: Looking to help with a crypto design
In-Reply-To: <20010211220008.A15251@linuxgames.com>
Message-ID: <Pine.LNX.4.21.0102121208480.19045-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Sun, 11 Feb 2001, Dustin Reyes wrote:

> Would it be good form to laugh at this point?

I dunno. Have you put the form through lint?
 
> -Dustin
> 
> On Sun, Feb 11, 2001 at 08:05:22PM -0500, snagnbytz wrote:
> > Well i am not much on posting in GoV related newsgroups or mailing list but i
> > have checked some things out with SElinux and i agree that the best way to run
> > a secure system is at the kernel level of encryption

English Yoda School of closed, is it.

> > I have been working on a color based encryption for over a year and half now
> > which deals with all 16.7 million colors and the level in which i built it is
> > unique because its combinations is 16.7million to the power of 16.7 million by
> > using 255of reds greens and blues you can make color filters or take something
> > similiar to building a raster interrupt with reading and writing the encryption
> > back to itself which i have mapped out ways to make this possible i think that
> > using a color based encryption would work on more then just this such as
> > fiber-optic with different colors only able to respond to the same color it
> > generates. I do alot of research on my own if i could get back to college i
> > might be able to make this color based encryption work with more then just
> > something like what i am seeing here with SElinux.

Security != Encryption
Colour != (Security | Encryption)

(Well, unless you're a tetrachromat, of course, in which case selectively
invisible ink becomes a real possibility.)

As for the description given, I would strongly urge the author to apply
for a top position at Microsoft, where they will fit right in. Indeed, I
have no doubt whatsoever that they could improve the security there.

Simply put, encryption is the translation of one data stream into a second
data stream, in a manner that makes the inverse operation non-trivial for
a third-party. It really doesn't make any difference if you're using
colours, bitstreams, or giant abacusses strapped to the back of elephants.

The translation function is all that really matters. And the challange is
to develop one that does not reduce to something much simpler -AND- one
that does not produce the correct decrypted stream for multiple
keys. This is NOT trivial. If it was, Julius Caesar's cypher would still
be in use, because there'd be no need for anything better.

Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
