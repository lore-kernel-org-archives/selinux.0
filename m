Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5K9sRb007706
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 15:09:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5K9rRV012635
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:09:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB5K9qta012629 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:09:53 GMT
Subject: Re: new to the list
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5.2.1.1.2.20031205115049.05a5f110@popcorn.llnl.gov>
References: <5.2.1.1.2.20031205115049.05a5f110@popcorn.llnl.gov>
Content-Type: text/plain
Message-Id: <1070654987.27266.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Dec 2003 15:09:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-05 at 14:52, Mark Shakespeare wrote:
> I ran the patch for the Mkinitrd script,  then created an initrd using the 
> command " mkinitrd  /boot/2.6.0-test6-selinx1.img 2.6.0-test6-selinux1
> 
>   it mentions a /linuxrc file.....but gives no samples...
> 
> Is there a sample /linuxrc file?    Where does it go?
> 
> Does anyone have a cookbook installation guide for installing SE-Linux on RH9?

That is created by the mkinitrd script on the initrd.  So if you ran the
patched mkinitrd script, you are done with that step.

If you want an easier install (and more recent code), check out
ftp://people.redhat.com/dwalsh/SELinux, which has userland RPMs and some
sample scripts, and http://people.redhat.com/arjanv/2.5, which has
kernel RPMs.  But you'll need to upgrade to Fedora Core as your base
platform to easily use these RPMs.

We hope to have an updated release on the NSA web site soon; many things
have changed since the October release (which is what you are using). 
Note that the modified initrd is no longer necessary with the latest
code; Dan Walsh of RH created a patched /sbin/init program to perform
the initial policy load.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
