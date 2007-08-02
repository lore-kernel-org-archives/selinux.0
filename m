Date: Wed, 1 Aug 2007 20:24:32 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 3/7] KConfig: Add KConfig entries for MAC labeled NFS
In-Reply-To: <118599853274-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Pine.LNX.4.64.0708012023340.29184@us.intercode.com.au>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
 <118599853274-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Aug 2007, David P. Quigley wrote:

> This patch adds two entries into the fs/KConfig file. The first entry
> NFS_V4_MAC enables MAC labeling support to the NFSv4 client while the second
> entry NFSD_V4_MAC enables MAC labeling support on the server side.

> +	depends on NFS_V4 && SECURITY_SELINUX

I think you want these as

	depends on NFS_V4 && SECURITY



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
