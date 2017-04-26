Message-ID: <1493231502.32540.12.camel@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] selinux: expose policy SHA256 checksum via selinuxfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
Date: Wed, 26 Apr 2017 14:31:42 -0400
In-Reply-To: <1493218936-18522-3-git-send-email-sbuisson@ddn.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-3-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-27 at 00:02 +0900, Sebastien Buisson wrote:
> Expose policy SHA256 checksum via selinuxfs.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  security/selinux/selinuxfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index ce71718..b2d5deb 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -30,6 +30,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/kobject.h>
>  #include <linux/ctype.h>
> +#include <crypto/sha.h>
>  
>  /* selinuxfs pseudo filesystem for exporting the security policy
> API.
>     Based on the proc code and the fs/nfsd/nfsctl.c code. */
> @@ -99,6 +100,7 @@ enum sel_inos {
>  	SEL_STATUS,	/* export current status using mmap() */
>  	SEL_POLICY,	/* allow userspace to read the in kernel
> policy */
>  	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
> +	SEL_POLICYCKSUM,/* return policy SHA256 checkum */
>  	SEL_INO_NEXT,	/* The next inode number to use */
>  };
>  
> @@ -313,6 +315,22 @@ static ssize_t sel_read_policyvers(struct file
> *filp, char __user *buf,
>  	.llseek		= generic_file_llseek,
>  };
>  
> +static ssize_t sel_read_policycksum(struct file *filp, char __user
> *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	size_t tmpbuflen = SHA256_DIGEST_SIZE*2 + 1;
> +	char tmpbuf[tmpbuflen];
> +	ssize_t length;
> +
> +	length = security_policydb_cksum(tmpbuf, tmpbuflen);
> +	return simple_read_from_buffer(buf, count, ppos, tmpbuf,
> length);
> +}

Should we also include information about the hash used, in case it
changes in the future?

> +
> +static const struct file_operations sel_policycksum_ops = {
> +	.read		= sel_read_policycksum,
> +	.llseek		= generic_file_llseek,
> +};
> +
>  /* declaration for sel_write_load */
>  static int sel_make_bools(void);
>  static int sel_make_classes(void);
> @@ -1825,6 +1843,8 @@ static int sel_fill_super(struct super_block
> *sb, void *data, int silent)
>  		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
>  		[SEL_VALIDATE_TRANS] = {"validatetrans",
> &sel_transition_ops,
>  					S_IWUGO},
> +		[SEL_POLICYCKSUM] = {"policycksum",
> &sel_policycksum_ops,
> +				     S_IRUGO},
>  		/* last one */ {""}
>  	};
>  	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
