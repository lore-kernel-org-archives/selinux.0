Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBLL0bIi023909
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 16:00:37 -0500 (EST)
Received: from maat.darkhonor.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBLKwpNU007245
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 20:58:52 GMT
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4E7A0.C193C480"
Subject: Eclipse and Java with SELinux Strict Policy
Date: Tue, 21 Dec 2004 16:04:28 -0500
Message-ID: <A52BEA1D8EE8634B9196A136333637B1DB09@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4E7A0.C193C480
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C4E7A0.C193C480"


------_=_NextPart_002_01C4E7A0.C193C480
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


After finishing reading through McCarty's SELinux book (a definite =
recommend to folks learning SELinux IMHO), I decided to reapproach =
generating a policy for Eclipse (http://www.eclipse.org) as installed by =
the JPackage project (http://www.jpackage.org).  I am running Fedora =
Rawhide with selinux-policy-strict-1.19.13-1.  After working on this for =
a couple of hours, I found several log messages that pointed out that =
the Java Runtime Environment jar files are all labelled lib_t (they are =
located in /usr/lib/jvm/java-1.5.0-sun-1.5.0/jre/lib). I have attached =
my initial policy and context files. In order to get a more complete =
list of required permissions, I changed the system to permissive mode to =
run eclipse. Here are the results of running audit2allow on my syslog =
messages after including the eclipse policy:

allow eclipse_t home_root_t:dir search;
allow eclipse_t ld_so_cache_t:file execute;
allow eclipse_t lib_t:file execute;
allow eclipse_t locale_t:file execute;
allow eclipse_t staff_devpts_t:chr_file { read write };
allow eclipse_t staff_home_dir_t:dir { add_name remove_name search write =
};
allow eclipse_t staff_home_dir_t:file { create getattr link read rename =
unlink write };
allow eclipse_t staff_home_t:dir { add_name getattr read remove_name =
search write };
allow eclipse_t staff_home_t:file { append create getattr lock read =
rename unlink write };
allow eclipse_t staff_home_xauth_t:file { getattr read };
allow eclipse_t staff_tmp_t:dir { add_name getattr read remove_name =
search write };
allow eclipse_t staff_tmp_t:file { create execute read unlink write };
allow eclipse_t sysctl_kernel_t:dir search;
allow eclipse_t sysctl_kernel_t:file read;
allow eclipse_t tmp_t:dir search;
allow eclipse_t tmpfs_t:file { execute read write };
allow eclipse_t xdm_tmp_t:dir search;
allow eclipse_t xdm_tmp_t:sock_file write;
allow eclipse_t xdm_xserver_t:unix_stream_socket connectto;
allow xdm_xserver_t eclipse_t:fd use;
allow xdm_xserver_t eclipse_t:shm { associate getattr read unix_read =
unix_write write };
allow xdm_xserver_t tmpfs_t:file { read write };

The user I am running eclipse as is a member of staff_r, so I figure =
I'll have to add a macro (similar to the way Mozilla/Firefox handles =
writing to user home directories). Since I have no Java eclipse policy, =
how many of these could be solved by creating a basic JVM policy =
(confine the JVM to just the JVM and allow transitions from specific =
Java programs to the JVM domain)? Are the xdm-related lines standard for =
applications that run in X? What are the disadvantages of allowing =
read/search access to sysctl_kernel_t? That is the current running =
kernel config files located within /proc right?  Any help or ideas would =
be appreciated.  Thanks!

Alex

------_=_NextPart_002_01C4E7A0.C193C480
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Eclipse and Java with SELinux Strict Policy</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>After finishing reading through McCarty's SELinux book =
(a definite recommend to folks learning SELinux IMHO), I decided to =
reapproach generating a policy for Eclipse (<A =
HREF=3D"http://www.eclipse.org">http://www.eclipse.org</A>) as installed =
by the JPackage project (<A =
HREF=3D"http://www.jpackage.org">http://www.jpackage.org</A>).&nbsp; I =
am running Fedora Rawhide with selinux-policy-strict-1.19.13-1.&nbsp; =
After working on this for a couple of hours, I found several log =
messages that pointed out that the Java Runtime Environment jar files =
are all labelled lib_t (they are located in =
/usr/lib/jvm/java-1.5.0-sun-1.5.0/jre/lib). I have attached my initial =
policy and context files. In order to get a more complete list of =
required permissions, I changed the system to permissive mode to run =
eclipse. Here are the results of running audit2allow on my syslog =
messages after including the eclipse policy:<BR>
<BR>
allow eclipse_t home_root_t:dir search;<BR>
allow eclipse_t ld_so_cache_t:file execute;<BR>
allow eclipse_t lib_t:file execute;<BR>
allow eclipse_t locale_t:file execute;<BR>
allow eclipse_t staff_devpts_t:chr_file { read write };<BR>
allow eclipse_t staff_home_dir_t:dir { add_name remove_name search write =
};<BR>
allow eclipse_t staff_home_dir_t:file { create getattr link read rename =
unlink write };<BR>
allow eclipse_t staff_home_t:dir { add_name getattr read remove_name =
search write };<BR>
allow eclipse_t staff_home_t:file { append create getattr lock read =
rename unlink write };<BR>
allow eclipse_t staff_home_xauth_t:file { getattr read };<BR>
allow eclipse_t staff_tmp_t:dir { add_name getattr read remove_name =
search write };<BR>
allow eclipse_t staff_tmp_t:file { create execute read unlink write =
};<BR>
allow eclipse_t sysctl_kernel_t:dir search;<BR>
allow eclipse_t sysctl_kernel_t:file read;<BR>
allow eclipse_t tmp_t:dir search;<BR>
allow eclipse_t tmpfs_t:file { execute read write };<BR>
allow eclipse_t xdm_tmp_t:dir search;<BR>
allow eclipse_t xdm_tmp_t:sock_file write;<BR>
allow eclipse_t xdm_xserver_t:unix_stream_socket connectto;<BR>
allow xdm_xserver_t eclipse_t:fd use;<BR>
allow xdm_xserver_t eclipse_t:shm { associate getattr read unix_read =
unix_write write };<BR>
allow xdm_xserver_t tmpfs_t:file { read write };<BR>
<BR>
The user I am running eclipse as is a member of staff_r, so I figure =
I'll have to add a macro (similar to the way Mozilla/Firefox handles =
writing to user home directories). Since I have no Java eclipse policy, =
how many of these could be solved by creating a basic JVM policy =
(confine the JVM to just the JVM and allow transitions from specific =
Java programs to the JVM domain)? Are the xdm-related lines standard for =
applications that run in X? What are the disadvantages of allowing =
read/search access to sysctl_kernel_t? That is the current running =
kernel config files located within /proc right?&nbsp; Any help or ideas =
would be appreciated.&nbsp; Thanks!<BR>
<BR>
Alex<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C4E7A0.C193C480--

------_=_NextPart_001_01C4E7A0.C193C480
Content-Type: application/octet-stream;
	name="eclipse.fc"
Content-Transfer-Encoding: base64
Content-Description: eclipse.fc
Content-Disposition: attachment;
	filename="eclipse.fc"

IyBlY2xpcHNlCi91c3IvbGliL2VjbGlwc2UvZWNsaXBzZQktLQlzeXN0ZW1fdTpvYmplY3Rfcjpl
Y2xpcHNlX2V4ZWNfdAovdXNyL2Jpbi9lY2xpcHNlCQktLQlzeXN0ZW1fdTpvYmplY3RfcjplY2xp
cHNlX2V4ZWNfdAovdXNyL3NoYXJlL2VjbGlwc2UoLy4qKT8JCXN5c3RlbV91Om9iamVjdF9yOmVj
bGlwc2VfdAovdXNyL3NoYXJlL2VjbGlwc2UJCS1kCXN5c3RlbV91Om9iamVjdF9yOnVzcl90Ci91
c3Ivc2hhcmUvZWNsaXBzZS9wbHVnaW5zKC8uKik/CQlzeXN0ZW1fdTpvYmplY3RfcjplY2xpcHNl
X3BsdWdpbl90Ci91c3Ivc2hhcmUvZWNsaXBzZS9zdGFydHVwLmphcgktLQlzeXN0ZW1fdTpvYmpl
Y3RfcjpzaGxpYl90Ci9ldGMvZWNsaXBzZVwuY29uZgkJLS0Jc3lzdGVtX3U6b2JqZWN0X3I6ZWNs
aXBzZV9ldGNfdAovdXNyL3NoYXJlL2VjbGlwc2UvZWNsaXBzZQkJc3lzdGVtX3U6b2JqZWN0X3I6
ZWNsaXBzZV9leGVjX3QK

------_=_NextPart_001_01C4E7A0.C193C480
Content-Type: application/octet-stream;
	name="eclipse.te"
Content-Transfer-Encoding: base64
Content-Description: eclipse.te
Content-Disposition: attachment;
	filename="eclipse.te"

I0RFU0MgRWNsaXBzZSBKYXZhIElERQojCiMgQXV0aG9yOiAgQWxleCBBY2tlcm1hbiA8YWxleEBk
YXJraG9ub3IuY29tPgojCnR5cGUgZWNsaXBzZV90LCBkb21haW4sIG5zY2RfY2xpZW50X2RvbWFp
bjsKdHlwZSBlY2xpcHNlX2V4ZWNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCBleGVjX3R5cGU7
CnR5cGUgZWNsaXBzZV9ldGNfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlLCB1c2VyY2FucmVhZDsK
dHlwZSBlY2xpcHNlX3BsdWdpbl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIHVzZXJjYW5yZWFk
OwoKcm9sZSBzdGFmZl9yIHR5cGVzIGVjbGlwc2VfdCA7CnJvbGUgc3lzYWRtX3IgdHlwZXMgZWNs
aXBzZV90Owpkb21haW5fYXV0b190cmFucyhzdGFmZl90LCBlY2xpcHNlX2V4ZWNfdCwgZWNsaXBz
ZV90KQoKY2FuX25ldHdvcmsoZWNsaXBzZV90KQp1c2VzX3NobGliKGVjbGlwc2VfdCkKcmVhZF9s
b2NhbGUoZWNsaXBzZV90KQoKIyBBY2Nlc3MgdG8gL2V0Yy9mc3RhYgphbGxvdyBlY2xpcHNlX3Qg
ZXRjX3Q6ZmlsZSB7IHJlYWQgZ2V0YXR0ciB9OwojIEFjY2VzcyB0byAvZXRjL210YWIKYWxsb3cg
ZWNsaXBzZV90IGV0Y19ydW50aW1lX3Q6IGZpbGUgeyByZWFkIGdldGF0dHIgfTsKCmFsbG93IGVj
bGlwc2VfdCBkZXZ0dHlfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsKYWxsb3cgZWNsaXBzZV90
IGRldnB0c190OmRpciBzZWFyY2g7CgojIE5lZWRzIHRvIGJlIGFibGUgdG8gZmluZCAvdXNyL2Jp
bi9lY2xpcHNlCmFsbG93IGVjbGlwc2VfdCBiaW5fdDpkaXIgc2VhcmNoOwojIEFjY2VzcyB0byAv
dXNyL2Jpbi9ncmVwLCAvdXNyL2Jpbi93aGljaCwgL3Vzci9iaW4vamF2YQphbGxvdyBlY2xpcHNl
X3QgYmluX3Q6ZmlsZSB7IGdldGF0dHIgZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIHJlYWQgfTsK
YWxsb3cgZWNsaXBzZV90IGJpbl90Omxua19maWxlIHsgZ2V0YXR0ciByZWFkIH07CgojIEFjY2Vz
cyB0byAvcHJvYwpyX2Rpcl9maWxlKGVjbGlwc2VfdCwgcHJvY190KQpyX2Rpcl9maWxlKGVjbGlw
c2VfdCwgcHJvY19uZXRfdCkKI2FsbG93IGVjbGlwc2VfdCBwcm9jX3Q6ZGlyIHNlYXJjaDsKI2Fs
bG93IGVjbGlwc2VfdCBwcm9jX3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9OwojYWxsb3cgZWNsaXBz
ZV90IHByb2NfdDpsbmtfZmlsZSByZWFkOwoKIyBSZWFkIC9ldGMvZWNsaXBzZS5jb25mCmFsbG93
IGVjbGlwc2VfdCBlY2xpcHNlX2V0Y190OmZpbGUgeyByZWFkIGdldGF0dHIgfTsKIyBSZWFkIC91
c3Ivc2hhcmUvZWNsaXBzZS9lY2xpcHNlCmFsbG93IGVjbGlwc2VfdCBlY2xpcHNlX2V4ZWNfdDps
bmtfZmlsZSB7IHJlYWQgZ2V0YXR0ciB9OwphbGxvdyBlY2xpcHNlX3QgZWNsaXBzZV9leGVjX3Q6
ZmlsZSBleGVjdXRlX25vX3RyYW5zOwoKIyBSZWFkIC91c3Ivc2hhcmUvamF2YS11dGlscy9qYXZh
LWZ1bmN0aW9ucwphbGxvdyBlY2xpcHNlX3QgdXNyX3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCB9Owph
bGxvdyBlY2xpcHNlX3QgdXNyX3Q6bG5rX2ZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKCmFsbG93IGVj
bGlwc2VfdCBzZWxmOnByb2Nlc3MgeyBmb3JrIHNpZ2NobGQgZ2V0c2NoZWQgc2lnbmFsIH07CmFs
bG93IGVjbGlwc2VfdCBzZWxmOmZpZm9fZmlsZSB7IGdldGF0dHIgcmVhZCB3cml0ZSB9OwphbGxv
dyBlY2xpcHNlX3Qgc2VsZjpzaG0gY3JlYXRlX3NobV9wZXJtczsKYWxsb3cgZWNsaXBzZV90IHNl
bGY6dW5peF9zdHJlYW1fc29ja2V0IHsgY29ubmVjdHRvIGxvY2sgY3JlYXRlX3N0cmVhbV9zb2Nr
ZXRfcGVybXMgfTsKYWxsb3cgZWNsaXBzZV90IHNlbGY6ZGlyIHsgZ2V0YXR0ciByZWFkIHNlYXJj
aCB9OwphbGxvdyBlY2xpcHNlX3Qgc2VsZjpmaWxlIHsgZ2V0YXR0ciByZWFkIH07CmFsbG93IGVj
bGlwc2VfdCBzZWxmOmxua19maWxlIHsgZ2V0YXR0ciByZWFkIH07CmFsbG93IGVjbGlwc2VfdCBl
Y2xpcHNlX3BsdWdpbl90OmRpciB7IGdldGF0dHIgcmVhZCBzZWFyY2ggd3JpdGUgfTsKYWxsb3cg
ZWNsaXBzZV90IGVjbGlwc2VfcGx1Z2luX3Q6ZmlsZSB7IGdldGF0dHIgcmVhZCBleGVjdXRlIHdy
aXRlIH07CmFsbG93IGVjbGlwc2VfdCBlY2xpcHNlX3BsdWdpbl90Omxua19maWxlIHsgZ2V0YXR0
ciByZWFkIH07CgphbGxvdyBlY2xpcHNlX3QgZm9udHNfdDpkaXIgeyBnZXRhdHRyIHJlYWQgc2Vh
cmNoIH07CmFsbG93IGVjbGlwc2VfdCBmb250c190OmZpbGUgeyBleGVjdXRlIGdldGF0dHIgcmVh
ZCB9OwoKYWxsb3cgZWNsaXBzZV90IHJhbmRvbV9kZXZpY2VfdDpjaHJfZmlsZSB7IGFwcGVuZCBn
ZXRhdHRyIHJlYWQgfTsKYWxsb3cgZWNsaXBzZV90IHVyYW5kb21fZGV2aWNlX3Q6Y2hyX2ZpbGUg
eyBnZXRhdHRyIGlvY3RsIHJlYWQgfTsgCgo=

------_=_NextPart_001_01C4E7A0.C193C480--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
