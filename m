Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NKrSHa027922
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 16:53:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6NKqIFB019404
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 20:52:18 GMT
Received: from fort-point-station.mit.edu (FORT-POINT-STATION.MIT.EDU [18.7.7.76])
	by jazzswing.ncsc.mil  with ESMTP id h6NKqIGD019401
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 20:52:18 GMT
From: karlm@mit.edu
Message-Id: <200307231934.PAA18920@nerd-xing.mit.edu>
To: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
cc: Dean Anderson <dean@av8.com>, Russell Coker <russell@coker.com.au>,
   Charlie Watts <st_possenti@yahoo.com>, selinux@tycho.nsa.gov, karlm@mit.edu
Subject: Re: Linuxfromscratch.org
In-Reply-To: Your message of "Wed, 23 Jul 2003 08:09:49 PDT."
             <5.1.1.6.2.20030723080629.0a198680@Shire>
Date: Wed, 23 Jul 2003 15:34:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>At 13:49 22-07-03, Dean Anderson wrote:
>>if you are looking for integrity, Linuxfromscratch is just the start.
>>
>>You have to come up with a way to exclude Kerningan-style compiler hacks,
>>and similar OS hacks from being inserted into the "clean" source build.
>>
>>Kernigan, as some will remember, early in Unix days (70s), altered the
>>compiler to include a backdoor in login when it compiled login.c, and
>>altered the compiler to insert the backdoor-inserter whenever it compiled
>>itself.  So even if you recompiled Unix from scratch from clean source,
>>you still had a backdoor.  I think even if you retargeted the compiler, it
>>still inserted to the apprpropriate backdoor-inserter.  A similar hack can
>>be done at the OS level.
>>
>>                 --Dean
>
>Is this true of the GNU C compiler suite as well?  And if so, would it not 
>be possible to remove it from the compiler?  How does it work?  Does it 
>look at the code, or is anything called login.c susceptible?  Why has this 
>not been removed in the open-source code?  How can I check to see if this 
>backdoor exists?
>
>TIA,
>Carsten

I believe Dean is mistaken and is actually referring to Ken Thompson's
theoretical attack.  The point is you can't see if the backdoor
exists.  Unless you have personally recreated the history of modern
computing from first priciples in your basement or place of work, you
may be 0wn3d and not know it, in theory.

In practice, you can be pretty sure you're okay by cross-compiling
your entire system using GCC compiled from a vendor-supplied compiler.
You can be 99.99999% sure you're okay if you cross-compile GCC 3.3 and
an entire NetBSD sytem for a 68k Mac using GCC 1.0 (or the ealiest
veriosn that will cross-compile for m68k NetBSD) on IRIX MIPS
(compiled using SGI's CC) and then cross-compile your entire Linux
distro for x86 from NetBSD on that 68k box.  That amount of change
across architectures, generations, and vendors makes implementing a
virus that would survive that transition nearly impossible.  If you
need more assurances than that, you better reverse-engineer your HD
firmware to look for viruses that might insert themselves in your
kernel at boot time.

There is no escaping the need to trust trust.  In theory a PDP-11 CPU
microcode virus may have inserted itself in a hardware design for a
memory controller on a machine that was used to write the hard drive
firmware for the HD on the machine that was used to design the memory
controller for the original IBM PC and it may have hitched a ride
along the deign process all the way until it ended up in the hardware
and microcode in your Athlon so that it improperly implements the jne
operation when it is followed by a series of operations characteristic
of checking a particular password.

Are there any references to Kernigan's compiler hacks?  I believe Dean
is actually referring to Ken Thompson's famous paper "Reflections on
Trusting Trust".  Ken Thompson only theorized such an attack and I am
not aware of anyone that ever implemented a proof-of-concept for the
attack.

The whole point of the paper is that at a certain point, you're
placing trust in the history of all of the tools and all of the
hardware used to make your tools and your hardware.  If you need
absolute trust in your system, you'll need to make your own simple
computer from discrete transistors, resistors, etc. and design a CAD
system for it on paper in its machine code.  You then load the CAD
program into the machine manually byte by byte using dip switches or
else you make your own punch card system to load the computer.  You
use the CAD system do design an entire computer and create the fab
masks for all of the components using your trusted system, then fab
the components (including RAM and any persistant storage you were
going to use) yourself in your own fab.  You would need to make your
CPU immune to microcode viruses.  You would then use your trusted CAD
machine to write the bootstrapping code for your fabbed machine and an
assembler for the fabbed machine.  You'd then be able to finally boot
a trusted machine with reasonable speed and have a trusted assembler.
You'd use this to build a trusted C compiler.  Then you'd review every
line of code in the entire GNU/Linux system (well, at a bare minimum the
kernel, the shell, and the initial process) you were going to compile.

You gain confidence in your system by verifying the hardware and
software history.  The further back in time you verify things, the
harder it is for an attacker to mount an attack.  Unfortunately, for
absolute trust you would in fact need to make your own whicker
transistors and other components in your discrete component machine,
otherwise there could be a microchip hidden in the transistor, vacuum
tube, or relays you used that could talk to each other via subliminal
channels and figure out when they were doing computations for a CPU or
memory controller and introduce a hardware virus.  That level of
paranoia is rediculous, even for the NSA.  If you're up against
something that survives cross-compiling across 10 generations, vendors, and
architectures, you should really give up because the cost of victory will
be too high.


-Karl

--------
Karl Alexander Magdsick <karlm@mit.edu>

"The ultimate measure of a man is not where he stands in moments of 
comfort and convenience, but where he stands at times of challenge
and controversy." -- Martin Luther King Jr.  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
