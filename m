Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NMPIHY011448
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 18:25:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID15.oob.disa.mil (Postfix) with SMTP id 40rnBY6TMKz4KWLJ
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 22:24:53 +0000 (UTC)
Received: from USFB3CPA05_EEMSG_MP27.eemsg.mil (unknown [192.168.16.22])
 by USFBF3ID15.oob.disa.mil (Postfix) with ESMTP id 40rnBY4gPbz4KWKm
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 22:24:53 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id z75-v6so18812405qkb.6
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 15:24:32 -0700 (PDT)
Date: Wed, 23 May 2018 18:24:28 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <20180523222428.GC23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-4-kent.overstreet@gmail.com>
 <20180523123401.GB19987@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523123401.GB19987@bombadil.infradead.org>
Subject: Re: [PATCH 4/6] openvswitch: convert to genradix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 23, 2018 at 05:34:01AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:19PM -0400, Kent Overstreet wrote:
> > the new generic radix trees have a simpler API and implementation, and
> > no limitations on number of elements, so all flex_array users are being
> > converted
> 
> This doesn't really feel like it should be a flexarray / genradix user.
> It just wants to allocate a lot of buckets and use them.  Maybe kvmalloc
> is the right approach for this user of flexarray?

Yeah probably, or a rhashtable.

Now that you mention it, I think the md code should definitely be using kvmalloc
too.
