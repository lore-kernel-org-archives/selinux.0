Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8LDJidf015572
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 09:19:45 -0400
Received: by mail-wr1-f45.google.com with SMTP id k5-v6so12824845wre.10
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 06:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQG3_aUEJW8fbz8sRtTPRcw2KUsQ+wtr3+-awjcws+PD0w@mail.gmail.com>
 <pjdfty3447g.fsf@redhat.com>
 <CAFPpqQFtafLC+jp29jmR4o1uH6rjYWAWtX+j9ZoM+0Z90K9Eiw@mail.gmail.com>
In-Reply-To: <CAFPpqQFtafLC+jp29jmR4o1uH6rjYWAWtX+j9ZoM+0Z90K9Eiw@mail.gmail.com>
From: Ted Toth <txtoth@gmail.com>
Date: Fri, 21 Sep 2018 08:19:08 -0500
Message-ID: <CAFPpqQGsx6RK+4FT6waNY7+t860X5r7Wb2ai=RkpyrEj095+yw@mail.gmail.com>
To: "pla >> Petr Lautrbach" <plautrba@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000b781540576617c27"
Subject: Re: file context not being set on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000b781540576617c27
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 21, 2018 at 7:21 AM Ted Toth <txtoth@gmail.com> wrote:

>
> On Fri, Sep 21, 2018 at 3:58 AM Petr Lautrbach <plautrba@redhat.com>
> wrote:
>
>>
>> Ted Toth <txtoth@gmail.com> writes:
>>
>> > I have something very much like the following in an fc file:
>> > /usr/lib64/python2\.(6|7)/site-packages/xyz/paste     --
>> > gen_context(system_u:object_r:jxyz_exec_t,s0)
>> >
>> > and I use the same file on el6 and el7. On el6 the file is
>> > labeled as
>> > specified in the python2.6 directory. However on el7 where the
>> > file gets
>> > installed into python2.7 the file is not labeled correctly. On
>> > el7
>> > `semanage fcontext -l | grep xyz` shows the file context
>> > expected but
>> > `matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste` does
>> > not return
>> > the expected context and `restorecon -RFv
>> > /usr/lib64/python2.7/site-packages/xyz` has no affect. The type
>> > xyz_exec_t
>> > exists on both systems. It's probably something stupid I'm doing
>> > but I'm
>> > just not seeing it. Has anyone else experienced similar issues?
>> >
>>
>> There's equivalency rule /usr/lib64 -> /usr/lib on el7:
>>
>> # semanage fcontext -a -t tmp_t
>>   '/usr/lib64/python2\.(6|7)/site-packages/xyz/paste'
>>
>> ValueError: File spec
>> /usr/lib64/python2\.(6|7)/site-packages/xyz/paste conflicts with
>> equivalency rule '/usr/lib64 /usr/lib'; Try adding
>> '/usr/lib/python2\.(6|7)/site-packages/xyz/paste' instead
>>
>>
>> # semanage fcontext -a -t tmp_t
>>   '/usr/lib/python2\.(6|7)/site-packages/xyz/paste'
>>
>> # matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste
>> /usr/lib64/python2.7/site-packages/xyz/paste
>> system_u:object_r:tmp_t:s0
>>
>>
>> Petr
>>
>
> Thanks, where is this equivalency rule defined/documented?
>

/usr/lib(64)?/python... doesn't work either how can I make it backward
compatible?

--000000000000b781540576617c27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri=
, Sep 21, 2018 at 7:21 AM Ted Toth &lt;<a href=3D"mailto:txtoth@gmail.com">=
txtoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Sep 2=
1, 2018 at 3:58 AM Petr Lautrbach &lt;<a href=3D"mailto:plautrba@redhat.com=
" target=3D"_blank">plautrba@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><br>
Ted Toth &lt;<a href=3D"mailto:txtoth@gmail.com" target=3D"_blank">txtoth@g=
mail.com</a>&gt; writes:<br>
<br>
&gt; I have something very much like the following in an fc file:<br>
&gt; /usr/lib64/python2\.(6|7)/site-packages/xyz/paste=C2=A0 =C2=A0 =C2=A0-=
-<br>
&gt; gen_context(system_u:object_r:jxyz_exec_t,s0)<br>
&gt;<br>
&gt; and I use the same file on el6 and el7. On el6 the file is <br>
&gt; labeled as<br>
&gt; specified in the python2.6 directory. However on el7 where the <br>
&gt; file gets<br>
&gt; installed into python2.7 the file is not labeled correctly. On <br>
&gt; el7<br>
&gt; `semanage fcontext -l | grep xyz` shows the file context <br>
&gt; expected but<br>
&gt; `matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste` does <br>
&gt; not return<br>
&gt; the expected context and `restorecon -RFv<br>
&gt; /usr/lib64/python2.7/site-packages/xyz` has no affect. The type <br>
&gt; xyz_exec_t<br>
&gt; exists on both systems. It&#39;s probably something stupid I&#39;m doi=
ng <br>
&gt; but I&#39;m<br>
&gt; just not seeing it. Has anyone else experienced similar issues?<br>
&gt;<br>
<br>
There&#39;s equivalency rule /usr/lib64 -&gt; /usr/lib on el7:<br>
<br>
# semanage fcontext -a -t tmp_t <br>
=C2=A0 &#39;/usr/lib64/python2\.(6|7)/site-packages/xyz/paste&#39;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
ValueError: File spec <br>
/usr/lib64/python2\.(6|7)/site-packages/xyz/paste conflicts with <br>
equivalency rule &#39;/usr/lib64 /usr/lib&#39;; Try adding <br>
&#39;/usr/lib/python2\.(6|7)/site-packages/xyz/paste&#39; instead<br>
<br>
<br>
# semanage fcontext -a -t tmp_t <br>
=C2=A0 &#39;/usr/lib/python2\.(6|7)/site-packages/xyz/paste&#39; <br>
<br>
# matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste<br>
/usr/lib64/python2.7/site-packages/xyz/paste <br>
system_u:object_r:tmp_t:s0<br>
<br>
<br>
Petr<br></blockquote><div><br></div><div>Thanks, where is this equivalency =
rule defined/documented?=C2=A0</div></div></div></blockquote><div><br></div=
><div>/usr/lib(64)?/python... doesn&#39;t work either how can I make it bac=
kward compatible?</div><div><br></div><div>=C2=A0</div></div></div>

--000000000000b781540576617c27--
