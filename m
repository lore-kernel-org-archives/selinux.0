Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FEreLa013524
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 10:53:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FEq0LY018276
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 14:52:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8FEq0sG018273
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 14:52:00 GMT
Subject: Re: Problem relabeling journalfile
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030915145004.GB8988@vnl.com>
References: <20030915145004.GB8988@vnl.com>
Content-Type: text/plain
Message-Id: <1063637616.13311.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 10:53:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 10:50, Dale Amon wrote:
> I've upgraded an ext2 to an ext3 file and while make relabeling
> I get an error message:
> 
> /usr/sbin/setfiles: unable to relabel /.journal to system_u:object_r:file_t
> 
> suggestions?

Add an entry for it to your file_contexts configuration with the special
notation "<<none>>" in place of the security context.  This tells
setfiles to ignore it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
