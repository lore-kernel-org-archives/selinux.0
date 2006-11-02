From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162496968.6071.38.camel@lade.trondhjem.org> 
References: <1162496968.6071.38.camel@lade.trondhjem.org>  <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
Date: Thu, 02 Nov 2006 20:38:37 +0000
Message-ID: <32754.1162499917@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Just why are you doing all this? Why do we need a back-end that requires
> all this extra client-side security infrastructure in order to work? 

Well, both Christoph and Al are of the opinion that I should be using
vfs_mkdir() and co rather than bypassing the security and calling inode ops
directly.

Also I should be setting security labels on the files I create.

> IOW: What is wrong with the existing CacheFS?

Well, you did require it to be reviewed by Christoph...

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
