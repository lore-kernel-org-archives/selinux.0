Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IL0sRb005437
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 17:00:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IL0qAR023770
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:00:52 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
        by jazzband.ncsc.mil  with SMTP id i4IL0pHn023767 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:00:51 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 18 May 2004 20:21:28 -0000
Date: Tue, 18 May 2004 20:18:45 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518201845.GC7348@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil> <20040518130244.GB24917@lkcl.net> <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil> <20040518151112.GF24917@lkcl.net> <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil> <20040518185135.GL24917@lkcl.net> <1084910062.28966.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084910062.28966.183.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 03:54:22PM -0400, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 14:51, Luke Kenneth Casson Leighton wrote:
> >tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t system_u:system_r:initrc_t shm
> > 	allowed= null
> > 
> >  uhn???
> 
> You asked what the X server (started from xdm) (xdm_xserver_t) can do to
> a shared memory object (shm) created by a system initialization script
> (initrc_t).  And the answer was nothing.  Why is that surprising?

 okay, well, i think it sensible to start again, because now i have
 compiled the selinux utils and libs on a system with the same
 kernel as the target machine.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
