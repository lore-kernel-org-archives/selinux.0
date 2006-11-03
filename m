From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162561291.5635.64.camel@lade.trondhjem.org> 
References: <1162561291.5635.64.camel@lade.trondhjem.org>  <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
        chrisw@sous-sol.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
Date: Fri, 03 Nov 2006 15:33:18 +0000
Message-ID: <23076.1162567998@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> No. I was thinking of keeping the cache on its own partition

That's a requirement I am specifically avoiding with CacheFiles.  I might, for
instance, want to use it on my laptop, and I don't really have enough space to
set aside a partition just for that.  The whole point of CacheFiles is that
you don't have to set one aside.  If you're going to do that, then CacheFS
should be a better option.

> and using kernel mounts. cachefilesd could possibly mount the thing in its
> own private namespace.

That's still user visible, and SELinux in enforcing mode would still apply.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
