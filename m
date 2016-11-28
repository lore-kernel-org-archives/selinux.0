Subject: Re: [PATCH 1/2 v2] libsepol/cil: Add ability to write policy.conf
 file from CIL AST
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <1479842296-21906-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1479842296-21906-2-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7==PJJXUZsFiF3QdqeYJj9Lr5BamgM_x+ok=VuWnVMPQsw@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <42b8fc03-c5e5-b74f-9e9a-b00a6455d267@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 14:15:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==PJJXUZsFiF3QdqeYJj9Lr5BamgM_x+ok=VuWnVMPQsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2016 03:55 PM, Nicolas Iooss wrote:
> On Tue, Nov 22, 2016 at 8:18 PM, James Carter <jwcart2@tycho.nsa.gov
> <mailto:jwcart2@tycho.nsa.gov>> wrote:
>
>     The ability to create a policy.conf file from the CIL AST has been
>     a desire from the beginning to assist in debugging and for general
>     flexibility. Some work towards this end was started early in CIL's
>     history, but cil_policy.c has not been remotely functional in a long
>     time. Until now.
>
>     The function cil_write_policy_conf() will write a policy.conf file
>     from a CIL AST after cil_build_ast(), cil_resolve_ast(),
>     cil_fqn_qualify(), and cil_post_process() have been called.
>
>
> Hello,
> When building with clang and some warning flags, this commit introduces some
> warnings (treated as errors because of -Werror). These warnings are not reported
> by gcc, which compiles everything fine.
>
> First, there are many:
> ../cil/src/cil_policy.c:867:21: error: variable 'aliases' may be uninitialized
> when used here [-Werror,-Wconditional-uninitialized]
>                                 cil_list_append(aliases, CIL_SENSALIAS, alias);
>                                                 ^~~~~~~
>
> This is because the compiler is not smart enough to find the link between
> num_aliases and aliases and that cil_list_init() never returns if it failed to
> allocate "aliases". Could you please initialize aliases to NULL on lines 867,
> 907 and 1025 and roles on line 1588, as well as first and last to zero
> in cil_xperms_to_policy()?
>

I will add initializations for these.

> Secondly:
> ../cil/src/cil_policy.c:1132:28: error: format specifies type 'unsigned short'
> but the argument has type 'unsigned int' [-Werror,-Wformat]
>                                 fprintf(out, " 0x%hx", first);
>                                                  ~~~   ^~~~~
>                                                  %x
>
> Why is "h" prefix used to format variables of type "int"?
>

It shouldn't. I copied code from module_to_cil.c which was printing uint16_t 
variables.

Jim

> The full compiler output is available
> in https://travis-ci.org/fishilico/selinux/jobs/178096652 .
>
> Nicolas
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
