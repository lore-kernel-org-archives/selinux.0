Message-ID: <5531020E.4060005@tycho.nsa.gov>
Date: Fri, 17 Apr 2015 08:52:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, mm19827 <mm19827@gmail.com>,
 SELinux@tycho.nsa.gov
Subject: Re: selinux and thread local storage
References: <loom.20150414T202953-219@post.gmane.org>
 <552D7133.1040503@tycho.nsa.gov> <552E9F06.9070002@redhat.com>
In-Reply-To: <552E9F06.9070002@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2015 01:25 PM, Daniel J Walsh wrote:
> 
> On 04/14/2015 03:57 PM, Stephen Smalley wrote:
>> On 04/14/2015 02:45 PM, mm19827 wrote:
>>> Hi all,
>>>
>>> I am trying to figure out something about Red Hat Bugzilla – Bug 1195074,
>>> where nvidia libGL.so.304.125 hangs in an endless loop when loaded by
>>> gnome-shell 3.14.
>>>
>>> Sequence is: gnome-shell loads libGL.so which for some reason calls
>>> is_selinux_enabled in libselinux.so at library load time, which runs into a
>>> spinlock within init_thread_destructor when accessing the thread-local
>>> variable destructor_initialized.
>>>
>>> gdb print of destructor_initialized reports:
>>> The inferior has not yet allocated storage for thread-local variables in the
>>> shared library `/lib64/libselinux.so.1'
>>>
>>> gdb backtrace is:
>>>
>>> #0  0x0000003f12412495 in tls_get_addr_tail (ti=0x3509221f58,
>>> dtv=0x7ffff7f83390, the_map=0x7ffff7f9c000)
>>>     at dl-tls.c:751
>> Perhaps we could address this simply by changing is_selinux_enabled() to
>> use a private or inlined version of getcon_raw() that does not try to
>> cache the result and therefore does not rely on tls?
>>
>>
> I would be fine with that.

Actually, could we just drop the test altogether of whether getcon()
returns "kernel", i.e. no-policy-loaded?  IIRC, this is a leftover of
Fedora Core 2 days, before we had support for SELinux runtime disable,
so that we could emulate SELinux disabled by just not loading a policy.
 But these days SELinux can be disabled either via SELINUX=disabled in
/etc/selinux/config or selinux=0 and either way selinuxfs is
unregistered and /sys/fs/selinux is unmounted, so we should not need
this test anymore AFAICS.
