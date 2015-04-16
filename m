Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3GJuV3s011224
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 15:56:31 -0400
Received: by wiun10 with SMTP id n10so109994259wiu.1
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 12:56:29 -0700 (PDT)
Received: from pcx.lan (host30-118-static.58-79-b.business.telecomitalia.it.
 [79.58.118.30])
 by mx.google.com with ESMTPSA id hw7sm11700130wjb.24.2015.04.16.12.56.28
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2015 12:56:29 -0700 (PDT)
Message-ID: <553013EB.1070702@gmail.com>
Date: Thu, 16 Apr 2015 21:56:27 +0200
From: mm19827 <mm19827@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: selinux and thread local storage
References: <loom.20150414T202953-219@post.gmane.org>
In-Reply-To: <loom.20150414T202953-219@post.gmane.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Reposting with correct backtrace (hopefully)

On 04/14/2015 08:45 PM, mm19827 wrote:
> Hi all,
>
> I am trying to figure out something about Red Hat Bugzilla – Bug 1195074,
> where nvidia libGL.so.304.125 hangs in an endless loop when loaded by
> gnome-shell 3.14.
>
> Sequence is: gnome-shell loads libGL.so which for some reason calls
> is_selinux_enabled in libselinux.so at library load time, which runs into a
> spinlock within init_thread_destructor when accessing the thread-local
> variable destructor_initialized.
>
> gdb print of destructor_initialized reports:
> The inferior has not yet allocated storage for thread-local variables in the
> shared library `/lib64/libselinux.so.1'
>
> gdb backtrace is:
>
#0  0x0000003f12412495 in tls_get_addr_tail (ti=0x3509221f58, 
dtv=0x7ffff7f83390, the_map=0x7ffff7f9c000) at dl-tls.c:751
#1  0x000000350900af63 in getprocattrcon_raw () at procattr.c:73
#2  0x000000350900af63 in getprocattrcon_raw 
(context=context@entry=0x7fffffffd9f0, pid=pid@entry=0, 
attr=attr@entry=0x3509019e7b "current") at procattr.c:121
#3  0x000000350900b24e in getcon_raw_internal (c=c@entry=0x7fffffffd9f0) 
at procattr.c:334
#4  0x000000350900a6ce in is_selinux_enabled_internal () at enabled.c:26
#5  0x000000350d0a5c06 in  () at /lib64/libGL.so.1
#6  0x000000350d084c7b in  () at /lib64/libGL.so.1
#7  0x0000003f1240feed in call_init (l=0x7ffff7f999a8, 
argc=argc@entry=2, argv=argv@entry=0x7fffffffdc18, 
env=env@entry=0x7fffffffdc30) at dl-init.c:62
#8  0x0000003f1241003b in _dl_init (env=<optimized out>, argv=<optimized 
out>, argc=<optimized out>, l=<optimized out>) at dl-init.c:34
#9  0x0000003f1241003b in _dl_init (main_map=0x3f12623148, argc=2, 
argv=0x7fffffffdc18, env=0x7fffffffdc30) at dl-init.c:124
#10 0x0000003f12400d2a in _dl_start_user () at /lib64/ld-linux-x86-64.so.2
#11 0x0000000000000002 in  ()
#12 0x00007fffffffdfdd in  ()
#13 0x00007fffffffdff2 in  ()
#14 0x0000000000000000 in  ()

This occurs at library load time, so before getting to main().
Additional note is that I have this problem with gnome-shell, but many 
other executables (including gnome-session, glxinfo, glxgears) load 
libGL.so.304.125 and run just fine.

This problem is similar to the one described in
http://marc.info/?t=142252697100003&r=1&w=2
although in my case what unlocks the spinlock is to do LD_PRELOAD for 
libGL.so.

What makes it difficult here is that nvidia libGL.so.304.125 is closed 
source, and that also loads some libnvidia-tls.so which sounds like 
being involved with tls (no response from nvidia yet), so not much 
really clear, but I posted this in case it may suggest anything between 
selinux and tls.
