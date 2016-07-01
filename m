Subject: Re: [BUG libselinux] Use nftw() instead of fts()
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 selinux@tycho.nsa.gov
References: <20160701105328.6faa126f@free-electrons.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <462d0e88-db82-80e3-b109-fb1f48f49167@tycho.nsa.gov>
Date: Fri, 1 Jul 2016 09:17:58 -0400
MIME-Version: 1.0
In-Reply-To: <20160701105328.6faa126f@free-electrons.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/2016 04:53 AM, Thomas Petazzoni wrote:
> Hello,
> 
> The recent versions of libselinux use the fts() function in
> src/selinux_restorecon.c. This function is BSD-only, and therefore not
> available in the musl C library, and only available optionally in the
> uClibc C library.
> 
> Would it be possible to use instead the POSIX-compliant nftw()
> function, which provides the same functionality?
> 
> In addition, using fts() is problematic, as on glibc versions <= 2.22,
> it is incompatible with large file support.

selinux userspace has been using fts() since 2009 (commit
cce17290670ed7e1803ca6da660225ac01931d0c), when policycoreutils/setfiles
was converted from nftw() to fts().  libselinux usage is newer, but
src/selinux_restorecon.c is essentially a library function version of
setfiles.

Not saying that it would be impossible to switch (back) to nftw(), but I
guess we'd have to understand the cost/benefit tradeoff there.  If fts()
isn't available or well supported, why hasn't this previously been an
issue for policycoreutils/setfiles?
