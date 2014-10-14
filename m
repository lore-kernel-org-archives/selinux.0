MIME-Version: 1.0
In-Reply-To: <543D36DC.8060202@tycho.nsa.gov>
References: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
 <543D36DC.8060202@tycho.nsa.gov>
Date: Tue, 14 Oct 2014 08:00:26 -0700
Message-ID: <CAFftDdpSxAHnNKHG+TGVBdWz6uxt_RKeo_BMbQ5UtpB_Q=Bg1w@mail.gmail.com>
Subject: Re: fs_use_trans
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113a9dd48ac7e105056346fa
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a9dd48ac7e105056346fa
Content-Type: text/plain; charset=UTF-8

Yeah looking at this statement doesn't really just allow for the use of
type_transition statements on that filesystem? It doesn't actually generate
labels, you still need the typetrans rule. It appears that the definition
is overreaching for its actual function and probably inferring something
from refpolicy.
On Oct 14, 2014 7:48 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On 10/10/2014 07:05 PM, William Roberts wrote:
> > The docs for fs_use_trans state:
> >
> > The fs_use_trans statement is used to allocate a security context to
> > pseudo filesystems such as pseudo terminals and temporary objects. The
> > assigned context is derived from the creating process and that of the
> > filesystem type based on transition rules.
> >
> >
> > Can someone give me an example? For instance if I had:
> >
> > fs_use_trans devpts u:object_r:devpts:s0;
> >
> > and a daemon running with context:
> > u:r:init:s0
> >
> > and it creates something on the devpts, what is the resulting context
> > of the object?
>
> It depends on whether you have a type_transition rule defined in policy.
> For example, in the Android policy, we have the create_pty() macro
> defined in te_macros, and if you had create_pty(init) in your policy,
> then it would set up a type transition so that any pty created by init
> would be labeled with a init_devpts type rather than just devpts.
>
>
>
>

--001a113a9dd48ac7e105056346fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Yeah looking at this statement doesn&#39;t really just allow=
 for the use of type_transition statements on that filesystem? It doesn&#39=
;t actually generate labels, you still need the typetrans rule. It appears =
that the definition is overreaching for its actual function and probably in=
ferring something from refpolicy.</p>
<div class=3D"gmail_quote">On Oct 14, 2014 7:48 AM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 10/10/2014 07=
:05 PM, William Roberts wrote:<br>
&gt; The docs for fs_use_trans state:<br>
&gt;<br>
&gt; The fs_use_trans statement is used to allocate a security context to<b=
r>
&gt; pseudo filesystems such as pseudo terminals and temporary objects. The=
<br>
&gt; assigned context is derived from the creating process and that of the<=
br>
&gt; filesystem type based on transition rules.<br>
&gt;<br>
&gt;<br>
&gt; Can someone give me an example? For instance if I had:<br>
&gt;<br>
&gt; fs_use_trans devpts u:object_r:devpts:s0;<br>
&gt;<br>
&gt; and a daemon running with context:<br>
&gt; u:r:init:s0<br>
&gt;<br>
&gt; and it creates something on the devpts, what is the resulting context<=
br>
&gt; of the object?<br>
<br>
It depends on whether you have a type_transition rule defined in policy.<br=
>
For example, in the Android policy, we have the create_pty() macro<br>
defined in te_macros, and if you had create_pty(init) in your policy,<br>
then it would set up a type transition so that any pty created by init<br>
would be labeled with a init_devpts type rather than just devpts.<br>
<br>
<br>
<br>
</blockquote></div>

--001a113a9dd48ac7e105056346fa--
