Date: Wed, 1 Aug 2007 20:21:21 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 2/7] VFS: Add sid field to iattr structure for notify_change
In-Reply-To: <11859985323116-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Pine.LNX.4.64.0708012019380.29184@us.intercode.com.au>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
 <11859985323116-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Aug 2007, David P. Quigley wrote:

>  	struct file	*ia_file;
> +	u32		ia_sid;

This should be called ia_secid, and conditionally compiled per some 
Kconfig parameter.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
