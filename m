Message-ID: <42EE3879.2050409@tresys.com>
Date: Mon, 01 Aug 2005 10:58:01 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com> <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> <snip>
>
>- We need to be sure that we are comfortable with collapsing the type
>value space and class value space to 16 bits.  That was done by the
>first patchset as part of reducing the avtab node size.  The avtab_read
>code checks for value truncation when reading older binary policies; we
>should also add checks to checkpolicy to ensure that we don't overflow
>
>during policy compilation.
>
I know it won't affect the size but why not make all symbol value spaces 16 bits, just for consistency?

Also, here is a trivial patch to let audit2why compile with -Werror (which the Makefile in cvs does by default)

diff -purN nsa-patched/selinux-usr/libsepol/include/sepol/ebitmap.h nsa-new/selinux-usr/libsepol/include/sepol/ebitmap.h

--- nsa-patched/selinux-usr/libsepol/include/sepol/ebitmap.h    2005-08-01 10:53:54.503439624 -0400

+++ nsa-new/selinux-usr/libsepol/include/sepol/ebitmap.h        2005-08-01 10:51:25.564081848 -0400

@@ -46,7 +46,7 @@ static inline void ebitmap_init(ebitmap_

        memset(e, 0, sizeof(*e));

 }

-static inline unsigned int ebitmap_nextbit(ebitmap_t *e,

+static inline unsigned int ebitmap_nextbit(ebitmap_t *e __attribute__ ((__unused__)),

                                           ebitmap_node_t **n,

                                           unsigned int bit)

 {

@@ -59,7 +59,7 @@ static inline unsigned int ebitmap_nextb

        return (bit+1);

 }

-static inline int ebitmap_node_get_bit(ebitmap_t *e,

+static inline int ebitmap_node_get_bit(ebitmap_t *e __attribute__ ((__unused__)),

                                       ebitmap_node_t * n,

                                       unsigned int bit)

 {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
