Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FGq0La014767
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 12:52:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FGoJLY028330
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 16:50:19 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8FGoDsG028302
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 16:50:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Problem relabeling journalfile
Date: Tue, 16 Sep 2003 02:51:25 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915145004.GB8988@vnl.com> <20030915152948.GC8988@vnl.com> <1063640607.13311.156.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1063640607.13311.156.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309160251.25816.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2003 01:43, Stephen Smalley wrote:
> Patch below.  Note that you should escape dot since it will otherwise be
> interpreted as "any character" by the regular expression matching code,
> and we should include entries for common filesystem mount points to
> cover most cases, similar to the existing entries for lost+found.  We
> can likely drop out the persistent label mapping entries entirely aside
> from backward compatibility support for the old SELinux.

Do you think it would be beneficial to have a method of specifying rules that 
apply relative to the root of a file system instead of to the root?

EG:
FS/.journal
FS/lost\+found
FS/quota.user
FS/quota.group

With the current operation of setfiles for completeness we have to add such 
entries for every new mount point.  Having setfiles accept such a spec when 
labeling an entire file system would be easy to code, and it wouldn't be 
really difficult to manage the case of "setfiles -s".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
