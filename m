Date: Fri, 5 Dec 2008 21:00:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Matthew N. Dodd" <matthew.dodd@sparta.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, Labeled NFS <labeled-nfs@linux-nfs.org>
Subject: Re: [PATCH 14/14] NFSD: Server implementation of MAC Labeling
In-Reply-To: <1227733394-1114-15-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0812052046520.14142@tundra.namei.org>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov> <1227733394-1114-15-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2008, David P. Quigley wrote:

> +	err = 0;
> +	(void)security_inode_getsecctx(dentry->d_inode, &context, &len);
> +	if (len < 0)
> +		return nfserrno(len);

So, with the simpler version:

	err = security_inode_getsecctx(dentry->d_inode, &context, &len);
	if (err)
		return nfserrno(err);




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
