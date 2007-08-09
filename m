Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79IBAbX026806
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:11:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79IB9k4022148
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:11:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79IB4bW003904
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:11:04 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79IB3I4010503
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:11:04 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79IB3jl021054
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 19:11:03 +0100
From: David Howells <dhowells@redhat.com>
In-Reply-To: <830177.29212.qm@web36605.mail.mud.yahoo.com>
References: <830177.29212.qm@web36605.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] CacheFiles: Permit a process's create SID to be overridden [try #2]
Date: Thu, 09 Aug 2007 19:07:42 +0100
Message-ID: <20954.1186682862@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> This is SELinux specific funtionality and should be done in the
> SELinux code. You should not be adding interfaces that are SELinux
> specific, in this case using secids instead of the LSM blob interfaces.

Is using secids your only objection?  Or are you objecting to the whole
'act-as' concept?

David


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
