From: Paul Moore <paul.moore@hp.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access LSM security context information.
Date: Wed, 5 Mar 2008 15:45:24 -0500
Cc: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, hch@lst.de, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov> <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051545.25143.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 05 March 2008 1:54:48 pm David P. Quigley wrote:
> This patch introduces two new hooks. One to get all relevant
> information from an LSM about an inode an the second given that
> context to set it on the inode. The setcontext call takes a flag to
> indicate if it should set the incore representation, the ondisk
> representation or both. This hook is for use in the labeled NFS code
> and addresses concerns of how to set security on an inode in a
> multi-xattr LSM.
>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  include/linux/security.h |   18 ++++++++++++++++++
>  security/dummy.c         |   12 ++++++++++++
>  security/security.c      |   12 ++++++++++++
>  security/selinux/hooks.c |   31 ++++++++++++++++++++++++++++++-
>  4 files changed, 72 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fe52cde..bb71ac9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -112,6 +112,10 @@ struct request_sock;
>  #define LSM_UNSAFE_PTRACE	2
>  #define LSM_UNSAFE_PTRACE_CAP	4
>
> +/* Flags for setsecctx */
> +#define LSM_SETCORE	1
> +#define LSM_SETDISK	2
> +
>  #ifdef CONFIG_SECURITY
>
>  /**
> @@ -1395,6 +1399,9 @@ struct security_operations {
>  	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>
> +	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32
> ctxlen, int flags);
> +	int (*inode_getsecctx)(struct dentry *dentry, 
> void **ctx, u32 *ctxlen);

Not a terribly big deal, but I liked James' suggestion of 'file_<blah>' 
instead of 'inode_<blah>'.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
