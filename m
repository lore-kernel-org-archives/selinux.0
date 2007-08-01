Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71L3wVg030120
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 17:03:58 -0400
Received: from web36609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l71L3vdm010885
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 21:03:57 GMT
Date: Wed, 1 Aug 2007 14:03:57 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 2/7] VFS: Add sid field to iattr structure for notify_change
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985323116-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <158594.39342.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> Since NFSv4 likes to directly modify fields in the incore inode we need a way
> to inform notify_change that the secid for the inode has changed. This patch
> adds a flag for notify_change and a field into the iattr struct to allow us
> to
> persist incore inode changes to disk.
> 
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  include/linux/fs.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d33bead..f5d324b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -330,6 +330,7 @@ typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t
> offset,
>  #define ATTR_KILL_SUID	2048
>  #define ATTR_KILL_SGID	4096
>  #define ATTR_FILE	8192
> +#define ATTR_MAC_LABEL  16384
>  
>  /*
>   * This is the Inode Attributes structure, used for notify_change().  It
> @@ -356,6 +357,7 @@ struct iattr {
>  	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
>  	 */
>  	struct file	*ia_file;
> +	u32		ia_sid;

void *ia_blob;

so as not to be dependent on u32 labels.

>  };
>  
>  /*
> -- 
> 1.5.2.2
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
