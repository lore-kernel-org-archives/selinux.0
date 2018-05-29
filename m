Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4T1nm6t003564
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 21:49:49 -0400
Received: by mail-it0-f67.google.com with SMTP id p3-v6so16603990itc.0
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 18:48:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180526055601.GA26155@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
 <20180526055601.GA26155@kmo-pixel>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Tue, 29 May 2018 09:48:20 +0800
Message-ID: <CANQeFDBGzxF0r-+dxp5jcRnOCe8NgEzRgmc-84bGRBqiYg5KhA@mail.gmail.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, willy@infradead.org,
 gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
 linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/6] Generic radix trees
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 26, 2018 at 1:56 PM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
>> > +/*
>> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
>> > + * necessary - newly allocated slots are always zeroed out:
>> > + */
>> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>> > +                          gfp_t gfp_mask)
>> > +{
>> > +       struct genradix_node **n;
>>
>> Any reason that " struct genradix_node ** " is used here instead of "
>> struct genradix_node * "?
>>
>> Looks like this function only manipulates *n, am I missing something?
>
> It stores to *n, when it has to allocate a node (including the root)

I see, thanks for the explanation.

thanks,
liubo
