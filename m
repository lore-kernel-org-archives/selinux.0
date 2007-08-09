Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79HsVq0025211
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:31 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79HsUk4017924
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:54:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79HsTQA024189
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:29 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79HsSjo002420
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:54:28 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79HsS7J020647
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:54:28 +0100
Date: Thu, 9 Aug 2007 10:04:56 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 09/14] CacheFiles: Permit a process's create SID to be overridden [try #2]
To: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070809160525.17906.35400.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <830177.29212.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Make it possible for a process's file creation SID to be temporarily
> overridden
> by CacheFiles so that files created in the cache have the right label
> attached.
> 
> Without this facility, files created in the cache will be given the current
> file creation SID of whatever process happens to have invoked CacheFiles
> indirectly by means of opening a netfs file at the time the cache file is
> created.

This is SELinux specific funtionality and should be done in the
SELinux code. You should not be adding interfaces that are SELinux
specific, in this case using secids instead of the LSM blob interfaces.


Casey Schaufler
casey@schaufler-ca.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
