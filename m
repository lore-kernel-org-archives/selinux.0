MIME-Version: 1.0
In-Reply-To: <543D5FDB.7@tycho.nsa.gov>
References: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
 <543D36DC.8060202@tycho.nsa.gov>
 <CAFftDdpSxAHnNKHG+TGVBdWz6uxt_RKeo_BMbQ5UtpB_Q=Bg1w@mail.gmail.com>
 <543D5FDB.7@tycho.nsa.gov>
Date: Tue, 14 Oct 2014 13:14:04 -0700
Message-ID: <CAFftDdqs7eF=NznZSYybN+EbwpjgLfmzVDq8SeKXvon125PRLg@mail.gmail.com>
Subject: Re: fs_use_trans
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bdc17b02c0f44050567a8ee
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bdc17b02c0f44050567a8ee
Content-Type: text/plain; charset=UTF-8

On Oct 14, 2014 10:43 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 10/14/2014 11:00 AM, William Roberts wrote:
> > Yeah looking at this statement doesn't really just allow for the use of
> > type_transition statements on that filesystem? It doesn't actually
generate
> > labels, you still need the typetrans rule. It appears that the
definition
> > is overreaching for its actual function and probably inferring something
> > from refpolicy.
>
> Each of the fs_use_* statements specifies how to determine the label for
> existing inodes in the filesystem.  fs_use_xattr tells SELinux to fetch
> the inode label via ->getxattr().  fs_use_task tells SELinux to assign
> the inode the label of its creator.  fs_use_trans tells SELinux to
> compute the inode label based on the result of security_transition_sid()
> on the creating process SID and the filesystem SID.  What
> security_transition_sid() returns depends on whether or not you have a
> transition rule in policy.  So fs_use_trans doesn't guarantee that you
> have a transition rule in place; it just allows you to use transition
> rules if you wish to label the inodes based on some combination of the
> creating process domain and the filesystem type.
>
>
OK that makes more sense to me than the other documents I read. Thanks.

--047d7bdc17b02c0f44050567a8ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Oct 14, 2014 10:43 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/14/2014 11:00 AM, William Roberts wrote:<br>
&gt; &gt; Yeah looking at this statement doesn&#39;t really just allow for =
the use of<br>
&gt; &gt; type_transition statements on that filesystem? It doesn&#39;t act=
ually generate<br>
&gt; &gt; labels, you still need the typetrans rule. It appears that the de=
finition<br>
&gt; &gt; is overreaching for its actual function and probably inferring so=
mething<br>
&gt; &gt; from refpolicy.<br>
&gt;<br>
&gt; Each of the fs_use_* statements specifies how to determine the label f=
or<br>
&gt; existing inodes in the filesystem.=C2=A0 fs_use_xattr tells SELinux to=
 fetch<br>
&gt; the inode label via -&gt;getxattr().=C2=A0 fs_use_task tells SELinux t=
o assign<br>
&gt; the inode the label of its creator.=C2=A0 fs_use_trans tells SELinux t=
o<br>
&gt; compute the inode label based on the result of security_transition_sid=
()<br>
&gt; on the creating process SID and the filesystem SID.=C2=A0 What<br>
&gt; security_transition_sid() returns depends on whether or not you have a=
<br>
&gt; transition rule in policy.=C2=A0 So fs_use_trans doesn&#39;t guarantee=
 that you<br>
&gt; have a transition rule in place; it just allows you to use transition<=
br>
&gt; rules if you wish to label the inodes based on some combination of the=
<br>
&gt; creating process domain and the filesystem type.<br>
&gt;<br>
&gt;<br>
OK that makes more sense to me than the other documents I read. Thanks.<br>
</p>

--047d7bdc17b02c0f44050567a8ee--
