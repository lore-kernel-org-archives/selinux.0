Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h38CSLI4020530
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 08:28:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h38COdOv009238
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:24:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h38COdY1009235
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:24:39 GMT
Subject: Re: NTFS / bitkeeper problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ccallen <ccallen@windowpane.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <001d01c2fd77$1721c5a0$398314d1@windowpane.com>
References: <001d01c2fd77$1721c5a0$398314d1@windowpane.com>
Content-Type: text/plain
Date: 08 Apr 2003 08:28:31 -0400
Message-Id: <1049804912.1606.23.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-04-07 at 22:32, ccallen wrote:
> I kicked off bitkeeper with "bk clone bk://lsm.bkbits.net:lsm-2.5", it made
> it as far as "include/linux/netfilter_ipv4/SCCS/s.ipt_dscp.h" and displayed
> the message below. Is it going to be impossible to clone the repository to
> NTFS, or is there a way to do this? I could put my linux machine online, but
> I wanted to get selinux configured first.

Sorry, I don't know if there is a workaround for the lack of case
sensitivity in NTFS.  

> Is the Mainline 2.5 basically the same thing as the lsm-2.5 bits, just
> cleaned up in preperation for release with the kernel?

No, there are fairly major changes taking place as part of preparing
SELinux for submission to mainline 2.5, as described in the
selinux-2.5/README file, and this is still a work in progress.  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
