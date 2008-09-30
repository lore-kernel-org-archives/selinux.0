Date: Tue, 30 Sep 2008 15:40:26 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 06/14] KConfig: Add KConfig entries for Labeled NFS
Message-ID: <20080930204026.GE21039@us.ibm.com>
References: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov> <1222707986-26606-7-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1222707986-26606-7-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting David P. Quigley (dpquigl@tycho.nsa.gov):
> This patch adds two entries into the fs/KConfig file. The first entry
> NFS_V4_SECURITY_LABEL enables security label support for the NFSv4 client while
> the second entry NFSD_V4_SECURITY_LABEL enables security labeling support on
> the server side.
> 
> Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  fs/Kconfig |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index abccb5d..47ffb42 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -1633,6 +1633,7 @@ config NFS_V4
> 
>  	  If unsure, say N.
> 
> +
>  config ROOT_NFS
>  	bool "Root file system on NFS"
>  	depends on NFS_FS=y && IP_PNP
> @@ -1644,6 +1645,15 @@ config ROOT_NFS
> 
>  	  Most people say N here.
> 
> +config NFS_V4_SECURITY_LABEL
> +	bool "Provide Security Label support for NFSv4 client"
> +	depends on NFS_V4 && SECURITY
> +	help
> +	  Say Y here if you want label attribute support for NFS version 4.

A little more here :)

"Say Y here if you want security label attribute support for NFS version
4.  Security labels allow security modules like SELinux and Smack to
label files to facilitate enforcement of their policies.

If you do not wish to enforce SELinux or Smack policies on NFSv4 files,
say N."

Or something...  the idea being to make it clear to anyone configuring
a new kernel whether they should say n or y.

> +
> +
> +	  If unsure, say N.
> +
>  config NFSD
>  	tristate "NFS server support"
>  	depends on INET
> @@ -1725,6 +1735,13 @@ config NFSD_V4
> 
>  	  If unsure, say N.
> 
> +config NFSD_V4_SECURITY_LABEL
> +	bool "Provide Security Label support for NFSv4 server"
> +	depends on NFSD_V4 && SECURITY
> +	help
> +	  If you would like to include support for label file attributes
> +	  over NFSv4, say Y here.
> +
>  config LOCKD
>  	tristate
> 
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
