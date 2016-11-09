MIME-Version: 1.0
In-Reply-To: <CA+RmS--i8PiHmt1foeVEYP+uGDxhGLaROzxLvU=GNXW76fDy5A@mail.gmail.com>
References: <1478551587-33892-1-git-send-email-david.graziano@rockwellcollins.com>
 <CAHC9VhQXrybHPt41-f-hcXZJ=i=N5qexdoM2VFLTxFfmuq8Yzg@mail.gmail.com>
 <CA+RmS--i8PiHmt1foeVEYP+uGDxhGLaROzxLvU=GNXW76fDy5A@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 9 Nov 2016 08:52:24 -0800
Message-ID: <CAFftDdrJCk+_qO33PZXJFP+POjHjPr0Jb3eAMr+eEb9=Qe+cRg@mail.gmail.com>
Subject: Re: [PATCH 1/1 V2] mqueue: Implment generic xattr support
To: David Graziano <david.graziano@rockwellcollins.com>
Cc: selinux@tycho.nsa.gov, golbi@mat.uni.torun.pl,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, michal.wronski@gmail.com,
 seth.forshee@canonical.com, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a1147097cddce8c0540e1146c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1147097cddce8c0540e1146c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Nov 9, 2016 08:33, "David Graziano" <david.graziano@rockwellcollins.com>
wrote:
>
> On Mon, Nov 7, 2016 at 4:23 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 7, 2016 at 3:46 PM, David Graziano
> > <david.graziano@rockwellcollins.com> wrote:
> >> This patch adds support for generic extended attributes within the
> >> POSIX message queues filesystem and setting them by consulting the LSM=
.
> >> This is needed so that the security.selinux extended attribute can be
> >> set via a SELinux named type transition on file inodes created within
> >> the filesystem. The implementation and LSM call back function are base=
d
> >> off tmpfs/shmem.
> >>
> >> Signed-off-by: David Graziano <david.graziano@rockwellcollins.com>
> >> ---
> >>  ipc/mqueue.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 46 insertions(+)
> >
> > Hi David,
> >
> > At first glance this looks reasonable to me, I just have a two
> > questions/comments:
> >
> > * Can you explain your current need for this functionality?  For
> > example, what are you trying to do that is made easier by allowing
> > greater message queue labeling flexibility?  This helps put things in
> > context and helps people review and comment on your patch.
> >
> > * How have you tested this?  While this patch is not SELinux specific,
> > I think adding a test to the selinux-testsuite[1] would be worthwhile.
> > The other LSM maintainers may suggest something similar if they have
> > an established public testsuite.
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite
>
> Hi Paul,
>
> I needed to write a selinux policy for a set of custom applications that
use
> POSIX message queues for their IPC. The queues are created by one
> application and we needed a way for selinux to enforce which of the other
> apps are able to read/write to each individual queue. Uniquely labeling
them
> based on the app that created them and the file name seemed to be our bes=
t
> solution since it=E2=80=99s an embedded system and we don=E2=80=99t have =
restorecond to
> handle any relabeling.

I've actually needed this before, so ack from me.

