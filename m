Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NHOMr5016596
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 13:24:22 -0400
To: Kent Overstreet <kent.overstreet@gmail.com>, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
 willy@infradead.org, gregkh@linuxfoundation.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-6-kent.overstreet@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
Date: Wed, 23 May 2018 10:24:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180523011821.12165-6-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 6/6] Drop flex_arrays
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for the heads-up, Matthew!

On 05/22/2018 06:18 PM, Kent Overstreet wrote:
> All existing users have been converted to generic radix trees

Well, flex_arrays had a good run, and the new radix trees do look quite
a bit nicer.

Feel free to add my ack.
