Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2LFxhx6022574
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 10:59:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2LFwMR1019755
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 15:58:22 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h2LFwMj9019752 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 15:58:22 GMT
Message-Id: <200303211604.LAA20617@moss-shockers.ncsc.mil>
Date: Fri, 21 Mar 2003 11:04:32 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SE-Linux and 2.4.20
To: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Brian May wrote:
> I have found I simply cannot use a 2.4.20 kernel with SE-Linux
> support on my laptop computer with out it "hanging" after a while.
> 
> By this I mean random processes hang, and cannot be killed, even with
> kill -9, and rebooting doesn't work.
> 
> Combinations tested:
> 
> 2.4.19 + older selinux patch (v12) = OK
> 2.4.20 with SE-Linux (accidently) disabled = OK
> 2.4.20 with new SE-Linux patch (v12) = crashed before 30 minutes.
> (was doing nothing but downloading files at the time with apt-get).
> 
> In all cases I have the same policy installed.
> 
> Any ideas on how to debug this problem further?

I haven't seen this behavior myself.  Was there anything useful in
/var/log/messages or the dmesg output, e.g. a kernel Oops message?  As
a reminder, we don't incorporate other bug fix patches in the
LSM/SELinux patches, so you do need to apply any other bug fix patches
that you want for the base kernel, e.g. the ext3 fixes for 2.4.20.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
