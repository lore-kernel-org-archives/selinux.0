Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IImqrT019262
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:48:53 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5IImgpw011535
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 18:48:42 GMT
Date: Fri, 18 Jun 2004 18:42:33 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Matthew Keller <kellermg@potsdam.edu>
Cc: tng-technical@samba-tng.org, tridge@samba.org, samba-technical@samba.org,
   SE-Linux <selinux@tycho.nsa.gov>, tng-technical@lists.samba-tng.org
Subject: Re: se-samba
Message-ID: <20040618184233.GG362@lkcl.net>
References: <20040531232931.GE8312@lkcl.net> <1086081794.3268.39.camel@localhost.localdomain> <20040601110924.GE8312@lkcl.net> <1086096477.3268.63.camel@localhost.localdomain> <20040601133547.GU8312@lkcl.net> <E1BV9Yp-0002wU-00@intern.SerNet.DE> <16573.1058.707078.949935@samba.org> <20040602124523.GA3708@lkcl.net> <20040603211215.GK3856@lkcl.net> <1087243248.6837.7.camel@mlap2.potsdam.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087243248.6837.7.camel@mlap2.potsdam.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya,

if you want to drastically cut down the amount of time you take,
look at the cliffs project.

you will find that there is a very simple IDL generator (written
in awk by andrew) which was used to auto-generated _stacks_ of code
which you would be completely mad to recreate manually.

the IDL file itself is taken DIRECTLY from the cifs specification
(text version) and i MEAN directly: i massaged it a bit and
added some grungy bits and ran the compiler.

if you need a change of / alternative / dual license on any
of the bits that i am responsible for, let me know.

l.


On Mon, Jun 14, 2004 at 04:00:48PM -0400, Matthew Keller wrote:
> I started to write an SMB protocol plugin for Apache2. Then I got
> distracted by a paying project and haven't been back at it. I spent many
> hours planning out the requirements and it all looked very very doable.
> My design had a separate "nmbd"-esque daemon just to deal with the
> persistent LAN netbios-naming crap, but the "smbd"-esque part appeared
> to be 100-160 manhours based on my Gantt. Of course, I could've grossly
> underestimated it, but I don't think so. I'll probably hack back at it
> sometime this summer. I really like the Apache2 infrastructure, and
> after doing a couple toy protocols, wanted to jump in over my head. :) 
> 
> My $0.02.
> 
> On Thu, 2004-06-03 at 17:12, Luke Kenneth Casson Leighton wrote:
> > btw if anyone is concerned about the speed of a multi-processed
> > arrangement (one daemon per service, where services equals
> > double-digits as in samba-tng) then of course all you need
> > to do to fix the fork() issue is to use the same approach as
> > apache(1&2): have a pool of pre-forked processes on tap.
> > 
> > in fact i am surprised that 1) smbd has not had such code added
> > to it already 2) that serious consideration has not been given
> > to using the new apache2 framework: careful analysis of libapr
> > shows significant code duplication and similarity in key areas.
> > 
> > l.
> > 
> > _______________________________________________
> > tng-technical at samba-tng dot org
> > http://lists.samba-tng.org/mailman/listinfo.cgi/tng-technical
> -- 
> Matthew Keller
> signat-url: http://mattwork.potsdam.edu/signat-url/
> "No one ever says, 'I can't read that ASCII E-mail you sent me.'"
> 

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
