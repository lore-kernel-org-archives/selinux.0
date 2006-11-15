From: David Howells <dhowells@redhat.com>
In-Reply-To: <6134.1163617750@redhat.com> 
References: <6134.1163617750@redhat.com>  <26860.1163607813@redhat.com> <XMMS.LNX.4.64.0611151115360.8593@d.namei> <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
        Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
Date: Wed, 15 Nov 2006 19:11:41 +0000
Message-ID: <6203.1163617901@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> I haven't removed the old fscreate overriding patch yet, not have I put in the
> error handling in CacheFiles.

that should read "... nor have I..."

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
