Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA20547
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 01:50:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA28690
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 05:49:20 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id FAA28686 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 05:49:18 GMT
Date: Sat, 27 Jul 2002 15:50:45 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Message-ID: <20020727055045.GB20092@snoopy.apana.org.au>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726114247.3A14A14D1@lyta.coker.com.au> <20020727044221.GE18313@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020727044221.GE18313@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 27, 2002 at 02:42:21PM +1000, Brian May wrote:
> > For clamav.te, I think you should do something similar to what I have done 
> > for the irc domain.  I've partially hacked the appropriate code into my tree. 
> >  Doing that will allow multiple user domains easily (the way you did it will 
> > require editing clamav.te every time you add a new user domain).
> 
> Good point.

2nd thoughts, I am not convinced this stuff should go in a macro:

allow user_clamscan_t ttyfile:chr_file rw_file_perms;
allow user_clamscan_t ptyfile:chr_file rw_file_perms;
allow user_clamscan_t user_home_t:dir r_dir_perms;
allow user_clamscan_t user_home_t:file r_file_perms;
ifdef(`gnome-pty-helper.te', `allow user_clamscan_t gphdomain:fd use;')

As sometime in the future you might want to create
an domain that can use clamscan that redirects all input to/from
a GUI (for instance) and doesn't require access to the users
home directory.

Maybe another macro is needed here?

define(`user_clamscan_domain',`
clamscan_domain($1)
allow $1_clamscan_t ttyfile:chr_file rw_file_perms;
allow $1_clamscan_t ptyfile:chr_file rw_file_perms;
allow $1_clamscan_t $1_home_t:dir r_dir_perms;
allow $1_clamscan_t $1_home_t:file r_file_perms;
ifdef(`gnome-pty-helper.te', `allow $1_clamscan_t gphdomain:fd use;')
')

(by user I mean user or sysadm; I really need another word
to mean both...).
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
