From: David Howells <dhowells@redhat.com>
In-Reply-To: <455B53C7.1060604@mentalrootkit.com> 
References: <455B53C7.1060604@mentalrootkit.com>  <XMMS.LNX.4.64.0611151115360.8593@d.namei> <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> <26860.1163607813@redhat.com> 
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
Date: Wed, 15 Nov 2006 18:21:57 +0000
Message-ID: <1796.1163614917@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:

> > and the race in which the rules might change is still a
> > possibility I have to deal with.
> 
> I don't think this is a race, it is revocation of access. If you check the
> access at every operation and correctly deal with access failures, then this
> shouldn't be a problem. Yes it is a pain, but that is how SELinux is supposed
> to work.

Yes, but what is the correct method of dealing with a failure?  All I can think
of is to SIGKILL the process.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
