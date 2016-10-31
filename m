Subject: Re: State of rpm_execcon SWIG wrapper
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <22209650-ddac-d265-6928-43896a0a26cb@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c47fb4a7-a087-274c-43d2-35f8fde0421b@tycho.nsa.gov>
Date: Mon, 31 Oct 2016 09:22:40 -0400
MIME-Version: 1.0
In-Reply-To: <22209650-ddac-d265-6928-43896a0a26cb@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/30/2016 05:05 PM, Nicolas Iooss wrote:
> Hello,
> 
> While testing a few things on the SWIG wrappers (like compiling them
> with clang and a bunch of warnings), I got the following warning:
> 
>     selinuxswig_wrap.c:12253:11: error: variable 'arg4' is uninitialized
>     when used here [-Werror,-Wuninitialized]
>             while(arg4[i]) {
>                   ^~~~
> 
> After digging a little bit, I find out that the following command (which
> does an invalid call to rpm_execon wrapper) triggers a segmentation
> fault on my system:
> 
>     python -c 'import selinux;selinux.rpm_execcon()'
> 
> This bug can be fixed by adding some magic to selinuxswig_python.i (for
> example "%typemap(arginit) char * const [] { $1 = NULL; }" and a few
> more things). After this I found two other issues in this wrapper:
> 
>   * The size of the buffer which is allocated to copy argv and envp is
> too small: the code uses "malloc(size + 1)" instead of "calloc(size + 1,
> sizeof(char *))" [1]. This makes some valid call to
> selinux.rpm_execcon() overflow a memory block allocated on the heap.
>   * The memory allocated with this malloc is leaked if one argument of
> rpm_execon is not a sequence of bytes [2]. Replacing the "return NULL;"
> with "SWIG_fail;" can fix this issue.
> 
> Instead of writing patches to fix all these bugs, I am wondering whether
> anyone is still using this interface, which has been deprecated since
> 2012 [3] and which can be removed at compile-time by using
> "DISABLE_RPM=y". Is this interface going to be removed soon? Or is it
> worth spending time to fix it?

I would be fine with removing the SWIG wrapper for it entirely upstream,
since I am unaware of any users of that.  If your distribution is not
using a version of rpm that calls rpm_execcon (i.e. you have rpm >=
4.12), you are encouraged to also build libselinux with DISABLE_RPM=y to
remove it altogether (current Fedora does this, but not the most recent
RHEL).  I'm not sure we can do that upstream by default or remove the
code altogether without changing soname since it would be an ABI break,
and breaking rpm itself would be rather bad if someone were to install
modern libselinux on an older rpm-based distribution.

> 
> Cheers,
> Nicolas
> 
> [1]
> https://github.com/SELinuxProject/selinux/blob/libselinux-2.6/libselinux/src/selinuxswig_python.i#L171
> [2]
> https://github.com/SELinuxProject/selinux/blob/libselinux-2.6/libselinux/src/selinuxswig_python.i#L177
> [3]
> https://github.com/SELinuxProject/selinux/commit/a2737333c795cae2aa4e31deed95a8e155d64d4a
