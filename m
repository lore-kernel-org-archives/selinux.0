Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h42Bs7I4015519
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 07:54:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h42BrsVf003593
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 11:53:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h42Brs4D003590
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 11:53:54 GMT
Subject: Re: kernel crashes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030502011436.GD17896@snoopy.apana.org.au>
References: <20030501022414.GA13019@snoopy.apana.org.au>
	 <20030502011436.GD17896@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1051876434.1377.424.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 May 2003 07:53:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-01 at 21:14, Brian May wrote:
> If I boot 2.4.20 and load the SE-Linux policy *after* it boots, there
> are no problems. This is after several days (if not weeks actually)
> after building lots of packages, daily cron jobs, etc.

I'm not sure why you are seeing this behavior; I haven't seen it myself.
However, as a caveat, you have to load the policy early in order for
processes (including init) to transition properly to their desired
domains.  If you are loading the policy late, I'd expect that a ps -e
--context would show many processes in the wrong domain (i.e. just being
left in the domain of the caller).
  
FYI, in the mainline 2.5-based SELinux, we've moved the initial policy
load into userspace based on kernel developer feedback, and are
currently performing it via an initrd (ultimately, we'd like to migrate
to using initramfs).  A copy of the binary policy file and load_policy
program are placed on the initrd, and the /linuxrc script is modified to
perform the initial policy load.  The kernel no longer reads the binary
policy directly from the file; the load_policy program opens+mmaps the
policy file and then writes the data to a /selinux/load pseudo node to
perform the load operation, similar to the new module interface in 2.5.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
