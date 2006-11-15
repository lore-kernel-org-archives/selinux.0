Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFGIqwp026370
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 11:18:52 -0500
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFGHDu5001878
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 16:17:14 GMT
Date: Wed, 15 Nov 2006 11:19:00 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <15153.1163593562@redhat.com>
Message-ID: <XMMS.LNX.4.64.0611151115360.8593@d.namei>
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
 <15153.1163593562@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Nov 2006, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > > +static u32 selinux_set_fscreate_secid(u32 secid)
> > ...
> > The ability to set this needs to be mediated via MAC policy.
> 
> There could a problem with that...  Is it possible for there to be a race?

Well, the value can be changed at any time, so you could be using a 
temporary fscreate value, or your new value could be overwritten 
immediately by writing to /proc/$$/attr/fscreate

I think we need to add a separate field for this purpose, which can only 
be written to via the in-kernel API and overrides fscreate.

> I have to call the function twice per cache op: once to set the file 
> creation security ID and once to restore it back to what it was.
> 
> However, what happens if I can't restore the original security ID (perhaps the
> rules changed between the two invocations)?  I can't let the task continue as
> it's now running with the wrong security...

Kill the task?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
