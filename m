Message-ID: <553E8CA6.70404@tycho.nsa.gov>
Date: Mon, 27 Apr 2015 15:23:18 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Don't assume SELinux code is already installed on host
References: <1430162024-29420-1-git-send-email-nnk@google.com>
In-Reply-To: <1430162024-29420-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/27/2015 03:13 PM, Nick Kralevich wrote:
> Many parts of the SELinux userspace code appear to assume that there's
> already a pre-existing install of libselinux / selinux head files on the
> host. That may not be true if you're building SELinux for the first time.
> 
> Make the following modifications:
> 
> 1) SELinux header files should be referenced from the source tree,
> not from /usr/include.
> 2) *.a files should be referenced from the source tree, not from
> /usr/lib
> 3) #include statements should exactly match the path in the source
> tree.
> 
> This patch only addresses some of the issues found and testing has been
> extremely limited.
> 
> Signed-off-by: Nick Kralevich <nnk@google.com>

Hmmm...well, we don't assume it has been installed on the host; we just
assume that you are building as per selinux/README, i.e.
cd selinux && make DESTDIR=~/obj install
will correctly install to a private build directory specified via
DESTDIR and pick up the headers and libraries from there.

Using relative paths within the selinux source tree is problematic in
the other case since historically we have distributed individual
tarballs for each components and not the entire tree.  Actually, it was
the other way around originally but Red Hat wanted us to break it up
into separate tarballs for inclusion in separate packages in the Linux
distributions.
