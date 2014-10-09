MIME-Version: 1.0
In-Reply-To: <5436A035.5030506@tycho.nsa.gov>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <5436A035.5030506@tycho.nsa.gov>
Date: Thu, 9 Oct 2014 11:48:29 -0700
Message-ID: <CABXk95C2XumO3C9Hb21QgxrQXv3By=kr5QSpOmg6x_unYWmHdA@mail.gmail.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113d2dd6dd6910050501e093
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d2dd6dd6910050501e093
Content-Type: text/plain; charset=UTF-8

On Thu, Oct 9, 2014 at 7:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>
> There was some earlier discussion of filtering ioctls via SELinux.  If
> you want to do that in general, this approach won't get you there - it
> cannot scale to deal with more than a handful of ioctl commands.  If
> however you truly only want this control for this particular ioctl
> command, see below for comments on the code.  Otherwise, if you want to
> explore a generic facility for ioctl filtering, I can send you pointers
> to the earlier discussions.
>

That makes sense. I am a bit conflicted. This is my only use-case, but it
sounds like regular filtering of ioctl commands would be generally useful.
I understand that my current approach would not scale and would lead to an
explosion in permissions. So I am weighing the benefits of this particular
permission which seems broadly useful with the risk of either waiting on a
general approach or the risk of implementing something that doesn't get
mainlined. I would appreciate your thoughts on this.  Can you point me
towards the earlier discussions?

>
> You can't safely call file_has_perm() with a SOCKET permission as the
> file may reference an object with a non-socket security class.  So for
> example, if a process called ioctl with this command value on a file,
> you'd end up getting a very different permission check - whatever that
> permission bit corresponds to in the file security class (I guess
> nothing at this point, but could potentially be filled in the future).
> So I think you need to first check that the file represents a socket
> before performing the second check.  The other alternative would be to
> define the permission in COMMON_FILE_SOCK_PERMS so that it is defined
> for all objects that can be presented by struct file, but that would
> waste a permission bit for the file classes.
>
> For the first option, something along the lines of:
> struct inode *inode = file->f_path.dentry->d_inode;
> struct socket *socket;
> if (inode->i_sb->s_magic != SOCKFS_MAGIC)
>         break;
> socket = SOCKET_I(inode);
> error = sock_has_perm(current, socket->sk, SOCKET__GET_HWADDR);
> break;
>
>
>
>
Thank you for catching that. Here is the patch updated with your
recommendations:

---
 security/selinux/hooks.c            | 14 ++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1e1266b..5105341 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3104,10 +3104,14 @@ static void selinux_file_free_security(struct file
*file)
  file_free_security(file);
 }

