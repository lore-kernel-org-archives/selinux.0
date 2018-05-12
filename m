Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4CFkFd7001280
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 11:46:15 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so10988902qtn.3
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 08:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <1526129620.28749.19.camel@cepl.eu>
In-Reply-To: <1526129620.28749.19.camel@cepl.eu>
From: Neal Gompa <ngompa13@gmail.com>
Date: Sat, 12 May 2018 11:45:35 -0400
Message-ID: <CAEg-Je-1+e-YYT84QGEw8je+1rUUpuQkAr+E1yzkxU8n6O-9aA@mail.gmail.com>
To: mcepl@cepl.eu
Cc: selinux-devel@alioth-lists.debian.net,
 SELinux List at Fedora Project <selinux@lists.fedoraproject.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Packaging policycoreutils for OpenSUSE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 12, 2018 at 8:53 AM Matěj Cepl <mcepl@cepl.eu> wrote:

> Hi,

> I am changing jobs (Red Hat -> SUSE; R&D, but not a security
> related job), and although I will be switching my workstation to
> OpenSUSE, I would love to keep SELinux working. Which meant I had
> to dig into the current situation of SELinux and it is … not
> good. So, I started to repackage all SELinux packages 2.7 for
> OpenSUSE in my home build area
> https://build.opensuse.org/project/show/home:mcepl:SELinux
> . So,far I have packaged successfully packages for libselinux,
> libselinux-bindings, checkpolicy, libsemanage, libsepol, and
> python-semanage. Mostly I use original OpenSUSE packages for 2.6,
> but if needed I seek inspiration in Fedora packages.

> Unfortunately, I have trouble to package policycoreutils. First
> of all, I don’t understand what’s the difference between two
> upstream tarballs for it:
> https://github.com/SELinuxProject/selinux/archive/policycoreutils
> -2.7.tar.gz
> (linked from https://github.com/SELinuxProject/selinux/releases)
> and
> https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/fil
> es/releases/20170804/policycoreutils-2.7.tar.gz
> (linked from
> https://github.com/SELinuxProject/selinux/wiki/Releases). What’s
> the point of confusing users with two different tarballs of the
> same name?

> Second, I don’t understand the behavior of the installation
> scripts. Looking at https://is.gd/MivaE1 , why in the world that
> installation scripts tons of stuff which is not part of
> policycoreutils? Could anybody help me to get through this
> obstacle, please?


As the SELinux stack maintainer in Mageia, I've been through the same song
and dance, and I can answer your questions.

For your first question about the tarballs: The SELinux userspace is a
monorepo, so the git tag archives actually contain all the content at
seemingly random checkpoints. As a consequence of this, the upstream
project has to create the tarballs themselves of the components and upload
them. You _must_ use the the tarball from the Releases page, rather than
the archive ones. This leads directly into the confusion for the second
question. Please don't use the GitHub archive URLs as they lead to weird
things like this.


-- 
真実はいつも一つ！/ Always, there's only one truth!
