Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523SCrT000753
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:28:12 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i533RueD016753
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 23:27:57 -0400 (EDT)
Date: Tue, 1 Jun 2004 11:09:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Simo Sorce <idra@samba.org>
Cc: samba-technical@samba.org, tng-technical@lists.samba-tng.org,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: se-samba
Message-ID: <20040601110924.GE8312@lkcl.net>
References: <40ACFC0C.9020101@snu.edu> <20040529095153.GB16927@lkcl.net> <200405312249.11522.rcoker@redhat.com> <16571.47722.750708.219840@samba.org> <20040531232931.GE8312@lkcl.net> <1086081794.3268.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086081794.3268.39.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 11:23:14AM +0200, Simo Sorce wrote:
> On Tue, 2004-06-01 at 01:29, Luke Kenneth Casson Leighton wrote:
> >  can i recommend - tridge, others - that you give serious
> >  consideration to writing an experimental samba 4 "NTVFS"
> >  SMB proxy client plugin?
> 
> That was the first VFS available for samba4, it has been used happily
> for many months now. And it's not that much experimental, it works
> really well and made a great job into finding out many errors in the
> core of samba4 and also samba3 handling of operations.
 
 brilliant!  excellent!

 that's actually _really_ good news.

 okay, so now it is possible to use that as the front-end for
 se-samba(4), and to run against a samba(3) server as the back-end!

 GREAT.

 okay, got a question for you.

 how does the samba4 smb client VFS proxy handle multiple
 TConX's over the same SMBsessionX?

 does it:

 a) try to multiplex them onto the same smb client connection?

 b) create a NEW smb client tcp connection over to the back-end
    smb server?

 if b) then the work needed to support se-samba is... like... done!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
