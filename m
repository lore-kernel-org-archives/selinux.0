Message-ID: <55549412.1030902@tycho.nsa.gov>
Date: Thu, 14 May 2015 08:24:50 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: rajkumar <rajkumarmadhani@gmail.com>, Selinux@tycho.nsa.gov
Subject: Re: How to start SELinux on embedded device
References: <55544356.1050802@gmail.com>
In-Reply-To: <55544356.1050802@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2015 02:40 AM, rajkumar wrote:
> Hi I am Rajkumar new to SELinux.
> 
> 
> My Requirement is to start SELinux porting on Embedded device consists
> of ARM processor.
> Using linux kernel version is 3.0.35.
> I started reading The SELinux notebook 4th edition.
> Made some changes in .config like enabling SELinux in kernel.
> And what are the changes need to be done rootfs apart from DAC  and in
> kernel.
> 
> 
> Please provide guidelines.

There are at least two actively maintained examples of SELinux for
embedded that you can use as a guide:

1.  Android SELinux, developed originally by us and contributed to the
Android Open Source Project, included in Android 4.3 (permissive), 4.4
(enforcing for root daemons), and 5.0 (enforcing for all processes).
See http://seandroid.bitbucket.org/index.html.  Advantages:  Minimalist
port of the SELinux userspace to Android (small footprint, no python or
other scripting language dependency on the target, elimination of glibc
dependencies, small policy written from scratch for Android).  Actively
maintained by Google as part of Android.  Disadvantages:  A fork of the
SELinux userspace (although there is ongoing work to reduce the
divergence and possibly reunify the core userspace at least), and
specialized for Android so you'd have to adapt to OpenEmbedded or
whatever you are using as your base distribution.

2.  meta-selinux layer for Yocto, developed and maintained by others
(Wind River originally, I believe, and now by several other people).
See http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinux/.
Advantages:  A complete upstream SELinux userspace and refpolicy, tracks
upstream regularly.  Disadvantages:  Large footprint, all of the
dependencies associated with upstream selinux userspace in Linux
distributions although you could perhaps prune it.  There is a
packagegroup-selinux-minimal.bb that offers a smaller instantiation
without a python dependency I believe.

There have a number of other prior embedded SELinux efforts, but I don't
think any of them other than the two above are actively maintained or
publicly available.
