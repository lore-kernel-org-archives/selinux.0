Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j193AiL9003102
	for <selinux@tycho.nsa.gov>; Tue, 8 Feb 2005 22:10:44 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1938Pgj000871
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2005 03:08:29 GMT
Received: by wproxy.gmail.com with SMTP id 40so88188wri
        for <selinux@tycho.nsa.gov>; Tue, 08 Feb 2005 19:10:37 -0800 (PST)
Message-ID: <ae023b6005020819101763ba8d@mail.gmail.com>
Date: Tue, 8 Feb 2005 22:10:37 -0500
From: Jim McCullough <jim.mccullough@gmail.com>
Reply-To: Jim McCullough <jim.mccullough@gmail.com>
To: ivg2@cornell.edu
Subject: Re: TTY question
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107915334.6602.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1107915334.6602.1.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tty refers to the system console or virtual consoles accessable via
terminal and keyboard.  pty is the designation for any remote
connections assignments, ie.  ssh user shell.  The main purpose is to
separate console user from the remote user for accountability.   TTY's
are not able to generate the high volume load that a PTY would for
physical reasons;  unless you build a killer keyboard for it.

  By setting up different rules for tty/pty on a user.  Console access
could allow extended privileges, where in remote access from another
system would block that access.   For the rest, I will have to check
on that later; or someone else may provide assistance.  I am currently
stuck in patching windows ...... again.

Jim McCullough


On Tue, 08 Feb 2005 21:15:34 -0500, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> Hi,
> 
> I don't quite understand the difference between all the TTY/PTY devices
> on Linux - could you explain how this works a bit, so that I will know
> for the future.
> 
> Which of those rules would be required for stdin/stdout?
> 
> allow $1_$2_t tty_device_t:chr_file rw_file_perms;
> allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
> 
> allow $1_$2_t devtty_t:chr_file rw_file_perms;
> allow $1_$2_t devpts_t:dir r_dir_perms;
> allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
> 
> What about proc permissions required?
> 
> Can some of those rules be put in a macro of some sort.
> I see tty rules all over the selinux policy, and perhaps
> they could be made more consistent with a macro.
> 
> --
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
Jim McCullough

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
