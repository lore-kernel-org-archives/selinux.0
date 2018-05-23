Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NMIqZJ010829
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 18:18:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so30240063qtp.11
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 15:18:49 -0700 (PDT)
Date: Wed, 23 May 2018 18:18:45 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Message-ID: <20180523221845.GB23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-2-kent.overstreet@gmail.com>
 <20180523112823.GA19987@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523112823.GA19987@bombadil.infradead.org>
Subject: Re: [PATCH 2/6] proc: commit to genradix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 23, 2018 at 04:28:23AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> > @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> >  	unsigned long nr_files, pos, i;
> > -	struct flex_array *fa = NULL;
> > -	struct map_files_info info;
> > +	GENRADIX(struct map_files_info) fa;
> >  	struct map_files_info *p;
> >  	int ret;
> >  
> > +	genradix_init(&fa);
> 
> Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?

Already exists. I kind of prefer not to use it when I don't need to though, and
stick to things that look more like normal declarations instead.
