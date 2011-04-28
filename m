Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3SFRQuc006360
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 11:27:26 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3SFROua017833
	for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2011 15:27:25 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <201104220225.p3M2PjJR020777@www262.sakura.ne.jp>
References: <201104220225.p3M2PjJR020777@www262.sakura.ne.jp> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk> <20110421143114.31318.3353.stgit@warthog.procyon.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, serge.hallyn@canonical.com, eparis@redhat.com
Subject: Re: [PATCH 8/9] LSM: Pass linux_binprm pointer to open_exec() so creds are available
Date: Thu, 28 Apr 2011 16:27:12 +0100
Message-ID: <21236.1304004432@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> 819         struct linux_binprm bprm;
> 
> Here bprm is allocated from stack memory without initialization
> whereas bprm in do_execve() is allocated using kzalloc().

That's true; most of it doesn't need initialisation, but some bits of it do -
but aren't initialised here.  Not only that, it's quite a large struct, so
probably shouldn't be on the stack anyway - especially in NOMMU mode.

Anyway, I've posted a patch independent of this patch series to fix this.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
