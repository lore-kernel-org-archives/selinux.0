Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OCFGHa000033
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 08:15:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OCFFDW018403
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:15:15 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
        by jazzband.ncsc.mil  with ESMTP id h6OCFFeN018400 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:15:15 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OCFAxH014611
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 08:15:10 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6OCFAxr014609
	for selinux@tycho.nsa.gov; Thu, 24 Jul 2003 08:15:10 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NMC2Ha028334
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 18:12:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6NMC2DW003527
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 22:12:02 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h6NMC1eN003524 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 22:12:01 GMT
Date: Wed, 23 Jul 2003 18:08:33 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: karlm@mit.edu
cc: "Carsten P. Gehrke" <Carsten@rollinghorse.com>,
   Russell Coker <russell@coker.com.au>, Charlie Watts <st_possenti@yahoo.com>,
   <selinux@tycho.nsa.gov>
Subject: Re: Linuxfromscratch.org
In-Reply-To: <200307231934.PAA18920@nerd-xing.mit.edu>
Message-ID: <Pine.LNX.4.44.0307231746200.22745-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It could very well have been Ken Thompson who did or thought up the
original hack.  I never saw a paper (at least I don't recall seeing a
paper.) I believe I heard it verbally either from Peter Salus or perhaps
at a Usenix many years ago. Peter Salus was employed at the OSF when I was
there, and has since written a book on the History of Unix, and told many
regalling stories about Unix.  But I learned of this at least 12+ years
ago, so memory fades as to the exact details.  But the details are of
little consequence.  In principle, the same hack could be done again,
perhaps at a Linux distribution vendor.  Karl makes a very good point that
complete trust is hard to ever have. However, Redhat and other
Linux/FreeBSD/NetBSD/etc distibutions are not exactly the NSA in terms of
computer security, and security varies quite a lot.

However, I would like to point out that if the hack inserts source code at
a certain point in a certain file, then cross compilation will not remove
the hack, no matter how many odd architectures one goes through.

I think Lukasz Luzar's procedure is probably the more reasonable for most
purposes.

BTW, I've read rumors (Bamford's Body of Secrets) that the NSA does make
it own chips. Maybe for this reason....;-)

		--Dean

On Wed, 23 Jul 2003 karlm@MIT.EDU wrote:

>
> >At 13:49 22-07-03, Dean Anderson wrote:
> >>if you are looking for integrity, Linuxfromscratch is just the start.
> >>
> >>You have to come up with a way to exclude Kerningan-style compiler hacks,
> >>and similar OS hacks from being inserted into the "clean" source build.
> >>
> >>Kernigan, as some will remember, early in Unix days (70s), altered the
> >>compiler to include a backdoor in login when it compiled login.c, and
> >>altered the compiler to insert the backdoor-inserter whenever it compiled
> >>itself.  So even if you recompiled Unix from scratch from clean source,
> >>you still had a backdoor.  I think even if you retargeted the compiler, it
> >>still inserted to the apprpropriate backdoor-inserter.  A similar hack can
> >>be done at the OS level.
> >>
> >>                 --Dean
> >
> >Is this true of the GNU C compiler suite as well?  And if so, would it not
> >be possible to remove it from the compiler?  How does it work?  Does it
> >look at the code, or is anything called login.c susceptible?  Why has this
> >not been removed in the open-source code?  How can I check to see if this
> >backdoor exists?
> >
> >TIA,
> >Carsten
>
> I believe Dean is mistaken and is actually referring to Ken Thompson's
> theoretical attack.  The point is you can't see if the backdoor
> exists.  Unless you have personally recreated the history of modern
> computing from first priciples in your basement or place of work, you
> may be 0wn3d and not know it, in theory.
>
> In practice, you can be pretty sure you're okay by cross-compiling
> your entire system using GCC compiled from a vendor-supplied compiler.
> You can be 99.99999% sure you're okay if you cross-compile GCC 3.3 and
> an entire NetBSD sytem for a 68k Mac using GCC 1.0 (or the ealiest
> veriosn that will cross-compile for m68k NetBSD) on IRIX MIPS
> (compiled using SGI's CC) and then cross-compile your entire Linux
> distro for x86 from NetBSD on that 68k box.  That amount of change
> across architectures, generations, and vendors makes implementing a
> virus that would survive that transition nearly impossible.  If you
> need more assurances than that, you better reverse-engineer your HD
> firmware to look for viruses that might insert themselves in your
> kernel at boot time.
>
> There is no escaping the need to trust trust.  In theory a PDP-11 CPU
> microcode virus may have inserted itself in a hardware design for a
> memory controller on a machine that was used to write the hard drive
> firmware for the HD on the machine that was used to design the memory
> controller for the original IBM PC and it may have hitched a ride
> along the deign process all the way until it ended up in the hardware
> and microcode in your Athlon so that it improperly implements the jne
> operation when it is followed by a series of operations characteristic
> of checking a particular password.
>
> Are there any references to Kernigan's compiler hacks?  I believe Dean
> is actually referring to Ken Thompson's famous paper "Reflections on
> Trusting Trust".  Ken Thompson only theorized such an attack and I am
> not aware of anyone that ever implemented a proof-of-concept for the
> attack.
>
> The whole point of the paper is that at a certain point, you're
> placing trust in the history of all of the tools and all of the
> hardware used to make your tools and your hardware.  If you need
> absolute trust in your system, you'll need to make your own simple
> computer from discrete transistors, resistors, etc. and design a CAD
> system for it on paper in its machine code.  You then load the CAD
> program into the machine manually byte by byte using dip switches or
> else you make your own punch card system to load the computer.  You
> use the CAD system do design an entire computer and create the fab
> masks for all of the components using your trusted system, then fab
> the components (including RAM and any persistant storage you were
> going to use) yourself in your own fab.  You would need to make your
> CPU immune to microcode viruses.  You would then use your trusted CAD
> machine to write the bootstrapping code for your fabbed machine and an
> assembler for the fabbed machine.  You'd then be able to finally boot
> a trusted machine with reasonable speed and have a trusted assembler.
> You'd use this to build a trusted C compiler.  Then you'd review every
> line of code in the entire GNU/Linux system (well, at a bare minimum the
> kernel, the shell, and the initial process) you were going to compile.
>
> You gain confidence in your system by verifying the hardware and
> software history.  The further back in time you verify things, the
> harder it is for an attacker to mount an attack.  Unfortunately, for
> absolute trust you would in fact need to make your own whicker
> transistors and other components in your discrete component machine,
> otherwise there could be a microchip hidden in the transistor, vacuum
> tube, or relays you used that could talk to each other via subliminal
> channels and figure out when they were doing computations for a CPU or
> memory controller and introduce a hardware virus.  That level of
> paranoia is rediculous, even for the NSA.  If you're up against
> something that survives cross-compiling across 10 generations, vendors, and
> architectures, you should really give up because the cost of victory will
> be too high.
>
>
> -Karl
>
> --------
> Karl Alexander Magdsick <karlm@mit.edu>
>
> "The ultimate measure of a man is not where he stands in moments of
> comfort and convenience, but where he stands at times of challenge
> and controversy." -- Martin Luther King Jr.
>
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
