Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FFTpLa013972
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 11:29:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8FFTnn0025946
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 15:29:50 GMT
Date: Mon, 15 Sep 2003 16:29:48 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Problem relabeling journalfile
Message-ID: <20030915152948.GC8988@vnl.com>
References: <20030915145004.GB8988@vnl.com> <1063637616.13311.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063637616.13311.110.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Sep 15, 2003 at 10:53:36AM -0400, Stephen Smalley wrote:
> Add an entry for it to your file_contexts configuration with the special
> notation "<<none>>" in place of the security context.  This tells
> setfiles to ignore it.

Sorted. Thanks.

This might be a reasonable thing to add to standard the file_contexts:

#
# Journal files
/.journal	<<none>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
