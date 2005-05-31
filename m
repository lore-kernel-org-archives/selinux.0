Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4V0swgA028691
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 20:54:59 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4V0mm29009440
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 00:48:48 GMT
Date: Tue, 31 May 2005 01:57:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: gentoo/hardened
Message-ID: <20050531005739.GH28006@lkcl.net>
References: <20050530013136.GA28006@lkcl.net> <1117496766.1742.39.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117496766.1742.39.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 30, 2005 at 07:46:06PM -0400, Chris PeBenito wrote:
> On Mon, 2005-05-30 at 02:31 +0100, Luke Kenneth Casson Leighton wrote:
> > i've just installed gentoo/hardened on a laptop, and i wanted to run
> > Xorg on it.
> > 
> > bearing in mind the warnings about gentoo/hardened not having
> > "workstation" capability, i noted these and carried on, happy in the
> > knowledge that i would be able to sort it out.
> > 
> > ... then i found out what chris had done.
> 
> You make it sound like I did something nefarious!
 
  :)  *snort*  the joys of writing email at 3am... sorry about that.

  
  i wanted to be able to help / merge in xdm.te (and desktop
  usage) into gentoo/hardened.

  now i have two options:

  1) learn what you've done, and then contribute to that, knowing full
     well that none of what i do will benefit any other project, and
     that i will find it difficult to get advice here on selinux ml
     because of the divergence

  2) ignore and delete what you've done and endeavour to
     install the sf.net latest cvs on gentoo.

  given that gentoo/hardened selinux policy is the one that's
  different from all others, i'm far more inclined to 2).


> > chris - i hope you don't mind me saying this...
> > 
> > ... but you have made a _lot_ of work for yourself, and for
> > people like myself who would be happy to contribute / get
> > things working.
> > 
> > what chris has done is, rather than create (for example, as one
> > possible way forward) a gentoo_hardened define and comment out
> > blocks of code is... he's started from the sf.net cvs policy
> > and REMOVED entire sections from the gentoo released selinux
> > policy (including a large number of booleans).
> 
> This has been discussed on the list before.  

 dang, missed it - or wasn't paying attention because i was
 focussing on debian / selinux.

 sorry about that.

> We simply have different
> goals then other distros.  The NSA example policy is being pushed by Red
> Hat for widespread use, and the policy is developed in that direction,
> which is fine.  The tunable policy was converted over to use booleans
> and conditional policy support, which is to Red Hat's advantage, since
> they don't want to install policy sources on people's system by default.
> I don't have a problem with any of this, since widespread adoption helps
> SELinux, which is good.  
> 
> Gentoo users are willing to give up more functionality, especially
> legacy support, for more security.  

 i'd like to be a gentoo user, and i'd like it to be _less
 work_ to achieve more [see later on.  short: users' confusion and
 bewilderment at complexity and divergence from the "standard"
 is a recipe for LESS security not more].

 i feel confident that if you proposed something reasonable that
 meant there was one more distro whose needs and requirements
 were incorporated conveniently into the selinux sf.net cvs
 then people would do their level best to make room for it /
 start thinking of ways to accommodate it.


> We also don't want a bunch of dead
> policy, since its wasteful, and leaves more possibility of unwanted
> information flows.  

 okay - how about splitting what you classify as "dead policy"
 [wrt gentoo] out into separate files, then submitting
 a patch that then makes it easier for gentoo to "exclude"
 those files... WITHOUT people like me having to wade through
 a diff -ru to work out what you've deleted!


> So the 'base policy' is only the policy needed for
> the core system packages.  

> As a user merges more packages, policy is
> pulled in as a dependency as required.  

 yes, i noticed that - i thought that was a great idea.
 
 it also means that people have to _explicitly_ install an
 selinux policy package in order to allow the service to
 actually... er... work!

 the debian install method - over 100 questions "do you want
 package X" - yeurrk :)  try doing apt-get install on _that_!


> Configurability is a big thing
> for Gentoo users, and thus they are willing to get down into the
> details, so we definitely install the policy sources.  Most of the
> tunable policy does not need to be toggled at runtime; therefore, I
> reverted the conditional policy back to m4 ifdefs so there isn't extra
> unneeded policy in memory.

 hm... you're the second person to have raised this.
 
 valdis just this week chopped a stack-load of [iirc
 correctly: unused? ] macro stuff out and the memory usage
 dropped dramatically.

 if what valdis has done is suitable for gentoo/hardened,
 that would [fortunately!] make this justification redundant
 (i hope!)


> The main divergence is the conditional policy being switched back to m4
> ifdefs.  This wouldn't be sanely handled with distro tunables.  Most
> everything else is just the fact that I don't keep up with sourceforge
> CVS religiously.  

 okay, here's the rub.

 you changed _two_ things - 1) distro tunables 2) not keeping up with sf
 cvs.

 that makes it _very_ difficult 1) for you to maintain 2) for anyone
 _but_ you to follow.

 i'm a bright guy (well, i'm supposed to be).

 but hell i _sure_ don't want to get involved with a "fork"
 of selinux security policy - i _just_ don't have the time or
 money to focus on it in enough paranoid detail, and - correct
 me if i'm wrong - i doubt whether you do, either.

 and that _sure_ as hell means that no sane gentoo admin
 is going to have the time or inclination either - no matter
 _how_ configurable gentoo is.  [i have an experienced sysadmin
 friend - 15 years he's set up servers in secure environments.
 he had to call ME in to implement up a customised bastion
 selinux sftp server a few months back, after he explained to
 his bosses that it would take him a MONTH to even BEGIN to
 understand the issues involved in selinux policy, and even
 then he wouldn't be sure where to start or even if he'd got
 it right]


 ... there _are_ people however whose expertise you could ride with -
 stephen, russell, tresys - but forking a separate gentoo/hardened
 policy makes their expertise that _extra_ bit more remote.

 ... come back to the fold, chris, please!  we miss you.  baaaa :)

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