>
>
> To test this patch I used both a selinux enabled, buildroot based qemu
target
> with a customized selinux policy and test C app to create the mqueues. I
also
> tested with our real apps and selinux policy on our target hardware. I ca=
n
> certainly look at adding a test to the selinux-testsuite if that would
> be helpful.
>
> Thanks,
> David
>
> >
> >> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> >> index 0b13ace..512a546 100644
> >> --- a/ipc/mqueue.c
> >> +++ b/ipc/mqueue.c
> >> @@ -35,6 +35,7 @@
> >>  #include <linux/ipc_namespace.h>
> >>  #include <linux/user_namespace.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/xattr.h>
> >>
> >>  #include <net/sock.h>
> >>  #include "util.h"
> >> @@ -70,6 +71,7 @@ struct mqueue_inode_info {
> >>         struct rb_root msg_tree;
> >>         struct posix_msg_tree_node *node_cache;
> >>         struct mq_attr attr;
> >> +       struct simple_xattrs xattrs;    /* list of xattrs */
> >>
> >>         struct sigevent notify;
> >>         struct pid *notify_owner;
> >> @@ -254,6 +256,7 @@ static struct inode *mqueue_get_inode(struct
super_block *sb,
> >>                         info->attr.mq_maxmsg =3D attr->mq_maxmsg;
> >>                         info->attr.mq_msgsize =3D attr->mq_msgsize;
> >>                 }
> >> +               simple_xattrs_init(&info->xattrs);
> >>                 /*
> >>                  * We used to allocate a static array of pointers and
account
> >>                  * the size of that array as well as one msg_msg
struct per
> >> @@ -413,6 +416,41 @@ static void mqueue_evict_inode(struct inode
*inode)
> >>                 put_ipc_ns(ipc_ns);
> >>  }
> >>
> >> +/*
> >> + * Callback for security_inode_init_security() for acquiring xattrs.
> >> + */
> >> +static int mqueue_initxattrs(struct inode *inode,
> >> +                           const struct xattr *xattr_array,
> >> +                           void *fs_info)
> >> +{
> >> +       struct mqueue_inode_info *info =3D MQUEUE_I(inode);
> >> +       const struct xattr *xattr;
> >> +       struct simple_xattr *new_xattr;
> >> +       size_t len;
> >> +
> >> +       for (xattr =3D xattr_array; xattr->name !=3D NULL; xattr++) {
> >> +               new_xattr =3D simple_xattr_alloc(xattr->value,
xattr->value_len);
> >> +               if (!new_xattr)
> >> +                       return -ENOMEM;
> >> +               len =3D strlen(xattr->name) + 1;
> >> +               new_xattr->name =3D kmalloc(XATTR_SECURITY_PREFIX_LEN =
+
len,
> >> +                                         GFP_KERNEL);
> >> +               if (!new_xattr->name) {
> >> +                       kfree(new_xattr);
> >> +                       return -ENOMEM;
> >> +               }
> >> +
> >> +               memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
> >> +                      XATTR_SECURITY_PREFIX_LEN);
> >> +               memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
> >> +                      xattr->name, len);
> >> +
> >> +               simple_xattr_list_add(&info->xattrs, new_xattr);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int mqueue_create(struct inode *dir, struct dentry *dentry,
> >>                                 umode_t mode, bool excl)
> >>  {
> >> @@ -443,6 +481,14 @@ static int mqueue_create(struct inode *dir,
struct dentry *dentry,
> >>                 ipc_ns->mq_queues_count--;
> >>                 goto out_unlock;
> >>         }
> >> +       error =3D security_inode_init_security(inode, dir,
> >> +                                            &dentry->d_name,
> >> +                                            mqueue_initxattrs, NULL);
> >> +       if (error && error !=3D -EOPNOTSUPP) {
> >> +               spin_lock(&mq_lock);
> >> +               ipc_ns->mq_queues_count--;
> >> +               goto out_unlock;
> >> +       }
> >>
> >>         put_ipc_ns(ipc_ns);
> >>         dir->i_size +=3D DIRENT_SIZE;
> >> --
> >> 1.9.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
linux-security-module" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1147097cddce8c0540e1146c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 9, 2016 08:33, &quot;David Graziano&quot; &lt;<a href=
=3D"mailto:david.graziano@rockwellcollins.com">david.graziano@rockwellcolli=
ns.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Nov 7, 2016 at 4:23 PM, Paul Moore &lt;<a href=3D"mailto:paul@=
paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br>
&gt; &gt; On Mon, Nov 7, 2016 at 3:46 PM, David Graziano<br>
&gt; &gt; &lt;<a href=3D"mailto:david.graziano@rockwellcollins.com">david.g=
raziano@rockwellcollins.com</a>&gt; wrote:<br>
&gt; &gt;&gt; This patch adds support for generic extended attributes withi=
n the<br>
&gt; &gt;&gt; POSIX message queues filesystem and setting them by consultin=
g the LSM.<br>
&gt; &gt;&gt; This is needed so that the security.selinux extended attribut=
e can be<br>
&gt; &gt;&gt; set via a SELinux named type transition on file inodes create=
d within<br>
&gt; &gt;&gt; the filesystem. The implementation and LSM call back function=
 are based<br>
&gt; &gt;&gt; off tmpfs/shmem.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: David Graziano &lt;<a href=3D"mailto:david.gra=
ziano@rockwellcollins.com">david.graziano@rockwellcollins.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 ipc/mqueue.c | 46 +++++++++++++++++++++++++++++++++++++=
+++++++++<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 46 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; Hi David,<br>
&gt; &gt;<br>
&gt; &gt; At first glance this looks reasonable to me, I just have a two<br=
>
&gt; &gt; questions/comments:<br>
&gt; &gt;<br>
&gt; &gt; * Can you explain your current need for this functionality?=C2=A0=
 For<br>
&gt; &gt; example, what are you trying to do that is made easier by allowin=
g<br>
&gt; &gt; greater message queue labeling flexibility?=C2=A0 This helps put =
things in<br>
&gt; &gt; context and helps people review and comment on your patch.<br>
&gt; &gt;<br>
&gt; &gt; * How have you tested this?=C2=A0 While this patch is not SELinux=
 specific,<br>
&gt; &gt; I think adding a test to the selinux-testsuite[1] would be worthw=
hile.<br>
&gt; &gt; The other LSM maintainers may suggest something similar if they h=
ave<br>
&gt; &gt; an established public testsuite.<br>
&gt; &gt;<br>
&gt; &gt; [1] <a href=3D"https://github.com/SELinuxProject/selinux-testsuit=
e">https://github.com/SELinuxProject/selinux-testsuite</a><br>
&gt;<br>
&gt; Hi Paul,<br>
&gt;<br>
&gt; I needed to write a selinux policy for a set of custom applications th=
at use<br>
&gt; POSIX message queues for their IPC. The queues are created by one<br>
&gt; application and we needed a way for selinux to enforce which of the ot=
her<br>
&gt; apps are able to read/write to each individual queue. Uniquely labelin=
g them<br>
&gt; based on the app that created them and the file name seemed to be our =
best<br>
&gt; solution since it=E2=80=99s an embedded system and we don=E2=80=99t ha=
ve restorecond to<br>
&gt; handle any relabeling.</p>
<p dir=3D"ltr">I&#39;ve actually needed this before, so ack from me.</p>
<p dir=3D"ltr">&gt;<br>
&gt;<br>
&gt; To test this patch I used both a selinux enabled, buildroot based qemu=
 target<br>
&gt; with a customized selinux policy and test C app to create the mqueues.=
 I also<br>
&gt; tested with our real apps and selinux policy on our target hardware. I=
 can<br>
&gt; certainly look at adding a test to the selinux-testsuite if that would=
<br>
&gt; be helpful.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; David<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; diff --git a/ipc/mqueue.c b/ipc/mqueue.c<br>
&gt; &gt;&gt; index 0b13ace..512a546 100644<br>
&gt; &gt;&gt; --- a/ipc/mqueue.c<br>
&gt; &gt;&gt; +++ b/ipc/mqueue.c<br>
&gt; &gt;&gt; @@ -35,6 +35,7 @@<br>
&gt; &gt;&gt;=C2=A0 #include &lt;linux/ipc_namespace.h&gt;<br>
&gt; &gt;&gt;=C2=A0 #include &lt;linux/user_namespace.h&gt;<br>
&gt; &gt;&gt;=C2=A0 #include &lt;linux/slab.h&gt;<br>
&gt; &gt;&gt; +#include &lt;linux/xattr.h&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 #include &lt;net/sock.h&gt;<br>
&gt; &gt;&gt;=C2=A0 #include &quot;util.h&quot;<br>
&gt; &gt;&gt; @@ -70,6 +71,7 @@ struct mqueue_inode_info {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rb_root msg_tree;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct posix_msg_tree_node *=
node_cache;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mq_attr attr;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct simple_xattrs xattrs;=C2=
=A0 =C2=A0 /* list of xattrs */<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sigevent notify;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pid *notify_owner;<br=
>
&gt; &gt;&gt; @@ -254,6 +256,7 @@ static struct inode *mqueue_get_inode(str=
uct super_block *sb,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;attr.mq_maxmsg =3D attr-&gt;mq_maxmsg;=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;attr.mq_msgsize =3D attr-&gt;mq_msgsiz=
e;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0simpl=
e_xattrs_init(&amp;info-&gt;xattrs);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/*<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 * We used to allocate a static array of pointers and account<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 * the size of that array as well as one msg_msg struct per<br>
&gt; &gt;&gt; @@ -413,6 +416,41 @@ static void mqueue_evict_inode(struct in=
ode *inode)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
put_ipc_ns(ipc_ns);<br>
&gt; &gt;&gt;=C2=A0 }<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +/*<br>
&gt; &gt;&gt; + * Callback for security_inode_init_security() for acquiring=
 xattrs.<br>
&gt; &gt;&gt; + */<br>
&gt; &gt;&gt; +static int mqueue_initxattrs(struct inode *inode,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct xattr *xattr_array,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *fs_info)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mqueue_inode_info *info =
=3D MQUEUE_I(inode);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct xattr *xattr;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct simple_xattr *new_xattr;<b=
r>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (xattr =3D xattr_array; xattr=
-&gt;name !=3D NULL; xattr++) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_x=
attr =3D simple_xattr_alloc(xattr-&gt;value, xattr-&gt;value_len);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
new_xattr)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =
=3D strlen(xattr-&gt;name) + 1;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_x=
attr-&gt;name =3D kmalloc(XATTR_SECURITY_PREFIX_LEN + len,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0GFP_KERNEL);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
new_xattr-&gt;name) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0kfree(new_xattr);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcp=
y(new_xattr-&gt;name, XATTR_SECURITY_PREFIX,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 XATTR_SECURITY_PREFIX_LEN);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcp=
y(new_xattr-&gt;name + XATTR_SECURITY_PREFIX_LEN,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 xattr-&gt;name, len);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0simpl=
e_xattr_list_add(&amp;info-&gt;xattrs, new_xattr);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;&gt; +}<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt;=C2=A0 static int mqueue_create(struct inode *dir, struct dent=
ry *dentry,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umode_t mode, bool =
excl)<br>
&gt; &gt;&gt;=C2=A0 {<br>
&gt; &gt;&gt; @@ -443,6 +481,14 @@ static int mqueue_create(struct inode *d=
ir, struct dentry *dentry,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
ipc_ns-&gt;mq_queues_count--;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
goto out_unlock;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D security_inode_init_sec=
urity(inode, dir,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;dentry-&gt;d_name,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 mqueue_initxattrs, NULL);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &amp;&amp; error !=3D -=
EOPNOTSUPP) {<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_=
lock(&amp;mq_lock);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipc_n=
s-&gt;mq_queues_count--;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
out_unlock;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_ipc_ns(ipc_ns);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dir-&gt;i_size +=3D DIRENT_S=
IZE;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; 1.9.1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; To unsubscribe from this list: send the line &quot;unsubscrib=
e linux-security-module&quot; in<br>
&gt; &gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.ker=
nel.org">majordomo@vger.kernel.org</a><br>
&gt; &gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.or=
g/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; paul moore<br>
&gt; &gt; <a href=3D"http://www.paul-moore.com">www.paul-moore.com</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--001a1147097cddce8c0540e1146c--
