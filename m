Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4GFRII4024253
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 11:27:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4GFRHTd024269
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 15:27:17 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h4GFRCE6024258 for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 15:27:16 GMT
Date: Fri, 16 May 2003 11:25:46 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Howard Holm <hdholm@epoch.ncsc.mil>
cc: Douglas Phillipson <phillipd@oem.doe.gov>, <selinux@tycho.nsa.gov>
Subject: Re: Has anyone had or seen a SELinux system approved for	classified
 use?
In-Reply-To: <1053029192.10963.39.camel@moss-sooners.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0305161125150.6456-100000@commander.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for that. And thanks for the gentle correction.  13 or 14 years can
cause a lot of bit rot...

                --Dean



On 15 May 2003, Howard Holm wrote:

> I don't mean to be too harsh, but the answer given here by Dean is
> dramatically wrong.  Since this is a public forum, I feel a need to
> caution anyone from depending on it.  The Trusted Computer Security
> Evaluation Criteria (TCSEC) references given by Steven Rottura in his
> response should help anyone who wants to understand what C2, B1, and B2
> really mean at a high level.  However, the TCSEC has been superceeded by
> the Common Criteria for a number of years now.  The Common Criteria as a
> whole is more than I want to get into in this note, but evaluation
> against the Common Criteria is most similar to TCSEC terms when
> performed against the requirements of a Protection Profile.  Various
> Protection Profiles including current C2 and B1 equivalents for
> operating systems can be found at
> http://www.nsff.org/protection_profiles/profiles.cfm
>
> On Thu, 2003-05-15 at 09:50, Dean Anderson wrote:
> > Its been awhile, but when I was at OSF back in the late 80s, OSF/1 was
> > developed to be B1 certified. C2 only requires that physical access to the
> > "console" still require a password to boot, and that the case be lockable
> > to exclude undetected disassembly. On a PC, this is handled by the BIOS,
> > and most BIOS's handle this now.  Sun and most workstation vendors also
> > can protect the boot rom with a password.  Most PC and workstation
> > enclosures also have locks.  You can get a copy of the DOD orange book to
> > look up other requirements, but I think that was pretty much it.
> >
> > Prior to working at OSF, I worked at Draper Labs, which handled classified
> > computing. This was still in the mainframe era, but at the early part of
> > the PC era. Prior to a classified computing run, the Mainframe was
> > isolated from the rest of the lab via scheduled downtime. I think the
> > isolation was physical disconnection of terminal controllers and network
> > controllers, but I'm not sure. I didn't work in that part of the computer
> > center.  Classified PC computing was done in secured labs, where the PC
> > had no outside connection, and personnel in the labs were cleared.  C2
> > security essentially just attempts to detect and deter some kinds of
> > inappropriate behavior by cleared personnel.
> >
> > Linux is not a terribly secure operating system.  I don't present myself
> > as an expert, but I think it would be inadvisable to rely on linux to keep
> > any data secure in a multiuser classified/non-classified environment.
> > Perhaps the result of the SELinux project might be a B1 or B2
> > certification**, but its clearly not there yet.
> >
> > **If I recall, B1 requires that OS privileges be split into different
> > roles, so that no one person can compromise the system undetected, and B2
> > requires mandatory access control. There are other requirements and
> > differences that I don't rememeber. Also as I recall, the pentagon kept
> > multics around for so long because it was the only certified B2 secure
> > system.  I'm not sure the multics system was replaced with another B2
> > system, or if they just set up completely separate classified and
> > unclassified networks, and partitioned classified networks accordingly.
> >
> > 		--Dean
> >
> > On Wed, 14 May 2003, Douglas Phillipson wrote:
> >
> > > This may be the wrong forum for this question and I apologize if thats
> > > the case.  I was wondering if anyone has or knows of any Linux
> > > systems/networks/OS versions that have been approved for processing
> > > classified data?  I work for the Dept Of Energy and am looking for a
> > > test case to model a security plan on, possibly using SELinux.
> > >
> > > I am also looking for "C2" software for Linux if anyone has seen it?
> > >
> > > Regards
> > >
> > > Doug Phillipson
>
> --
> Howard Holm <hdholm@epoch.ncsc.mil>
> Secure Systems Research Office
> National Security Agency
>
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
