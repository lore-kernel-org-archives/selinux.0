MIME-Version: 1.0
In-Reply-To: <56E02EAE.3090505@tycho.nsa.gov>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
 <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
 <56DED6C6.4000407@tycho.nsa.gov>
 <CAFftDdq_g07J-0LufxQM+5Bjxmk_LuVhAZ+aXU0zwu=GSjtwVg@mail.gmail.com>
 <56E02EAE.3090505@tycho.nsa.gov>
Date: Wed, 9 Mar 2016 07:37:45 -0800
Message-ID: <CAFftDdqXCVruri3+49z33CPZYzbtQDqXi_igQTuSmku0qER2-Q@mail.gmail.com>
Subject: Re: initial_sid context via libsepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e01183d14bf43af052d9f7aa9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e01183d14bf43af052d9f7aa9
Content-Type: text/plain; charset=UTF-8

>
> <snip>
>> SIDs, with the values in ->sid[0] and the context structures in
>> ->context[0].  Richard's sample program showed you how to walk it and
>> print out all the entries.  The symbolic names themselves aren't in the
>> policydb, as he noted; you can grab it from the kernel source
>> (linux/security/selinux/include/initial_sid_to_string.h) or from the
>> refpolicy (run make in refpolicy/policy/flask and grab
>> kernel/initial_sid_to_string.h).
>>
>> I was hoping there was something I was missing between what you were
>> posting and Richards sample. Looks like it's all by ordinal, so
>> (conjecturing here) initial sid ordering must match the kernel header
>> ordering as far as I can tell, is that right?
>>
>> Something must remap it in the kernel from initial sid to class.
>>
>> I was hoping there would be a clean way to grab this from the policy for
>> use in fs_config tools under build, but just hard coding the default
>> context string seems to be the best approach.
>>
>
> I don't know what you are doing, but the initial SID context is not what
> you want for fs_config.  You want the result of selabel_lookup(), just as
> is done by system/extras/ext4_utils to label files in the generated images.
>
>
>
>
I came accross this in build/tools/fs_config/fs_config.c:


      char* secontext;
      if (selabel_lookup(sehnd, &secontext, full_name, ( mode | (is_dir ?
S_IFDIR : S_IFREG)))) {
        secontext = strdup("u:object_r:unlabeled:s0");
      }

      printf(" selabel=%s", secontext);
      free(full_name);
      freecon(secontext);


commit 0eb17d944704b3eb140bb9dded299d3be3aed77e
Author: Nick Kralevich <nnk@google.com>

I was just poking around at things to figure out what the intent is.

I am assuming I have something like /foobar, it will fail on labeling since
their is no match. At which point
you would want to default to the initial sid for file.

I was investigating how difficult it would be to not hardcode this value
and retrieve it from sepol, which seems
like more work than its worth.

-- 
Respectfully,

William C Roberts

--089e01183d14bf43af052d9f7aa9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><div><div class=3D"h5">&lt;snip&gt;<br>
SIDs, with the values in -&gt;sid[0] and the context structures in<br>
-&gt;context[0].=C2=A0 Richard&#39;s sample program showed you how to walk =
it and<br>
print out all the entries.=C2=A0 The symbolic names themselves aren&#39;t i=
n the<br>
policydb, as he noted; you can grab it from the kernel source<br>
(linux/security/selinux/include/initial_sid_to_string.h) or from the<br>
refpolicy (run make in refpolicy/policy/flask and grab<br>
kernel/initial_sid_to_string.h).<br>
<br>
I was hoping there was something I was missing between what you were<br>
posting and Richards sample. Looks like it&#39;s all by ordinal, so<br>
(conjecturing here) initial sid ordering must match the kernel header<br>
ordering as far as I can tell, is that right?<br>
<br>
Something must remap it in the kernel from initial sid to class.<br>
<br>
I was hoping there would be a clean way to grab this from the policy for<br=
>
use in fs_config tools under build, but just hard coding the default<br>
context string seems to be the best approach.<br>
</div></div></blockquote>
<br>
I don&#39;t know what you are doing, but the initial SID context is not wha=
t you want for fs_config.=C2=A0 You want the result of selabel_lookup(), ju=
st as is done by system/extras/ext4_utils to label files in the generated i=
mages.<br>
<br>
<br>
<br>
</blockquote></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">I came accross this in build/tools/fs_config/fs_config.c:</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 char*=
 secontext;</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 if (selabe=
l_lookup(sehnd, &amp;secontext, full_name, ( mode | (is_dir ? S_IFDIR : S_I=
FREG)))) {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 seco=
ntext =3D strdup(&quot;u:object_r:unlabeled:s0&quot;);</div><div class=3D"g=
mail_extra">=C2=A0 =C2=A0 =C2=A0 }</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 printf(&quot; selabel=3D%=
s&quot;, secontext);</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 f=
ree(full_name);</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 freeco=
n(secontext);</div><div><br></div></div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">commit 0eb17d944704b3eb140bb9dded299d3be3aed77=
e<br></div><div class=3D"gmail_extra"><div class=3D"gmail_extra">Author: Ni=
ck Kralevich &lt;<a href=3D"mailto:nnk@google.com">nnk@google.com</a>&gt;</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I was j=
ust poking around at things to figure out what the intent is.=C2=A0<br></di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I am assu=
ming I have something like /foobar, it will fail on labeling since their is=
 no match. At which point</div><div class=3D"gmail_extra">you would want to=
 default to the initial sid for file.</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">I was investigating how difficult it would =
be to not hardcode this value and retrieve it from sepol, which seems</div>=
<div class=3D"gmail_extra">like more work than its worth.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">--=C2=A0<br></div></d=
iv><div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br=
><br></div>
</div></div>

--089e01183d14bf43af052d9f7aa9--
