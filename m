From: David Howells <dhowells@redhat.com>
In-Reply-To: <XMMS.LNX.4.64.0611141618300.25022@d.namei> 
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
        Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
Date: Wed, 15 Nov 2006 12:26:02 +0000
Message-ID: <15153.1163593562@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> wrote:

> > +static u32 selinux_set_fscreate_secid(u32 secid)
> ...
> The ability to set this needs to be mediated via MAC policy.

There could a problem with that...  Is it possible for there to be a race?  I
have to call the function twice per cache op: once to set the file creation
security ID and once to restore it back to what it was.

However, what happens if I can't restore the original security ID (perhaps the
rules changed between the two invocations)?  I can't let the task continue as
it's now running with the wrong security...

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
