MIME-Version: 1.0
In-Reply-To: <559FBD3A.4090300@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>
 <559FBD3A.4090300@tycho.nsa.gov>
Date: Fri, 10 Jul 2015 08:10:18 -0700
Message-ID: <CAFftDdqP616u6UDZQAnd8AucCz=EXm0mY1Uhcwmp3x9rmWNBgg@mail.gmail.com>
Subject: Re: executing off of a fusefs
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e016819ae280110051a86c557
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e016819ae280110051a86c557
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Jul 10, 2015 5:48 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 07/09/2015 07:04 PM, Roberts, William C wrote:
> > I have this problem on Android, but it=E2=80=99s SELinux general. I=E2=
=80=99d like to
> > get some info from those in the know.
> >
> > If you wanted to be able to execute files off of fuse and have the
> > kernel handle the transition, would it be as simple as having the file
> > system return the getxattr call for the security label?
>
> Aren't fuse mounts mounted with nosuid?  That disables SELinux context
> transitions as well as suid/sgid/file-capabilities. Otherwise, the
> kernel is trusting the userspace filesystem to not cause a privilege
> escalation, potentially in excess of the privileges of the userspace
> filesystem daemon itself.

On AOSP yes others no. BTW I'm not condoning doing this either.

>
> Aside from that, you would also need to configure SELinux to use xattrs
> from fuse (i.e. fs_use_xattr fuse ...), and change the daemon to support
> getxattr, and ensure that you do not have the deadlock problem that
> exists with upstream FUSE where it

This old problem, I think if you don't use libfuse you can get around it.

does not support handling a getxattr
> request on the root directory during the mount(2) call.  And doing this
> would affect all fuse mounts (e.g. /storage/emulated), not just a
> specific one.  There was an attempt to add per-subtype support for
> fs_use so that one could specify a different labeling behavior for a
> specific kind of fuse filesystem, see kernel commit
> 102aefdda4d8275ce7d7100bc16c88c74272b260, but this was reverted in
> 4d546f81717d253ab67643bf072c6d8821a9249c and
> 29b1deb2a48a9dd02b93597aa4c055a24c0e989f as it did not work and caused a
> deadlock for other fuse filesystems.
>
>
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--089e016819ae280110051a86c557
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 10, 2015 5:48 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 07/09/2015 07:04 PM, Roberts, William C wrote:<br>
&gt; &gt; I have this problem on Android, but it=E2=80=99s SELinux general.=
 I=E2=80=99d like to<br>
&gt; &gt; get some info from those in the know.<br>
&gt; &gt;<br>
&gt; &gt; If you wanted to be able to execute files off of fuse and have th=
e<br>
&gt; &gt; kernel handle the transition, would it be as simple as having the=
 file<br>
&gt; &gt; system return the getxattr call for the security label?<br>
&gt;<br>
&gt; Aren&#39;t fuse mounts mounted with nosuid?=C2=A0 That disables SELinu=
x context<br>
&gt; transitions as well as suid/sgid/file-capabilities. Otherwise, the<br>
&gt; kernel is trusting the userspace filesystem to not cause a privilege<b=
r>
&gt; escalation, potentially in excess of the privileges of the userspace<b=
r>
&gt; filesystem daemon itself.</p>
<p dir=3D"ltr">On AOSP yes others no. BTW I&#39;m not condoning doing this =
either.</p>
<p dir=3D"ltr">&gt;<br>
&gt; Aside from that, you would also need to configure SELinux to use xattr=
s<br>
&gt; from fuse (i.e. fs_use_xattr fuse ...), and change the daemon to suppo=
rt<br>
&gt; getxattr, and ensure that you do not have the deadlock problem that<br=
>
&gt; exists with upstream FUSE where it</p>
<p dir=3D"ltr">This old problem, I think if you don&#39;t use libfuse you c=
an get around it.</p>
<p dir=3D"ltr"> does not support handling a getxattr<br>
&gt; request on the root directory during the mount(2) call.=C2=A0 And doin=
g this<br>
&gt; would affect all fuse mounts (e.g. /storage/emulated), not just a<br>
&gt; specific one.=C2=A0 There was an attempt to add per-subtype support fo=
r<br>
&gt; fs_use so that one could specify a different labeling behavior for a<b=
r>
&gt; specific kind of fuse filesystem, see kernel commit<br>
&gt; 102aefdda4d8275ce7d7100bc16c88c74272b260, but this was reverted in<br>
&gt; 4d546f81717d253ab67643bf072c6d8821a9249c and<br>
&gt; 29b1deb2a48a9dd02b93597aa4c055a24c0e989f as it did not work and caused=
 a<br>
&gt; deadlock for other fuse filesystems.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--089e016819ae280110051a86c557--