+static int sock_has_perm(struct task_struct *task, struct sock *sk, u32
perms);
+
 static int selinux_file_ioctl(struct file *file, unsigned int cmd,
       unsigned long arg)
 {
  const struct cred *cred = current_cred();
+    struct inode *inode = file->f_path.dentry->d_inode;
+    struct socket *socket;
  int error = 0;

  switch (cmd) {
@@ -3142,6 +3146,16 @@ static int selinux_file_ioctl(struct file *file,
unsigned int cmd,
     SECURITY_CAP_AUDIT);
  break;

+    case SIOCGIFHWADDR:
+        error = file_has_perm(cred, file, FILE__IOCTL);
+        if (error)
+            break;
+        if (inode->i_sb->s_magic != SOCKFS_MAGIC)
+            break;
+        socket = SOCKET_I(inode);
+        error = sock_has_perm(current, socket->sk, SOCKET__GET_HWADDR);
+        break;
+
  /* default case assumes that the command will go
  * to the file's ioctl() function.
  */
diff --git a/security/selinux/include/classmap.h
b/security/selinux/include/classmap.h
index c32ff7b..306f0d2 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -7,7 +7,7 @@

 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
-    "sendto", "recv_msg", "send_msg", "name_bind"
+    "sendto", "recv_msg", "send_msg", "name_bind", "get_hwaddr"

 #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr",
"read", \
     "write", "associate", "unix_read", "unix_write"
-- 
2.1.0.rc2.206.gedb03e5

--001a113d2dd6dd6910050501e093
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Oct 9, 2014 at 7:48 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><span>
<br>
</span>There was some earlier discussion of filtering ioctls via SELinux.=
=C2=A0 If<br>
you want to do that in general, this approach won&#39;t get you there - it<=
br>
cannot scale to deal with more than a handful of ioctl commands.=C2=A0 If<b=
r>
however you truly only want this control for this particular ioctl<br>
command, see below for comments on the code.=C2=A0 Otherwise, if you want t=
o<br>
explore a generic facility for ioctl filtering, I can send you pointers<br>
to the earlier discussions.<br></blockquote><div><br></div><div>That makes =
sense. I am a bit conflicted. This is my only use-case, but it sounds like =
regular filtering of ioctl commands would be generally useful. I understand=
 that my current approach would not scale and would lead to an explosion in=
 permissions. So I am weighing the benefits of this particular permission w=
hich seems broadly useful with the risk of either waiting on a general appr=
oach or the risk of implementing something that doesn&#39;t get mainlined. =
I would appreciate your thoughts on this.=C2=A0 Can you point me towards th=
e earlier discussions?</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex"><span>
<br>
</span>You can&#39;t safely call file_has_perm() with a SOCKET permission a=
s the<br>
file may reference an object with a non-socket security class.=C2=A0 So for=
<br>
example, if a process called ioctl with this command value on a file,<br>
you&#39;d end up getting a very different permission check - whatever that<=
br>
permission bit corresponds to in the file security class (I guess<br>
nothing at this point, but could potentially be filled in the future).<br>
So I think you need to first check that the file represents a socket<br>
before performing the second check.=C2=A0 The other alternative would be to=
<br>
define the permission in COMMON_FILE_SOCK_PERMS so that it is defined<br>
for all objects that can be presented by struct file, but that would<br>
waste a permission bit for the file classes.<br>
<br>
For the first option, something along the lines of:<br>
struct inode *inode =3D file-&gt;f_path.dentry-&gt;d_inode;<br>
struct socket *socket;<br>
if (inode-&gt;i_sb-&gt;s_magic !=3D SOCKFS_MAGIC)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
socket =3D SOCKET_I(inode);<br>
error =3D sock_has_perm(current, socket-&gt;sk, SOCKET__GET_HWADDR);<br>
break;<br>
<div><div><br>
<br><br></div></div></blockquote><div><br></div><div>Thank you for catching=
 that. Here is the patch updated with your recommendations:</div><div><br><=
/div><div><div>---</div><div>=C2=A0security/selinux/hooks.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++++++++++++++</div><div>=C2=A0security/sel=
inux/include/classmap.h | =C2=A02 +-</div><div>=C2=A02 files changed, 15 in=
sertions(+), 1 deletion(-)</div><div><br></div><div>diff --git a/security/s=
elinux/hooks.c b/security/selinux/hooks.c</div><div>index 1e1266b..5105341 =
100644</div><div>--- a/security/selinux/hooks.c</div><div>+++ b/security/se=
linux/hooks.c</div><div>@@ -3104,10 +3104,14 @@ static void selinux_file_fr=
ee_security(struct file *file)</div><div>=C2=A0<span class=3D"" style=3D"wh=
ite-space:pre">	</span>file_free_security(file);</div><div>=C2=A0}</div><di=
v>=C2=A0</div><div>+static int sock_has_perm(struct task_struct *task, stru=
ct sock *sk, u32 perms);</div><div>+</div><div>=C2=A0static int selinux_fil=
e_ioctl(struct file *file, unsigned int cmd,</div><div>=C2=A0<span class=3D=
"" style=3D"white-space:pre">			</span> =C2=A0 =C2=A0 =C2=A0unsigned long a=
rg)</div><div>=C2=A0{</div><div>=C2=A0<span class=3D"" style=3D"white-space=
:pre">	</span>const struct cred *cred =3D current_cred();</div><div>+ =C2=
=A0 =C2=A0struct inode *inode =3D file-&gt;f_path.dentry-&gt;d_inode;</div>=
<div>+ =C2=A0 =C2=A0struct socket *socket;</div><div>=C2=A0<span class=3D""=
 style=3D"white-space:pre">	</span>int error =3D 0;</div><div>=C2=A0</div><=
div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>switch (cmd) {=
</div><div>@@ -3142,6 +3146,16 @@ static int selinux_file_ioctl(struct file=
 *file, unsigned int cmd,</div><div>=C2=A0<span class=3D"" style=3D"white-s=
pace:pre">					</span> =C2=A0 =C2=A0SECURITY_CAP_AUDIT);</div><div>=C2=A0<s=
pan class=3D"" style=3D"white-space:pre">		</span>break;</div><div>=C2=A0</=
div><div>+ =C2=A0 =C2=A0case SIOCGIFHWADDR:</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0error =3D file_has_perm(cred, file, FILE__IOCTL);</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (error)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (inode-&gt;i_=
sb-&gt;s_magic !=3D SOCKFS_MAGIC)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0socket =3D SOCKE=
T_I(inode);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D sock_has_perm(=
current, socket-&gt;sk, SOCKET__GET_HWADDR);</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;</div><div>+</div><div>=C2=A0<span class=3D"" style=3D"whit=
e-space:pre">	</span>/* default case assumes that the command will go</div>=
<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span> * to the fil=
e&#39;s ioctl() function.</div><div>=C2=A0<span class=3D"" style=3D"white-s=
pace:pre">	</span> */</div><div>diff --git a/security/selinux/include/class=
map.h b/security/selinux/include/classmap.h</div><div>index c32ff7b..306f0d=
2 100644</div><div>--- a/security/selinux/include/classmap.h</div><div>+++ =
b/security/selinux/include/classmap.h</div><div>@@ -7,7 +7,7 @@</div><div>=
=C2=A0</div><div>=C2=A0#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, &q=
uot;bind&quot;, &quot;connect&quot;, \</div><div>=C2=A0 =C2=A0 =C2=A0&quot;=
listen&quot;, &quot;accept&quot;, &quot;getopt&quot;, &quot;setopt&quot;, &=
quot;shutdown&quot;, &quot;recvfrom&quot;, =C2=A0\</div><div>- =C2=A0 =C2=
=A0&quot;sendto&quot;, &quot;recv_msg&quot;, &quot;send_msg&quot;, &quot;na=
me_bind&quot;</div><div>+ =C2=A0 =C2=A0&quot;sendto&quot;, &quot;recv_msg&q=
uot;, &quot;send_msg&quot;, &quot;name_bind&quot;, &quot;get_hwaddr&quot;</=
div><div>=C2=A0</div><div>=C2=A0#define COMMON_IPC_PERMS &quot;create&quot;=
, &quot;destroy&quot;, &quot;getattr&quot;, &quot;setattr&quot;, &quot;read=
&quot;, \</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</spa=
n> =C2=A0 =C2=A0&quot;write&quot;, &quot;associate&quot;, &quot;unix_read&q=
uot;, &quot;unix_write&quot;</div><div>--=C2=A0</div><div>2.1.0.rc2.206.ged=
b03e5</div></div><div><br></div></div></div></div>

--001a113d2dd6dd6910050501e093--
