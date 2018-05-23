Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NBSdNN017930
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 07:28:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID08.oob.disa.mil (Postfix) with SMTP id 40rVdK4wQ2z3TWMV
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 11:28:37 +0000 (UTC)
Received: from USFB3CPA03_EEMSG_MP25.eemsg.mil (unknown [192.168.16.20])
 by USFBF3ID08.oob.disa.mil (Postfix) with ESMTP id 40rVdK1bM7z3TWMT
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 11:28:37 +0000 (UTC)
Date: Wed, 23 May 2018 04:28:23 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Message-ID: <20180523112823.GA19987@bombadil.infradead.org>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523011821.12165-2-kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/6] proc: commit to genradix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	unsigned long nr_files, pos, i;
> -	struct flex_array *fa = NULL;
> -	struct map_files_info info;
> +	GENRADIX(struct map_files_info) fa;
>  	struct map_files_info *p;
>  	int ret;
>  
> +	genradix_init(&fa);

Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?
