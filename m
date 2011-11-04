Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Nov 2011 08:32:04 -0400
Message-ID: <1320409924.1015.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-11-04 at 11:16 +0100, Bhargava Shastry wrote:
> Hello,
> 
> I am trying to get SELinux running on an Android phone. I did
> successfully build the kernel with SELinux enabled and mounted
> selinuxfs on init. Now, I would like to port SELinux user-space tools
> for policy loading/management. I looked at sebusybox tool-set but ran
> into problems while compiling. My hunch is that header files related
> to File System extended attributes are missing in the bionic lib
> sources that Android builds on. Having said that I have patched the
> Android YAFFS FS with an Xattr patch and also configured the kernel
> accordingly.
> 
> I have sources of libselinux and libsepol checked out and am wondering
> how to go about building these libraries for Android. Any help in this
> regard would be much appreciated.

We have been working on enabling the use of SELinux in Android.  I gave
a talk on this topic at the Linux Security Summit in September; the
slides are available here:
http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf

You don't need much of the SELinux userspace on the device unless you
want to try to support modular policy on the device, which I wouldn't
recommend (at least in its current form).  You can just build the policy
on your build host using the build host's checkpolicy, which should be
available to you on most Linux distributions; I build on Fedora and
others have built my code on Ubuntu, both of which have checkpolicy
available.  So you don't need libsepol, checkpolicy, libsemanage, or
most of policycoreutils on the device. 

The only core SELinux userspace components that you need on the device
are a subset of libselinux (primarily the wrappers for the SELinux
kernel interfaces that you want to use on the device), and a subset of
the SELinux utilities (some of which you'll want to implement as init
built-ins because init.rc is interpreted and executed in-process by
init, not by exec'ing external programs except for starting services;
others you may want as additions to the Android toolbox so that you can
invoke them from an adb shell).  libselinux needs to be ported (i.e.
modified) and not just re-compiled for Android due to differences in its
libc (bionic vs glibc).

We plan to release our code once we have integrated SELinux with the
application layer access controls and can demonstrate a more complete
solution.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
