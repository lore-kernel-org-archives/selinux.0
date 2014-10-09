MIME-Version: 1.0
Date: Wed, 8 Oct 2014 17:41:42 -0700
Message-ID: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
Subject: [PATCH] selinux: hooks: Add permission for network MAC address
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1135e3ba4048950504f2b2a4
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1135e3ba4048950504f2b2a4
Content-Type: text/plain; charset=UTF-8

First time poster to the list. I would appreciate feedback/suggestions
regarding the following patch.

This patch which provides SELinux control over network interface MAC
addresses. This patch allows access to the MAC address to be controlled by
policy. Network MAC addresses are a long lived unique device identifier,
and a security policy may wish to control access to the identifier without
further limiting network use, perhaps for privacy reasons.

The existing SE Linux permissions are too coarse in that they only allow
blanket read/no-read access to this socket ioctl. We would like to consider
both the read/no-read permission as well as an additional permission that
checks the ioctl cmd argument. This allows applications to continue
accessing the IP address, netmask, etc, while being denied access to the
MAC address.

Thanks,
Jeff Vander Stoep

---
 security/selinux/hooks.c            | 7 +++++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1e1266b..cb65fd9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct file *file,
unsigned int cmd,
     SECURITY_CAP_AUDIT);
  break;

+    case SIOCGIFHWADDR:
+        error = file_has_perm(cred, file, FILE__IOCTL);
+        if (error)
+            break;
+        error = file_has_perm(cred, file, SOCKET__GET_HWADDR);
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

--001a1135e3ba4048950504f2b2a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>First time poster to the list. I would appreciate fee=
dback/suggestions regarding the following patch.</div><div><br></div><div>T=
his patch which provides SELinux control over network interface MAC address=
es. This patch allows access to the MAC address to be controlled by policy.=
 Network MAC addresses are a long lived unique device identifier, and a sec=
urity policy may wish to control access to the identifier without further l=
imiting network use, perhaps for privacy reasons.</div><div><br></div><div>=
The existing SE Linux permissions are too coarse in that they only allow bl=
anket read/no-read access to this socket ioctl. We would like to consider b=
oth the read/no-read permission as well as an additional permission that ch=
ecks the ioctl cmd argument. This allows applications to continue accessing=
 the IP address, netmask, etc, while being denied access to the MAC address=
.</div><div><br></div><div>Thanks,</div><div>Jeff Vander Stoep</div><div><b=
r></div><div><div>---</div><div>=C2=A0security/selinux/hooks.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 7 +++++++</div><div>=C2=A0security/selinux=
/include/classmap.h | 2 +-</div><div>=C2=A02 files changed, 8 insertions(+)=
, 1 deletion(-)</div><div><br></div><div>diff --git a/security/selinux/hook=
s.c b/security/selinux/hooks.c</div><div>index 1e1266b..cb65fd9 100644</div=
><div>--- a/security/selinux/hooks.c</div><div>+++ b/security/selinux/hooks=
.c</div><div>@@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct fi=
le *file, unsigned int cmd,</div><div>=C2=A0<span class=3D"" style=3D"white=
-space:pre">					</span> =C2=A0 =C2=A0SECURITY_CAP_AUDIT);</div><div>=C2=A0=
<span class=3D"" style=3D"white-space:pre">		</span>break;</div><div>=C2=A0=
</div><div>+ =C2=A0 =C2=A0case SIOCGIFHWADDR:</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0error =3D file_has_perm(cred, file, FILE__IOCTL);</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (error)</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D file_h=
as_perm(cred, file, SOCKET__GET_HWADDR);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;</div><div>+</div><div>=C2=A0<span class=3D"" style=3D"white-sp=
ace:pre">	</span>/* default case assumes that the command will go</div><div=
>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span> * to the file&#3=
9;s ioctl() function.</div><div>=C2=A0<span class=3D"" style=3D"white-space=
:pre">	</span> */</div><div>diff --git a/security/selinux/include/classmap.=
h b/security/selinux/include/classmap.h</div><div>index c32ff7b..306f0d2 10=
0644</div><div>--- a/security/selinux/include/classmap.h</div><div>+++ b/se=
curity/selinux/include/classmap.h</div><div>@@ -7,7 +7,7 @@</div><div>=C2=
=A0</div><div>=C2=A0#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, &quot=
;bind&quot;, &quot;connect&quot;, \</div><div>=C2=A0 =C2=A0 =C2=A0&quot;lis=
ten&quot;, &quot;accept&quot;, &quot;getopt&quot;, &quot;setopt&quot;, &quo=
t;shutdown&quot;, &quot;recvfrom&quot;, =C2=A0\</div><div>- =C2=A0 =C2=A0&q=
uot;sendto&quot;, &quot;recv_msg&quot;, &quot;send_msg&quot;, &quot;name_bi=
nd&quot;</div><div>+ =C2=A0 =C2=A0&quot;sendto&quot;, &quot;recv_msg&quot;,=
 &quot;send_msg&quot;, &quot;name_bind&quot;, &quot;get_hwaddr&quot;</div><=
div>=C2=A0</div><div>=C2=A0#define COMMON_IPC_PERMS &quot;create&quot;, &qu=
ot;destroy&quot;, &quot;getattr&quot;, &quot;setattr&quot;, &quot;read&quot=
;, \</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =
=C2=A0 =C2=A0&quot;write&quot;, &quot;associate&quot;, &quot;unix_read&quot=
;, &quot;unix_write&quot;</div><div>--=C2=A0</div><div>2.1.0.rc2.206.gedb03=
e5</div></div><div><br></div></div>

--001a1135e3ba4048950504f2b2a4--
