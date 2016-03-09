MIME-Version: 1.0
In-Reply-To: <56DED6C6.4000407@tycho.nsa.gov>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
 <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
 <56DED6C6.4000407@tycho.nsa.gov>
Date: Tue, 8 Mar 2016 21:18:55 -0800
Message-ID: <CAFftDdq_g07J-0LufxQM+5Bjxmk_LuVhAZ+aXU0zwu=GSjtwVg@mail.gmail.com>
Subject: Re: initial_sid context via libsepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1140cd049913cd052d96d59e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140cd049913cd052d96d59e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 8, 2016 05:41, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 03/07/2016 08:32 PM, William Roberts wrote:
>>
>>
>>
>> On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov
>> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>>     On 03/07/2016 01:44 PM, Stephen Smalley wrote:
>>
>>         On 03/07/2016 10:41 AM, Richard Haines wrote:
>>
>>
>>
>>
>>
>>
>>                 On Saturday, 5 March 2016, 14:48, Richard Haines
>>                 <richard_c_haines@btinternet.com
>>                 <mailto:richard_c_haines@btinternet.com>> wrote:
>>
>>
>>
>>
>>
>>                 On Friday, 4 March 2016, 21:18, "Roberts, William C"
>>                 <william.c.roberts@intel.com
>>                 <mailto:william.c.roberts@intel.com>> wrote:
>>
>>
>>
>>
>>
>>
>>                     How can one obtain the same value as
>>                     /sys/fs/selinux/initial_contexts/file
>>
>>                 via libsepol?
>>
>>
>>                     I=E2=80=99ve been digging around libsepol and its no=
t quite
>>                     clear to me.
>>
>>                     It looks as though the record is here:
>>                                       context_struct_t *a =3D &((policyd=
b_t
>>
>>                 *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>
>>                                       context_struct_t *b =3D &((policyd=
b_t
>>
>>                 *)pol.db)->ocontexts[OCON_ISID]->context[1];
>>
>>
>>                                       printf("%u\n", a->type);
>>                                       printf("%u\n",b->type);
>>
>>                     Prints:
>>                     185
>>                     0
>>
>>                     Not sure if this is right, and how to format the
>>                     context struct to a
>>                     string.
>>
>>                 I didn=E2=80=99t see any helpers.
>>
>>
>>
>>
>>
>>                 I've attached an example, hope it's useful
>>
>>
>>             I've updated the example with more detail and display SID
>>             name using
>>             SID value not counter.
>>
>>
>>         Any particular reason you didn't use sepol_sid_to_context()?
>>
>>
>>     I guess context_to_string() on the context structure would work
>>     better for your purposes.   sepol_sid_to_context() would require
>>     loading the sidtab via policydb_load_isids() and setting the
>>     internal policydb to the one you loaded via sepol_set_policydb().
>>
>>
>>
>> Seems as though its not exported api, but it does indeed print something=
:
>> code:
>> char *s;
>> size_t len;
>> context_struct_t *a =3D &((policydb_t
>> *)pol.db)->ocontexts[OCON_ISID]->context[0];
>>
>> int rc =3D context_to_string(pol.handle, (policydb_t *)pol.db, a, &s,
&len);
>>
>> printf("rc: %d\n", rc);
>> printf("con: %s\n", s);
>>
>> prints:
>>    rc: 0
>>    con: u:object_r:null_device:s0
>>
>> However, I am after the initial sid for file, which this isn't it... is
>> it in the ocontexts array under a different index?
>
>
> ocontext[OCON_ISID] points to the head of a linked list of initial SIDs,
with the values in ->sid[0] and the context structures in ->context[0].
Richard's sample program showed you how to walk it and print out all the
entries.  The symbolic names themselves aren't in the policydb, as he
noted; you can grab it from the kernel source
(linux/security/selinux/include/initial_sid_to_string.h) or from the
refpolicy (run make in refpolicy/policy/flask and grab
kernel/initial_sid_to_string.h).

I was hoping there was something I was missing between what you were
posting and Richards sample. Looks like it's all by ordinal, so
(conjecturing here) initial sid ordering must match the kernel header
ordering as far as I can tell, is that right?

Something must remap it in the kernel from initial sid to class.

I was hoping there would be a clean way to grab this from the policy for
use in fs_config tools under build, but just hard coding the default
context string seems to be the best approach.

>

--001a1140cd049913cd052d96d59e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Mar 8, 2016 05:41, &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:sds=
@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 03/07/2016 08:32 PM, William Roberts wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Mar 7, 2016 at 12:32 PM, Stephen Smalley &lt;<a href=3D"ma=
ilto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov<=
/a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 On 03/07/2016 01:44 PM, Stephen Smalley wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 On 03/07/2016 10:41 AM, Richard Haines=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Saturda=
y, 5 March 2016, 14:48, Richard Haines<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a hre=
f=3D"mailto:richard_c_haines@btinternet.com">richard_c_haines@btinternet.co=
m</a><br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto=
:<a href=3D"mailto:richard_c_haines@btinternet.com">richard_c_haines@btinte=
rnet.com</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Friday,=
 4 March 2016, 21:18, &quot;Roberts, William C&quot;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a hre=
f=3D"mailto:william.c.roberts@intel.com">william.c.roberts@intel.com</a><br=
>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto=
:<a href=3D"mailto:william.c.roberts@intel.com">william.c.roberts@intel.com=
</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 How can one obtain the same value as<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /sys/fs/selinux/initial_contexts/file<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 via libsep=
ol?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 I=E2=80=99ve been digging around libsepol and its not quite<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 clear to me.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 It looks as though the record is here:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_=
struct_t *a =3D &amp;((policydb_t<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)pol.db)-=
&gt;ocontexts[OCON_ISID]-&gt;context[0];<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_=
struct_t *b =3D &amp;((policydb_t<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)pol.db)-=
&gt;ocontexts[OCON_ISID]-&gt;context[1];<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&=
quot;%u\n&quot;, a-&gt;type);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&=
quot;%u\n&quot;,b-&gt;type);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Prints:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 185<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Not sure if this is right, and how to format the<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 context struct to a<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 string.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I didn=E2=
=80=99t see any helpers.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I&#39;ve a=
ttached an example, hope it&#39;s useful<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I&#39;ve updated the exa=
mple with more detail and display SID<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name using<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SID value not counter.<b=
r>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Any particular reason you didn&#39;t u=
se sepol_sid_to_context()?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 I guess context_to_string() on the context structure=
 would work<br>
