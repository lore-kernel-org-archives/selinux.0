Subject: Re: [PATCH 0/6 v3] libsepol/cil: Add high-level language line marking
 support
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <232fa568-8a05-91e4-9785-c3d945282d08@tresys.com>
Date: Fri, 6 May 2016 08:34:42 -0400
MIME-Version: 1.0
In-Reply-To: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/2016 04:44 PM, James Carter wrote:
> This patch set adds support for tracking original file and line numbers for better
> error reporting when a high-level language is translated into CIL. It then uses
> that support to provide better error reporting for neverallow rules after
> generating CIL with checkpolicy or checkmodule. (Unfortunately, the original line
> number information is not saved in the pp file, so there is no benefit for policy
> modules.)
> 
> Changes in V2:
> - Only ";;*" at the beginning of a line indicates an HL line mark.
> - When cil_tree_get_next_path() encounters a call or blockinherit it will
> continue searching the AST from the associated macro or block.
> 
> Changes in V3:
> - Changed the format of the message printed by cil_tree_log():
>   Before:
>     Problem at line 21 of policy.cil (from line 11 of foo.hll) (from line 2 of bar.hll)
>   Now:
>     Problem at policy.cil:21 from foo.hll:11 from bar.hll:2
> 
> James Carter (6):
>   libsepol/cil: Add high-level language line marking support
>   libsepol/cil: Store CIL filename in parse tree and AST
>   libsepol/cil: Add cil_tree_log() and supporting functions
>   libsepol/cil: Replace cil_log() calls with cil_tree_log()
>   libsepol/cil: Remove path field from cil_tree_node struct
>   libsepol: When generating CIL use HLL line mark for neverallows

Acked-by: Steve Lawrence <slawrence@tresys.com>

>  libsepol/cil/src/cil.c             |  22 ++-
>  libsepol/cil/src/cil_binary.c      |  45 +++---
>  libsepol/cil/src/cil_build_ast.c   | 294 +++++++++++++++----------------------
>  libsepol/cil/src/cil_build_ast.h   |   2 +
>  libsepol/cil/src/cil_copy_ast.c    |  24 ++-
>  libsepol/cil/src/cil_flavor.h      |   1 +
>  libsepol/cil/src/cil_fqn.c         |   2 +-
>  libsepol/cil/src/cil_internal.h    |   9 ++
>  libsepol/cil/src/cil_lexer.h       |   6 +-
>  libsepol/cil/src/cil_lexer.l       |  15 +-
>  libsepol/cil/src/cil_parser.c      | 259 +++++++++++++++++++++++++++-----
>  libsepol/cil/src/cil_resolve_ast.c |  51 +++----
>  libsepol/cil/src/cil_tree.c        |  96 +++++++++++-
>  libsepol/cil/src/cil_tree.h        |   6 +-
>  libsepol/cil/src/cil_verify.c      |  83 +++++------
>  libsepol/src/module_to_cil.c       |   8 +
>  16 files changed, 590 insertions(+), 333 deletions(-)
> 
