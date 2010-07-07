Date: Thu, 8 Jul 2010 09:30:08 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, hch@infradead.org,
        viro@zeniv.linux.org.uk, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] NFSv4: Add label recommended attribute and NFSv4
 flags
In-Reply-To: <20100707170058.GD28815@fieldses.org>
Message-ID: <alpine.LRH.2.00.1007080928180.14102@tundra.namei.org>
References: <1278513086-23964-1-git-send-email-dpquigl@tycho.nsa.gov> <1278513086-23964-7-git-send-email-dpquigl@tycho.nsa.gov> <20100707170058.GD28815@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Jul 2010, J. Bruce Fields wrote:

> On Wed, Jul 07, 2010 at 10:31:22AM -0400, David P. Quigley wrote:
> 
> > +#define NFS4_MAXLABELLEN	4096
> 
> Idle curiosity--why 4096?  (Why couldn't it be 16?  And how do we know
> people will never want 8192?)

I think I raised this a while back, too.

The maximum security label size on Linux is:

#define XATTR_SIZE_MAX 65536

Why arbitrarily limit this over the network?

Someone could have a valid local security label which can't be conveyed 
via NFS.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
