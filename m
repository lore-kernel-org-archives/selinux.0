Subject: Re: [PATCH 1/3] libselinux: labeling support (try 3)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <466DA23C.9080509@tycho.nsa.gov>
References: <466DA23C.9080509@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 16:55:22 -0400
Message-Id: <1181595322.6699.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-11 at 15:27 -0400, Eamon Walsh wrote:
> The first two tries of this patchset were late last year.  This is
> a labeling API that provides a common way to map from various string
> namespaces into security contexts.
> 
> This version of the patchset simplifies the lookup model down to
> (string,number) to context.  There are no void pointers or variadic
> functions which was one of the objections to the previous patchsets.
> A lot of the file contexts stuff such as the inode tracking support
> has also been dropped with the understanding that this stuff should
> be in the setfiles code, not libselinux.  This is a pure lookup
> interface only.
> 
> This patchset includes two backends, for file contexts and media
> contexts.  Future work would include libsemanage interfaces for
> managing the data the way the file contexts data is currently done.
> 
> This patch includes the interface and generic handle code.  Tested
> with some sample input values, worked OK.
> 

Can you post some client code so we can get a feel for the api?

> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>  include/selinux/label.h |  108 +++++++++++++++++++++++++++++++++++++
>  src/label.c             |  140 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/label_internal.h    |   49 ++++++++++++++++
>  3 files changed, 297 insertions(+)
> 
> 
> Index: libselinux/include/selinux/label.h
> ===================================================================
> --- libselinux/include/selinux/label.h	(revision 0)
> +++ libselinux/include/selinux/label.h	(revision 0)
> @@ -0,0 +1,108 @@
> +/*
> + * Labeling interface for userspace object managers and others.
> + *
> + * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
> + */
> +#ifndef _SELABEL_H_
> +#define _SELABEL_H_
> +
> +#include <sys/types.h>
> +#include <selinux/selinux.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Opaque type used for all label handles.
> + */
> +
> +typedef struct selabel_rec *selabel_handle_t;
> +

Please - no more typedef'd pointers in libselinux. They are just
_wrong_.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