&gt;&gt; =C2=A0 =C2=A0 better for your purposes.=C2=A0 =C2=A0sepol_sid_to_c=
ontext() would require<br>
&gt;&gt; =C2=A0 =C2=A0 loading the sidtab via policydb_load_isids() and set=
ting the<br>
&gt;&gt; =C2=A0 =C2=A0 internal policydb to the one you loaded via sepol_se=
t_policydb().<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Seems as though its not exported api, but it does indeed print som=
ething:<br>
&gt;&gt; code:<br>
&gt;&gt; char *s;<br>
&gt;&gt; size_t len;<br>
&gt;&gt; context_struct_t *a =3D &amp;((policydb_t<br>
&gt;&gt; *)pol.db)-&gt;ocontexts[OCON_ISID]-&gt;context[0];<br>
&gt;&gt;<br>
&gt;&gt; int rc =3D context_to_string(pol.handle, (policydb_t *)pol.db, a, =
&amp;s, &amp;len);<br>
&gt;&gt;<br>
&gt;&gt; printf(&quot;rc: %d\n&quot;, rc);<br>
&gt;&gt; printf(&quot;con: %s\n&quot;, s);<br>
&gt;&gt;<br>
&gt;&gt; prints:<br>
&gt;&gt; =C2=A0 =C2=A0rc: 0<br>
&gt;&gt; =C2=A0 =C2=A0con: u:object_r:null_device:s0<br>
&gt;&gt;<br>
&gt;&gt; However, I am after the initial sid for file, which this isn&#39;t=
 it... is<br>
&gt;&gt; it in the ocontexts array under a different index?<br>
&gt;<br>
&gt;<br>
&gt; ocontext[OCON_ISID] points to the head of a linked list of initial SID=
s, with the values in -&gt;sid[0] and the context structures in -&gt;contex=
t[0].=C2=A0 Richard&#39;s sample program showed you how to walk it and prin=
t out all the entries.=C2=A0 The symbolic names themselves aren&#39;t in th=
e policydb, as he noted; you can grab it from the kernel source (linux/secu=
rity/selinux/include/initial_sid_to_string.h) or from the refpolicy (run ma=
ke in refpolicy/policy/flask and grab kernel/initial_sid_to_string.h).</p>
<p dir=3D"ltr">I was hoping there was something I was missing between what =
you were posting and Richards sample. Looks like it&#39;s all by ordinal, s=
o (conjecturing here) initial sid ordering must match the kernel header ord=
ering as far as I can tell, is that right?</p>
<p dir=3D"ltr">Something must remap it in the kernel from initial sid to cl=
ass.</p>
<p dir=3D"ltr">I was hoping there would be a clean way to grab this from th=
e policy for use in fs_config tools under build, but just hard coding the d=
efault context string seems to be the best approach.</p>
<p dir=3D"ltr">&gt;<br>
</p>

--001a1140cd049913cd052d96d59e--
