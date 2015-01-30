Message-ID: <54CBAC62.6030708@tycho.nsa.gov>
Date: Fri, 30 Jan 2015 11:08:02 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Stefano Borini <stefano.borini@quantumwise.com>, selinux@tycho.nsa.gov
Subject: Re: spinlock in centos 6.4 and redhat enterprise 6 using chcon
References: <54CA07EC.5090403@quantumwise.com>
In-Reply-To: <54CA07EC.5090403@quantumwise.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/29/2015 05:14 AM, Stefano Borini wrote:
> Good morning,
> 
> I am encountering what seems to be a spinlock with the chcon utility
> trying the following operation
> 
> chcon -t texrel_shlib_t /tmp/subdir/withheldpath
> 
> where withheld path is a .so that is going to be accessed with dlopen.
> I am not invoking the chcon command directly nor performing the dlopen,
> a closed-source library does that, apparently to prepare the .so for
> dlopening.
> 
> Note that if I try the same operation from the command line, even while
> the spinlock is in progress, no lock occurs.
> 
> I am unable to understand the details of what may cause this spinlock.
> This is the backtrace of chcon, apparently involving some thread local
> storage
> 
> #0  0x0000003e3ea00b64 in rtld_lock_default_lock_recursive () from
> /lib64/ld-linux-x86-64.so.2
> #1  0x0000003e3ea11257 in tls_get_addr_tail () from
> /lib64/ld-linux-x86-64.so.2
> #2  0x0000003e3ea11660 in __tls_get_addr () from
> /lib64/ld-linux-x86-64.so.2
> #3  0x0000003e40a14334 in selinux_raw_to_trans_context () from
> /lib64/libselinux.so.1
> #4  0x0000003e40a0ca7a in getfilecon () from /lib64/libselinux.so.1
> 
> Checking the tls_get_addr_tail function, it is apparently stuck in the
> again: loop
> 
> http://code.woboq.org/userspace/glibc/elf/dl-tls.c.html#742
> 
> I have only access to the centos 6.4 and can run additional
> non-destructive tests if needed. It's a customer machine so I am unable
> to say if modifications have been done to it when it comes to security,
> although I suspect it's a standard centos6.4 installation with selinux
> enabled.
> 
> The current ls -Z of /tmp gives
> 
> system_u:object_r:tmp_t:s0
> 
> of subdir and of the so file is
> 
> unconfined_u:object_r:user_tmp_t:s0
> 
> Thank you for your help.

libselinux version?
