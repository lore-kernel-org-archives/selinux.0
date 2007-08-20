From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LFD.0.999.0708161550140.30176@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708161550140.30176@woody.linux-foundation.org> <29015.1187178055@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, sds@tycho.nsa.gov,
        casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: Adding a security parameter to VFS functions
Date: Mon, 20 Aug 2007 13:09:52 +0100
Message-ID: <11466.1187611792@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Would you object greatly to functions like vfs_mkdir() gaining a security
> > parameter?  What I'm thinking of is this:
> ...
> Why the *hell* would mkdir() be so magical as to need something like that?

If you look again, you'll notice that I said "functions like vfs_mkdir()".  I
was I using vfs_mkdir() as an example.  I didn't mean to apply this to
directory creation only.  It would need to apply to all the vfs_*() entry
points called by nfsd and cachefiles.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
