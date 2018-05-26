Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4Q5uAw8016514
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 01:56:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id g13-v6so9220711qth.8
 for <selinux@tycho.nsa.gov>; Fri, 25 May 2018 22:56:06 -0700 (PDT)
Date: Sat, 26 May 2018 01:56:01 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Liu Bo <obuil.liubo@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, willy@infradead.org,
 gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
 linux-raid@vger.kernel.org
Message-ID: <20180526055601.GA26155@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
Subject: Re: [PATCH 1/6] Generic radix trees
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
> > +/*
> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
> > + * necessary - newly allocated slots are always zeroed out:
> > + */
> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
> > +                          gfp_t gfp_mask)
> > +{
> > +       struct genradix_node **n;
> 
> Any reason that " struct genradix_node ** " is used here instead of "
> struct genradix_node * "?
> 
> Looks like this function only manipulates *n, am I missing something?

It stores to *n, when it has to allocate a node (including the root)
