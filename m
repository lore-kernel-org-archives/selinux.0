Subject: Re: [PATCH 0/5] selinux: minor cleanup suggestions
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD173.80309@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 13:59:15 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> A few random things I stumbled on.
>
> While I'm pretty sure of the change in 1/5, I'm also confused, because
> the doc for the reverse security_sid_to_context state that
> @scontext_len is set to "the length of the string", which one would
> normally interpret as being what strlen() would give (i.e., without
> the \0). However, security_sid_to_context_core clearly includes the \0
> in the return value, and I think callers rely on that.

It is historical; originally security_context_to_sid() required 
@scontext to be NUL-terminated and @scontext_len to include the NUL byte 
in the length, and security_sid_to_context() returned a NUL-terminated 
@scontext and included the NUL byte in the returned length.  However, 
when we switched SELinux to using xattrs rather than its own persistent 
label mapping, security_context_to_sid() was changed to accept contexts 
that did not already include the NUL because setfattr did not consider 
the NUL to be part of the attribute value for strings.  So presently it 
accepts either form, although we prefer them to be NUL-terminated and 
canonicalize them to that form before returning to userspace.

>
> Rasmus Villemoes (5):
>    selinux: introduce security_context_str_to_sid
>    selinux: remove pointless cast in selinux_inode_setsecurity()
>    selinux: use kmemdup in security_sid_to_context_core()
>    selinux: use kstrdup() in security_get_bools()
>    selinux: use sprintf return value
>
>   security/selinux/hooks.c            | 14 +++++---------
>   security/selinux/include/security.h |  2 ++
>   security/selinux/selinuxfs.c        | 26 +++++++++-----------------
>   security/selinux/ss/services.c      | 22 +++++++++-------------
>   4 files changed, 25 insertions(+), 39 deletions(-)
>
