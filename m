Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NM7BAh010153
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 18:07:11 -0400
Received: by mail-qk0-f177.google.com with SMTP id c198-v6so374782qkg.12
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 15:06:41 -0700 (PDT)
Date: Wed, 23 May 2018 18:06:26 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, willy@infradead.org,
 gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
 linux-raid@vger.kernel.org
Message-ID: <20180523220626.GA23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-6-kent.overstreet@gmail.com>
 <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 23, 2018 at 10:24:18AM -0700, Dave Hansen wrote:
> Thanks for the heads-up, Matthew!

Sorry, I was just using scripts/get_maintainers, forgot to check the actual file
for the original author :)

> On 05/22/2018 06:18 PM, Kent Overstreet wrote:
> > All existing users have been converted to generic radix trees
> 
> Well, flex_arrays had a good run, and the new radix trees do look quite
> a bit nicer.
> 
> Feel free to add my ack.

Cool, thanks!
