Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA17071
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 20:46:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA11436
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2001 00:45:03 GMT
Received: from windowpane.com (ip56.gte1.rb1.bel.nwlink.com [209.20.131.56])
	by jazzswing.ncsc.mil  with ESMTP id AAA11432
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2001 00:45:03 GMT
Message-ID: <000c01c135a4$3524d700$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: "Howard Holm" <hdholm@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
References: <003401c13432$00288830$3a8314d1@nwlink.com> <20010904125630.A16961@truffula.epoch.ncsc.mil>
Subject: Re: checkpolicy creates core file
Date: Tue, 4 Sep 2001 17:46:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This was the problem. I set it to Classic Pentium and now checkpolicy works
fine.

Conan

----- Original Message -----
From: "Howard Holm" <hdholm@epoch.ncsc.mil>
To: "Conan Callen" <ccallen@windowpane.com>
Cc: <selinux@tycho.nsa.gov>
Sent: Tuesday, September 04, 2001 9:56 AM
Subject: Re: checkpolicy creates core file


> There's not a lot of information to go on here, but you might check the
> kernel configuration under "Processor type and features" for "Processor
> family" type.  I've seen similar problems when a kernel/checkpolicy is
> compiled for a Pentium 3 and run on a standard Pentium.
>
> On Sun, Sep 02, 2001 at 09:36:29PM -0700, Conan Callen wrote:
> > I get a core file whenever checkpolicy is executed. While running step 4
(build and install the example policy configuration) the core occurs.
> >
> > During the first install, today, I got this error. I thought I may had
made a mistake, so I started over from scrath (deleted (rm -rf) both
/root/lsm & /root/selinux then untared the distribution again). Once again I
got the same error.
> >
> > Im going to continue with the install. I brought the core up in gdb, but
its going to take a while for me to figure out whats going on. Im hoping
that I can fix it after I get it installed.
> >
> > I started with
http://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz. I just
installed a fresh RedHat 7.1.
> >
> >
> > I had installed selinux successfully before, but I got a "Kernel Panic"
that looked like it was caused by a harddisk error. So I started with a new
couple new harddrives and reinstalled linux.
> --
> Howard Holm <hdholm@epoch.ncsc.mil>
> Information Assurance Research Group
> National Security Agency
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
