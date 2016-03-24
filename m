Subject: Re: strange pam_selinux behavior
To: Dominick Grift <dac.override@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <56F3EBEF.7050808@redhat.com>
Date: Thu, 24 Mar 2016 14:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <56F3EA88.1020703@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/24/2016 02:24 PM, Dominick Grift wrote:
> On 03/24/2016 02:14 PM, Miroslav Grepl wrote:
> 
> <snip>
> 
>>>
>>> added the access vector back in but that seems to not make any
>>> differenc e.
> 
>> So you are still getting the same error message, right?
> 
> 
> not quite right:
> 
> It now longer shows this: "Failed to translate security class context"
> 
> So that part seems to have been fixed by adding the access vector
> 
> however this error is still the same:
> 
>> pam_selinux(sshd:session): Security context
>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 is not allowed for
>> wheel.id:wheel.role:wheel.s ubj:s0-s0:c0.c1023 Mar 24 13:43:03 void
>> sshd[14723]: pam_selinux(sshd:session): Unable to get valid context
>> for kcinimod
> 
> So looking at the code:
> 
>> src_context = context_new (src); dst_context = context_new (dst); 
>> context_range_set(dst_context, context_range_get(src_context)); if
>> (debug) pam_syslog(pamh, LOG_NOTICE, "Checking if %s mls range
>> valid for  %s", dst, context_str(dst_context));
> 
>> retval = security_compute_av(context_str(dst_context), dst, class,
>> bit, &avd); context_free(src_context); context_free(dst_context); 
>> if (retval || ((bit & avd.allowed) != bit)) return 0;
> 
>> return 1;
> 
> it appears that security_compute_av returns bad. But i can't figure
> out how to reproduce that with "compute_av":
> 
> # compute_av wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023
> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 process
> 
> allowed = { fork sigchld sigkill signull signal getsched setsched
> setpgid getattr setfscreate }
> 
> This works fine with stock fedora policy BTW. this seems to be a DSSP
> specific issue. I am wondering if my policy has a bug somewhere...

That's my point. If it is a bug in your policy or there is a bug related
to CIL. I can try to install your DSSP policy and check it.

> 
> 
> 

-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
