MIME-Version: 1.0
In-Reply-To: <1479842296-21906-2-git-send-email-jwcart2@tycho.nsa.gov>
References: <1479842296-21906-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1479842296-21906-2-git-send-email-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 22 Nov 2016 21:55:18 +0100
Message-ID: <CAJfZ7==PJJXUZsFiF3QdqeYJj9Lr5BamgM_x+ok=VuWnVMPQsw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] libsepol/cil: Add ability to write policy.conf
 file from CIL AST
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114118a07c29070541e9fdf1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114118a07c29070541e9fdf1
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 22, 2016 at 8:18 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> The ability to create a policy.conf file from the CIL AST has been
> a desire from the beginning to assist in debugging and for general
> flexibility. Some work towards this end was started early in CIL's
> history, but cil_policy.c has not been remotely functional in a long
> time. Until now.
>
> The function cil_write_policy_conf() will write a policy.conf file
> from a CIL AST after cil_build_ast(), cil_resolve_ast(),
> cil_fqn_qualify(), and cil_post_process() have been called.


Hello,
When building with clang and some warning flags, this commit introduces
some warnings (treated as errors because of -Werror). These warnings are
not reported by gcc, which compiles everything fine.

First, there are many:
../cil/src/cil_policy.c:867:21: error: variable 'aliases' may be
uninitialized when used here [-Werror,-Wconditional-uninitialized]
                                cil_list_append(aliases, CIL_SENSALIAS,
alias);
                                                ^~~~~~~

This is because the compiler is not smart enough to find the link between
num_aliases and aliases and that cil_list_init() never returns if it failed
to allocate "aliases". Could you please initialize aliases to NULL on
lines 867, 907 and 1025 and roles on line 1588, as well as first and last
to zero in cil_xperms_to_policy()?

Secondly:
../cil/src/cil_policy.c:1132:28: error: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Werror,-Wformat]
                                fprintf(out, " 0x%hx", first);
                                                 ~~~   ^~~~~
                                                 %x

Why is "h" prefix used to format variables of type "int"?

The full compiler output is available in
https://travis-ci.org/fishilico/selinux/jobs/178096652 .

Nicolas

--001a114118a07c29070541e9fdf1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Nov 22, 2016 at 8:18 PM, James Carter <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jwcart2@tycho.nsa.gov" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The a=
bility to create a policy.conf file from the CIL AST has been<br>
a desire from the beginning to assist in debugging and for general<br>
flexibility. Some work towards this end was started early in CIL&#39;s<br>
history, but cil_policy.c has not been remotely functional in a long<br>
time. Until now.<br>
<br>
The function cil_write_policy_conf() will write a policy.conf file<br>
from a CIL AST after cil_build_ast(), cil_resolve_ast(),<br>
cil_fqn_qualify(), and cil_post_process() have been called.</blockquote><di=
v><br></div><div>Hello,</div><div>When building with clang and some warning=
 flags, this commit introduces some warnings (treated as errors because of =
-Werror). These warnings are not reported by gcc, which compiles everything=
 fine.</div><div><br></div><div>First, there are many:</div><div><div>../ci=
l/src/cil_policy.c:867:21: error: variable &#39;aliases&#39; may be uniniti=
alized when used here [-Werror,-Wconditional-uninitialized]</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cil_list_append(aliases, CIL_SENSALIAS, =
alias);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~</div></div><div><br></div><d=
iv>This is because the compiler is not smart enough to find the link betwee=
n num_aliases and aliases and=C2=A0that=C2=A0cil_list_init() never returns =
if it failed to allocate &quot;aliases&quot;. Could you please initialize=
=C2=A0aliases to NULL on lines=C2=A0867, 907 and=C2=A01025 and roles on lin=
e=C2=A01588, as well as first and last to zero in=C2=A0cil_xperms_to_policy=
()?</div><div><br></div><div>Secondly:</div><div><div>../cil/src/cil_policy=
.c:1132:28: error: format specifies type &#39;unsigned short&#39; but the a=
rgument has type &#39;unsigned int&#39; [-Werror,-Wformat]</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(out, &quot; 0x%hx&quot;, first);</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~ =C2=A0 ^~~~~</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0%x</div></div><div><br></div><div>Why is &quot;h&quot; prefix =
used to format variables of type &quot;int&quot;?</div><div><br></div><div>=
The full compiler output is available in=C2=A0<a href=3D"https://travis-ci.=
org/fishilico/selinux/jobs/178096652">https://travis-ci.org/fishilico/selin=
ux/jobs/178096652</a> .</div><div><br></div><div>Nicolas</div></div><br></d=
iv></div>

--001a114118a07c29070541e9fdf1--
