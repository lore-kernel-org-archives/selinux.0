Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2DLcjdW013888
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 16:38:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2DLciPC018068
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:38:44 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2DLch5x018065 for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:38:44 GMT
Message-Id: <200303132146.QAA24041@moss-shockers.ncsc.mil>
Date: Thu, 13 Mar 2003 16:46:17 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: 2 problems inetd & run_init ---
To: fw@fwsystems.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I updated glibc (to 2.3.2) and failed to realize that the shared libraries
> had all been installed as (e.g)
> 
> system_u:object_r:lib_t        /lib/libc-2.3.2.so
> 
> That's corrected now to:
> 
> system_u:object_r:shlib_t        /lib/libc-2.3.2.so

Yes, we need support in rpm (or whatever) to set labels properly when
upgrading packages.  It would help if critical programs were statically
linked.  Or, if shared libraries were grouped into their own directories
separate from the rest, we could ensure that the default type was
always shlib_t.  

> However, the failure killed login at both the serial port and console, 
> which required a reboot into a vanilla kernel.

Did single-user boot also fail to get you to a point where you could
relabel the shared libraries?  Probably.  Too many dynamically linked
programs.

> run_init will now not start any service
> 
> # run_init /etc/init.d/service stop|start
> could not translate osid to context.
> authentication failed.

This is a very odd error.  No messages in /var/log/messages or 'dmesg' output?
Might be interesting to replace the fprintf with a perror to see the
actual errno value.

> I've now tried relabeling the filesystems and the result is more 
> confusing still, run_init simply returns, and after reboot, returns
> to the above behavior.

There was a bug in the initrc.fc file at some point; you might want
to check yours against the current one.  Also, make sure that your
run_init program is up-to-date and that you are actually running the
one you intend (at some point, it was moved from /usr/local/selinux/bin
to /usr/local/selinux/sbin, so you might have an old one left in the 
old directory).

> /usr/local/selinux/bin/setfiles:  Running on a SELinux kernel, using new 
system calls
> /usr/local/selinux/bin/setfiles:  read 842 specifications
> /usr/local/selinux/bin/setfiles:  invalid context 
system_u:object_r:bossrv_exec_t on line number 481

The type above (and in your .fc file) doesn't match the type in your .te file.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
