Message-ID: <535515F9.1040507@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 08:58:33 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Rastislav Hepner <rastislav.hepner@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: LIbselinux: Correctness of context decision, how its made?
References: <CAHjP7BFiN5GjUwDfceL9uJdOMwBFQz68ra7=M8yyRGBsKHLxsw@mail.gmail.com>
In-Reply-To: <CAHjP7BFiN5GjUwDfceL9uJdOMwBFQz68ra7=M8yyRGBsKHLxsw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2014 04:48 PM, Rastislav Hepner wrote:
> Hello guys,
> 
> I'm doing research regarding testing of some libselinux functions via
> python bindings.
> I just got stucked on logic, which is behind exception:
> 
> OSError: [Errno 22] Invalid argument
> 
> after I'm calling it setfscreatecon_raw("wrongContext").
> I've tried to check setfscreatecon.c but i dont see anything related to it.
> and now im out of ideas where to find it.
> 
> Could you please direct me to this logic in some source file
>  or explain how the decision (whether context is right or not) is made?

In the libselinux source code, setfscreatecon_raw() is implemented in
libselinux/src/procattr.c.  Some macro magic generates the
setfscreatecon_raw(c) function that calls setprocattrcon_raw(c, 0,
"fscreate").  setprocattrcon_raw() opens
/proc/self/task/<tid>/attr/fscreate and writes the value to that pseudo
file.

In the kernel, this is handled by
linux/fs/proc/base.c:proc_pid_attr_write(), which ultimately calls the
security_setprocattr() LSM hook.  If using SELinux, this hook is
provided by linux/security/selinux/hooks.c:selinux_setprocattr().  The
context value is ultimately passed to security_context_to_sid() to
validate it and map it to a SELinux security identifier (SID).  If the
value is not a valid SELinux security context under the current policy,
then this will fail with EINVAL aka errno 22 or Invalid argument.  This
is the cause of your error above.
