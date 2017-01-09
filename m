Message-ID: <1483995838.20858.98.camel@tycho.nsa.gov>
Subject: Re: checkpolicy: memory leak in declare_type()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 09 Jan 2017 16:03:58 -0500
In-Reply-To: <c603c6c8-6f29-c6dd-b9b9-2ca0ce38507c@m4x.org>
References: <c603c6c8-6f29-c6dd-b9b9-2ca0ce38507c@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-12-28 at 19:05 +0100, Nicolas Iooss wrote:
> Hello,
> 
> When building checkpolicy with gcc Address Sanitizer and using the
> result to compile refpolicy, some leaks are reported. I wrote a
> minimal
> policy which exposes one of the issues I am experiencing:
> 
> $ cat test.mod
> module test 1.0.0;
> require { role system_r; }
> optional {
> 	require { type sysadm_sudo_t; }
> }
> 
> optional {
> 	require { attribute sudodomain; }
> 	type sysadm_sudo_t, sudodomain;
> }
> 
> $ checkmodule -m test.mod -o test.mod
> checkmodule:  loading policy configuration from test.mod
> checkmodule:  policy configuration loaded
> checkmodule:  writing binary representation (version 17) to test.mod
> 
> =================================================================
> ==27309==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f5c7214ee60 in __interceptor_malloc
> /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:62
>     #1 0x40cb8c in declare_type
> /usr/src/selinux/checkpolicy/module_compiler.c:327
> 
> Direct leak of 14 byte(s) in 1 object(s) allocated from:
>     #0 0x7f5c7214ee60 in __interceptor_malloc
> /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:62
>     #1 0x413220 in insert_id
> /usr/src/selinux/checkpolicy/policy_define.c:120
> 
> SUMMARY: AddressSanitizer: 54 byte(s) leaked in 2 allocation(s).
> 
> 
> In the code, when checkpolicy parses "type sysadm_sudo_t,
> sudodomain;"
> it calls declare_type() to declare this new type. This function calls
> declare_symbol() [1], which returns 1 because the type has been
> previously required (require_symbol() added it to the policy hash
> tables).
> 
> However declare_symbol() comment states "For roles and users, it is
> legal to have multiple declarations; as such return 1 to indicate
> that
> caller must free() the datum because it was not added". This comment
> does not consider the case of a type which is declared after being
> required.
> 
> The reported leak is a consequence of this corner case. In
> declare_type(), variables id and typdatum are not freed when
> declare_symbol() returns 1 [3]. Moreover typdatum, which is the datum
> of
> the type which has NOT been inserted in the policy hashtables, is
> returned to declare_type's caller.
> 
> This seems buggy and it seems reasonable to copy what declare_role()
> [4]
> and declare_user() [5] do: create new type object in the current
> declaration scope. As I am not quite confident with this approach, is
> it
> something which would make sense?

Makes sense to me but I am not entirely sure about it either.

> 
> Cheers,
> Nicolas
> 
> [1]
> https://github.com/SELinuxProject/selinux/blob/checkpolicy-2.6/checkp
> olicy/module_compiler.c#L337
> [2]
> https://github.com/SELinuxProject/selinux/blob/checkpolicy-2.6/checkp
> olicy/module_compiler.c#L121
> [3]
> https://github.com/SELinuxProject/selinux/blob/checkpolicy-2.6/checkp
> olicy/module_compiler.c#L338
> [4]
> https://github.com/SELinuxProject/selinux/blob/checkpolicy-2.6/checkp
> olicy/module_compiler.c#L238
> [5]
> https://github.com/SELinuxProject/selinux/blob/checkpolicy-2.6/checkp
> olicy/module_compiler.c#L443
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
