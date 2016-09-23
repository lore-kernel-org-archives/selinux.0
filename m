MIME-Version: 1.0
In-Reply-To: <57E58A06.90103@quarksecurity.com>
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
 <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
 <57E534DE.9070500@quarksecurity.com>
 <CAFftDdqs21PprRVRYfMjHXH2Qe7x3eYz8cR2M-bLbTso9HdnoQ@mail.gmail.com>
 <57E58A06.90103@quarksecurity.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 23 Sep 2016 13:03:59 -0700
Message-ID: <CAFftDdoE+9Q+kWg2SjNWXQzSjYx5MxahoYydNVo45h+4n5O8aw@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Daniel Cashman <dcashman@android.com>
Content-Type: multipart/alternative; boundary=001a114457b0796fca053d3247e1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114457b0796fca053d3247e1
Content-Type: text/plain; charset=UTF-8

On Sep 23, 2016 13:01, "Joshua Brindle" <brindle@quarksecurity.com> wrote:
>
> William Roberts wrote:
>>
>> On Fri, Sep 23, 2016 at 6:57 AM, Joshua Brindle
>> <brindle@quarksecurity.com>  wrote:
>>>
>>> William Roberts wrote:
>>>>
>>>> On Sep 22, 2016 9:18 PM, "Jeffrey Vander Stoep"<jeffv@google.com>
 wrote:
>>>>>
>>>>> Remember to test on the Mac build. About a year ago I moved the host
side
>>>>
>>>> tools over to upstream libselinux, but had to revert because it broke
the
>>>> Mac build in multiple places. Since then Richard Haines has done a lot
of
>>>> work to reduce the diff between upstream and the Android fork.
Hopefully
>>>> that will reduce your effort.
>>>>
>>>> Yeah I'm quite concerned about the Mac build, does anyone on here have
>>>> access to a Mac for testing?
>>>
>>>
>>> I do, let me know when you have a branch you need looked at and I'll
try to
>>> get to it.
>>
>>
>> Feel free to test the fork-kill branch from my github, you should find
>> the details
>> below from a previous message in the thread.
>>
>
> Sure,
>
> Mac uses llvm which seems to catch much more than gcc, I have to get rid
of Werror to even get partially through a build. First issues:

Thanks Josh, I'll look at these and prep patches. Weird Android builds with
clang,
I wonder why it's not catching some of these.

>
> genbools.c:71:9: warning: unused variable 'size' [-Wunused-variable]
>         size_t size = 0;
>                ^
> 1 warning generated.
> cc -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2 -I.
-I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o genusers.o
genusers.c
> genusers.c:39:9: warning: unused variable 'len' [-Wunused-variable]
>         size_t len = 0;
>                ^
> genusers.c:63:14: warning: variable 'nread' is uninitialized when used
here [-Wuninitialized]
>                 if (buffer[nread - 1] == '\n')
>                            ^~~~~
> genusers.c:40:15: note: initialize the variable 'nread' to silence this
warning
>         ssize_t nread;
>                      ^
>                       = 0
>
> but the .symver actually kills it altogether (I get a lot of these):
>
> <inline asm>:10:1: error: unknown directive
> .symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1
> ^
>

--001a114457b0796fca053d3247e1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 23, 2016 13:01, &quot;Joshua Brindle&quot; &lt;<a hre=
f=3D"mailto:brindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; William Roberts wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Sep 23, 2016 at 6:57 AM, Joshua Brindle<br>
&gt;&gt; &lt;<a href=3D"mailto:brindle@quarksecurity.com">brindle@quarksecu=
rity.com</a>&gt;=C2=A0 wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; William Roberts wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Sep 22, 2016 9:18 PM, &quot;Jeffrey Vander Stoep&quot;&=
lt;<a href=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt;=C2=A0 =C2=
=A0wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Remember to test on the Mac build. About a year ago I =
moved the host side<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; tools over to upstream libselinux, but had to revert becau=
se it broke the<br>
&gt;&gt;&gt;&gt; Mac build in multiple places. Since then Richard Haines ha=
s done a lot of<br>
&gt;&gt;&gt;&gt; work to reduce the diff between upstream and the Android f=
ork. Hopefully<br>
&gt;&gt;&gt;&gt; that will reduce your effort.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yeah I&#39;m quite concerned about the Mac build, does any=
one on here have<br>
&gt;&gt;&gt;&gt; access to a Mac for testing?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I do, let me know when you have a branch you need looked at an=
d I&#39;ll try to<br>
&gt;&gt;&gt; get to it.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Feel free to test the fork-kill branch from my github, you should =
find<br>
&gt;&gt; the details<br>
&gt;&gt; below from a previous message in the thread.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Sure,<br>
&gt;<br>
&gt; Mac uses llvm which seems to catch much more than gcc, I have to get r=
id of Werror to even get partially through a build. First issues:</p>
<p dir=3D"ltr">Thanks Josh, I&#39;ll look at these and prep patches. Weird =
Android builds with clang,<br>
I wonder why it&#39;s not catching some of these.</p>
<p dir=3D"ltr">&gt;<br>
&gt; genbools.c:71:9: warning: unused variable &#39;size&#39; [-Wunused-var=
iable]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size =3D 0;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; 1 warning generated.<br>
&gt; cc -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2 -I. -I../i=
nclude -D_GNU_SOURCE -I../cil/include -fPIC -c -o genusers.o genusers.c<br>
&gt; genusers.c:39:9: warning: unused variable &#39;len&#39; [-Wunused-vari=
able]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len =3D 0;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; genusers.c:63:14: warning: variable &#39;nread&#39; is uninitialized w=
hen used here [-Wuninitialized]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buffer[nre=
ad - 1] =3D=3D &#39;\n&#39;)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~<br>
&gt; genusers.c:40:15: note: initialize the variable &#39;nread&#39; to sil=
ence this warning<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t nread;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 0<br>
&gt;<br>
&gt; but the .symver actually kills it altogether (I get a lot of these):<b=
r>
&gt;<br>
&gt; &lt;inline asm&gt;:10:1: error: unknown directive<br>
&gt; .symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL=
_1.1<br>
&gt; ^<br>
&gt;</p>

--001a114457b0796fca053d3247e1--
