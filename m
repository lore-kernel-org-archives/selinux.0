Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UNsBrT027990
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:54:11 -0400 (EDT)
Received: from iron1-mx.tops.gwu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UNsAog014577
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 23:54:10 GMT
From: Kodungallur Varma <ram25@gwu.edu>
To: russell@coker.com.au
Cc: Tom Anderson <granite217@yahoo.com>, selinux@tycho.nsa.gov
Message-ID: <3017057301b40f.301b40f3017057@gwu.edu>
Date: Thu, 30 Sep 2004 18:54:10 -0500
MIME-Version: 1.0
Subject: Re: purpose of the staff_r role?
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

     I am pretty new to selinux. I was setting up a selinux machine. I installed the OS and I installed the latest packages policy packages with the 'yum' command. I later rebooted with the enforcing=0 option during the boot. I later 'make relabel' ed it. I rebooted the machine again with the enforcing=0 mode and checked the /var/log/messages for avc:access denied messages. there are too many of them and I just dont know how to fix them. any help on this would be excellent. 

thanx in advance..

----- Original Message -----
From: Russell Coker <russell@coker.com.au>
Date: Thursday, September 30, 2004 3:43 pm
Subject: Re: purpose of the staff_r role?

> On Fri, 1 Oct 2004 05:31, Tom Anderson <granite217@yahoo.com> wrote:
> > > It's the role that a person who can become sysadm_r should do 
> their> > daily work in like reading mail, working on source code, 
> etc.  The
> > > reason is because it basically isn't allowed to interact with 
> user_t> > at all; for example, staff_t can't read user_tmp_t.  
> This prevents
> > > /tmp races from working.
> >
> > Ah, that makes sense.  But I'd like my staff_t user able to read
> > logfiles, without needing to become sysadm_r first ('cuz I can 
> do some
> > real damage inadvertently).  Is there a "correct" way to do 
> this?  I've
> > tried granting read access to var_log_t, but several daemons 
> have their
> > own logfile types.
> 
> r_dir_file(staff_t, logfile)
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux 
> packageshttp://www.coker.com.au/bonnie++/  Bonnie++ hard drive 
> benchmarkhttp://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing 
> list.If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
