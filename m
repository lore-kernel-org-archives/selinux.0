MIME-Version: 1.0
In-Reply-To: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 21 Jan 2017 14:58:22 +0100
Message-ID: <CAJfZ7=kCGyw65inC0yDCcTS5ub+0iuhOs3QT_WsbN_Jd3YDYwQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11401386e9dc1c05469b2888
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11401386e9dc1c05469b2888
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 18, 2017 at 9:53 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> Nicolas Iooss discovered that requiring a type in an optional block
> after the type has already been declared in another optional block
> results in a duplicate declaration error.
>
> The following policy will trigger the error.
>
> optional {
>   type T1;
> }
>
> optional {
>   require { type T1; }
> }
>
> In this case, although symtab_insert() in libsepol properly identifies
> that the first T1 is a declaration while the second is a require, it
> will return -2 which is the return value for a duplicate declaration
> and expect the calling code to properly handle the situation. The
> caller is require_symbol() in checkpolicy and it checks if the previous
> declaration is in the current scope. If it is, then the require can be
> ignored. It also checks to see if the declaration is a type and the
> require an attribute or vice versa which is an error. The problem is
> that -2 is returned if the declaration is not in scope which is
> interpreted as a duplicate declaration error.
>
> The function should return 1 instead which means that they symbol was not
> added and needs to be freed later.


Hello,
I tested your patch with the following policy module written in a file
named testmodule.te:

    module testmodule 1.0.0;
    require { class process { fork }; }
    optional {
      require { attribute ATTR; }
      type TYPE1, ATTR;
    }
    optional {
      require { type TYPE1; }
      allow TYPE1 self:process fork;
    }

checkmodule failed to compile this module:

  testmodule.te:10:ERROR 'This block has no require section.' at token '}'
on line 10:
  }
    allow TYPE1 self:process fork;

Hence I modified the require statement of the second optional block to
"require { type TYPE1, TYPE2; }" and checkmodule reported:

  testmodule.te:9:ERROR 'type TYPE1 is not within scope' at token ';' on
line 9:
    require { type TYPE1, TYPE2; }
    allow TYPE1 self:process fork;

It seems there is a scope issue with TYPE1 when it is used in a block where
it is required. Is this a bug?

Thanks,
Nicolas

PS: while debugging this issue I found some other memory leaks in
checkpolicy. I will send some patches later.

--001a11401386e9dc1c05469b2888
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Jan 18, 2017 at 9:53 PM, James Carter <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jwcart2@tycho.nsa.gov" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Nicol=
as Iooss discovered that requiring a type in an optional block<br>
after the type has already been declared in another optional block<br>
results in a duplicate declaration error.<br>
<br>
The following policy will trigger the error.<br>
<br>
optional {<br>
=C2=A0 type T1;<br>
}<br>
<br>
optional {<br>
=C2=A0 require { type T1; }<br>
}<br>
<br>
In this case, although symtab_insert() in libsepol properly identifies<br>
that the first T1 is a declaration while the second is a require, it<br>
will return -2 which is the return value for a duplicate declaration<br>
and expect the calling code to properly handle the situation. The<br>
caller is require_symbol() in checkpolicy and it checks if the previous<br>
declaration is in the current scope. If it is, then the require can be<br>
ignored. It also checks to see if the declaration is a type and the<br>
require an attribute or vice versa which is an error. The problem is<br>
that -2 is returned if the declaration is not in scope which is<br>
interpreted as a duplicate declaration error.<br>
<br>
The function should return 1 instead which means that they symbol was not<b=
r>
added and needs to be freed later.</blockquote><div><br></div><div>Hello,</=
div><div>I tested your patch with the following policy module written in a =
file named testmodule.te:</div><div><div><br></div><div>=C2=A0 =C2=A0 modul=
e testmodule 1.0.0;</div><div>=C2=A0 =C2=A0=C2=A0require { class process { =
fork }; }</div><div>=C2=A0 =C2=A0=C2=A0optional {</div><div>=C2=A0 =C2=A0=
=C2=A0=C2=A0 require { attribute ATTR; }</div><div>=C2=A0=C2=A0 =C2=A0=C2=
=A0 type TYPE1, ATTR;</div><div>=C2=A0 =C2=A0=C2=A0}</div><div>=C2=A0 =C2=
=A0=C2=A0optional {</div><div>=C2=A0=C2=A0 =C2=A0=C2=A0 require { type TYPE=
1; }</div><div>=C2=A0=C2=A0 =C2=A0=C2=A0 allow TYPE1 self:process fork;</di=
v><div>=C2=A0 =C2=A0=C2=A0}</div></div></div><br></div><div class=3D"gmail_=
extra">checkmodule failed to compile this module:</div><div class=3D"gmail_=
extra"><br></div><div class=3D"gmail_extra">=C2=A0 testmodule.te:10:ERROR &=
#39;This block has no require section.&#39; at token &#39;}&#39; on line 10=
:</div><div class=3D"gmail_extra">=C2=A0 }</div><div class=3D"gmail_extra">=
=C2=A0 =C2=A0 allow TYPE1 self:process fork;</div><div><br></div><div>Hence=
 I modified the require statement of the second optional block to &quot;req=
uire { type TYPE1, TYPE2; }&quot; and checkmodule reported:</div><div><br><=
/div><div><div>=C2=A0 testmodule.te:9:ERROR &#39;type TYPE1 is not within s=
cope&#39; at token &#39;;&#39; on line 9:</div><div>=C2=A0 =C2=A0 require {=
 type TYPE1, TYPE2; }</div><div>=C2=A0 =C2=A0 allow TYPE1 self:process fork=
;</div></div><div><br></div><div>It seems there is a scope issue with TYPE1=
 when it is used in a block where it is required. Is this a bug?</div><div>=
<br></div><div>Thanks,</div><div>Nicolas</div><div><br></div><div>PS: while=
 debugging this issue I found some other memory leaks in checkpolicy. I wil=
l send some patches later.</div></div>

--001a11401386e9dc1c05469b2888--
