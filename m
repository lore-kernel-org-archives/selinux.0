Subject: Re: [PATCH 6/7] NFSv4: Client implementation of MAC Labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <11859985332803-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
	 <11859985332803-git-send-email-dpquigl@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 09:12:22 -0400
Message-Id: <1186060342.26901.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 16:02 -0400, David P. Quigley wrote:
> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> There are several places where recommended attributes are implemented in the
> NFSv4 client code. This patch adds two functions to encode and decode the secid
> recommended attribute which makes use of the LSM hooks added earlier. It also
> adds code to grab the label from the file attribute structures and encode the
> label to be sent back to the server. Even though the code is there to encode a
> label to be sent back to the server there does not appear to be an interface to
> use it yet.
> 
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  fs/nfs/inode.c   |   16 ++++++++++++++
>  fs/nfs/nfs4xdr.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/super.c   |   10 ++++++++
>  3 files changed, 87 insertions(+), 0 deletions(-)

> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index badd73b..4dc8943 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -648,6 +653,18 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
>  		}
>  		len += 4 + (XDR_QUADLEN(owner_grouplen) << 2);
>  	}
> +#ifdef CONFIG_NFS_V4_MAC
> +	if (iap->ia_valid & ATTR_MAC_LABEL) {
> +		security_secid_to_secctx(iap->ia_sid, &label, &label_len);
> +		if (label_len < 0) {
> +			printk(KERN_WARNING
> +					"nfs4: couldn't resolve sid %d to string\n",
> +					iap->ia_sid);
> +			/* XXX: Should we be going to an error label? */
> +		}

Need to check return value, not len.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
