Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA19862
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 20:43:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA02220
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 00:41:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA02216 for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 00:41:52 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 64F0E92469
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 10:43:26 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 942A88564
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 02:43:18 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ioctl on a pty device
Date: Sat, 10 Aug 2002 02:43:17 +0200
MIME-Version: 1.0
Message-Id: <20020810004318.942A88564@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone made a reference to an IOCTL on a pseudo-tty allowing a process that 
can access the pty to get access to the master side (and therefore to pipe 
commands to other processes on the pty).

I would like to know, what is this IOCTL?  How does such access to the master 
work?

If the above problem is true then when the slave is relabeled to a different 
domain by newrole will the hostile program still have access to the master?



On a similar but related issue, recently I've been adding access to daemons 
to allow them to write to { sysadm_tty_device_t sysadm_devpts_t } so that 
they can write error messages if they fail to start, and I'm starting to 
think that I'm not doing things the right way.

It has occurred to me that a good solution would involve run_init creating 
it's own pty to communicate with the daemon (type initrc_devpts_t perhaps), 
and all daemons would get read/write access to that (from experimentation it 
appears that most daemons demand read access if they are to write to the pty 
- I have not examined the code to determine why this is so).  Now a correctly 
behaved daemon will close stdin/stdout/stderr when it's successfully 
initialised (yes I know many daemons are not correctly written - that's a 
separate issue), at which time run_init could exit.  For the master side of 
the pty run_init could detach a background process to copy data from the 
daemon and write it to the admin's terminal at the time that the parent of 
the daemon exits.  So the admin would see the same results as on a non-SE 
system, they run a daemon, which may output errors to their screen after they 
have received the shell prompt again, but which will hopefully detach itself 
fully in a short period of time.

This is fairly convoluted, is it necessary?  Or am I just getting paranoid 
while working late at night?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
