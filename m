Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5FEgZrT025851
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 10:42:35 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5FEgRRI013666
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 14:42:27 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5FEgOJQ009681
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 10:42:24 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i5FEgOXt009679
	for selinux@tycho.nsa.gov; Tue, 15 Jun 2004 10:42:24 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EK0HrT021326
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 16:00:17 -0400 (EDT)
Received: from pop.potsdam.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5EK0E0G019831
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 20:00:14 GMT
Subject: Re: se-samba
From: Matthew Keller <kellermg@potsdam.edu>
To: tng-technical@samba-tng.org, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: tridge@samba.org, samba-technical@samba.org,
   SE-Linux <selinux@tycho.nsa.gov>, tng-technical@lists.samba-tng.org
In-Reply-To: <20040603211215.GK3856@lkcl.net>
References: <200405312249.11522.rcoker@redhat.com>
	 <16571.47722.750708.219840@samba.org> <20040531232931.GE8312@lkcl.net>
	 <1086081794.3268.39.camel@localhost.localdomain>
	 <20040601110924.GE8312@lkcl.net>
	 <1086096477.3268.63.camel@localhost.localdomain>
	 <20040601133547.GU8312@lkcl.net> <E1BV9Yp-0002wU-00@intern.SerNet.DE>
	 <16573.1058.707078.949935@samba.org> <20040602124523.GA3708@lkcl.net>
	 <20040603211215.GK3856@lkcl.net>
Content-Type: text/plain
Message-Id: <1087243248.6837.7.camel@mlap2.potsdam.edu>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 16:00:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I started to write an SMB protocol plugin for Apache2. Then I got
distracted by a paying project and haven't been back at it. I spent many
hours planning out the requirements and it all looked very very doable.
My design had a separate "nmbd"-esque daemon just to deal with the
persistent LAN netbios-naming crap, but the "smbd"-esque part appeared
to be 100-160 manhours based on my Gantt. Of course, I could've grossly
underestimated it, but I don't think so. I'll probably hack back at it
sometime this summer. I really like the Apache2 infrastructure, and
after doing a couple toy protocols, wanted to jump in over my head. :) 

My $0.02.

On Thu, 2004-06-03 at 17:12, Luke Kenneth Casson Leighton wrote:
> btw if anyone is concerned about the speed of a multi-processed
> arrangement (one daemon per service, where services equals
> double-digits as in samba-tng) then of course all you need
> to do to fix the fork() issue is to use the same approach as
> apache(1&2): have a pool of pre-forked processes on tap.
> 
> in fact i am surprised that 1) smbd has not had such code added
> to it already 2) that serious consideration has not been given
> to using the new apache2 framework: careful analysis of libapr
> shows significant code duplication and similarity in key areas.
> 
> l.
> 
> _______________________________________________
> tng-technical at samba-tng dot org
> http://lists.samba-tng.org/mailman/listinfo.cgi/tng-technical
-- 
Matthew Keller
signat-url: http://mattwork.potsdam.edu/signat-url/
"No one ever says, 'I can't read that ASCII E-mail you sent me.'"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
