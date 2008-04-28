Date: Tue, 29 Apr 2008 01:04:41 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Christoph Hellwig <hch@lst.de>
cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH]Introduce generalized hooks for getting and setting inode
 secctx.
In-Reply-To: <20080428060620.GA9902@lst.de>
Message-ID: <Xine.LNX.4.64.0804290104000.2081@us.intercode.com.au>
References: <1208969836-8129-1-git-send-email-dpquigl@tycho.nsa.gov>
 <Xine.LNX.4.64.0804280932520.17090@us.intercode.com.au> <20080428060620.GA9902@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Apr 2008, Christoph Hellwig wrote:

> On Mon, Apr 28, 2008 at 09:33:22AM +1000, James Morris wrote:
> > Cristoph, Casey -- any chance of getting ack or nack on this before the 
> > merge window closes?
> 
> No concernes about this patch, but as usual strong objections against
> introducing it without the actual user.

Ok, we might put them into a labeled-nfs tree rather than pushing them to 
mainline at this stage.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
