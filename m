Message-ID: <552D7133.1040503@tycho.nsa.gov>
Date: Tue, 14 Apr 2015 15:57:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: mm19827 <mm19827@gmail.com>, SELinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: selinux and thread local storage
References: <loom.20150414T202953-219@post.gmane.org>
In-Reply-To: <loom.20150414T202953-219@post.gmane.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/14/2015 02:45 PM, mm19827 wrote:
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
> #0  0x0000003f12412495 in tls_get_addr_tail (ti=0x3509221f58,
> dtv=0x7ffff7f83390, the_map=0x7ffff7f9c000)
>     at dl-tls.c:751

Perhaps we could address this simply by changing is_selinux_enabled() to
use a private or inlined version of getcon_raw() that does not try to
cache the result and therefore does not rely on tls?
