Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8INoYrT010008
	for <selinux@tycho.nsa.gov>; Sat, 18 Sep 2004 19:50:36 -0400 (EDT)
Received: from mail.gurulabs.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8INna1H012233
	for <selinux@tycho.nsa.gov>; Sat, 18 Sep 2004 23:49:36 GMT
Subject: Re: SELinux policy discussion.
From: Dax Kelson <dax@gurulabs.com>
To: Valdis.Kletnieks@vt.edu
Cc: ivg2@cornell.edu, Colin Walters <walters@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <200409171719.i8HHJ1tP020778@turing-police.cc.vt.edu>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
	 <1095307503.4231.152.camel@nexus.verbum.private>
	 <1095318426.32510.30.camel@localhost.localdomain>
	 <1095356254.4231.188.camel@nexus.verbum.private>
	 <1095364389.10058.85.camel@localhost.localdomain>
	 <200409171719.i8HHJ1tP020778@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1095551424.4016.9.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Date: Sat, 18 Sep 2004 17:50:25 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-17 at 11:19, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 16 Sep 2004 15:53:09 EDT, Ivan Gyurdiev said:
> > What I want from MAC is to restrict my applications while preserving
> > 100% useful functionality and being transparent. I don't want more
> > restrictions on my behavior.
> 
> The problem is defining "100% useful functionality" in a way that's compatible
> with system security and integrity.  Remember that for the guy attacking the
> system, being able to exploit a /tmp race is "useful functionality".
> Conversely, there's a *lot* of crufty broken code out there that only works
> because it abuses some corner-case quirk that really *should* be fixed.
> 
> > I don't want mozilla_readhome and mozilla_writehome that are false by 
> > default so I can't save a web page to my home folder.
> 
> You'll sing a different tune if some hostile Javascript saves a .rhosts in your
> home directory (or any other file that will produce surprising results).

Your point is valid, but the example is a bit dated.

On any Linux distro made in the past 2-3 years, and certainly all the
2.6 kernel based distros, creating a .rhosts or /etc/hosts.equiv file
will have zero effect.

The trusting of .rhosts/hosts.equiv is not turned on by default, and you
have to jump through some non-trivial hoops to get it enabled.

Dax Kelson
Guru Labs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
