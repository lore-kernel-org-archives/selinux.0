MIME-Version: 1.0
In-Reply-To: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
References: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 7 Apr 2017 11:51:39 -0700
Message-ID: <CAFftDdqY3Xy8U8Jvf9U8yYmUcu0291Xkq0Ev=1b8a7+4wYmUSQ@mail.gmail.com>
Subject: Re: MLS directory label inheritance rules
To: Nick Kralevich <nnk@google.com>
Cc: SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113e586ea8da6b054c981d0d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113e586ea8da6b054c981d0d
Content-Type: text/plain; charset=UTF-8

On Apr 7, 2017 11:41, "Nick Kralevich" <nnk@google.com> wrote:

When a file is created in a directory, the default label for the file
is based on the label of the enclosing directory (unless something
like setfscreatecon is used). For example:

bullhead:/ # cd /data/misc/zoneinfo/

bullhead:/data/misc/zoneinfo # ls -ladZ .
drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
1971-06-19 17:07 .
bullhead:/data/misc/zoneinfo # touch asdf
bullhead:/data/misc/zoneinfo # ls -ladZ . asdf

drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
2017-04-07 18:32 .
-rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
2017-04-07 18:32 asdf

note how the label of the "asdf" file matches the label of the
enclosing directory.

However, that's not true when the directory uses categories. In that
case, the newly created file inherits the label, but not the
categories. For example:

bullhead:/data/data # cd /data/data/com.android.chrome
bullhead:/data/data/com.android.chrome # ls -ladZ .
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
1971-07-15 15:31 .
bullhead:/data/data/com.android.chrome # touch asdf
bullhead:/data/data/com.android.chrome # ls -laZd . asdf
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
2017-04-07 18:35 .
-rw-rw-rw- 1 root   root   u:object_r:app_data_file:s0              0
2017-04-07 18:35 asdf

Note how the label is maintained, but the "c512,c768" portion is not
maintained. While this example occurs when I'm running in a permissive
domain, it also occurs in an enforcing domain.

The inconsistency seems weird, and I'm sure there's a good reason why
this occurs that I'm not familiar with. Can someone help me understand
if this is expected, and if so, why?


If you write top secret data it should stay top secret even if you're
writing to a folder that is normally reserved for secret data, or perhaps
mixed data. Iirc it uses the MLS of the process when creating the file
entry.


--
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113e586ea8da6b054c981d0d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 7, 2017 11:41, &quot;Nick Kralevich&quot; &lt;<a href=3D"m=
ailto:nnk@google.com">nnk@google.com</a>&gt; wrote:<br type=3D"attribution"=
><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">When a file is created in a directory, the defaul=
t label for the file<br>
is based on the label of the enclosing directory (unless something<br>
like setfscreatecon is used). For example:<br>
<br>
bullhead:/ # cd /data/misc/zoneinfo/<br>
<br>
bullhead:/data/misc/zoneinfo # ls -ladZ .<br>
drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:<wbr>s0 4096<br>
1971-06-19 17:07 .<br>
bullhead:/data/misc/zoneinfo # touch asdf<br>
bullhead:/data/misc/zoneinfo # ls -ladZ . asdf<br>
<br>
drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:<wbr>s0 4096<br>
2017-04-07 18:32 .<br>
-rw-rw-rw- 1 root=C2=A0 =C2=A0root=C2=A0 =C2=A0u:object_r:zoneinfo_data_fil=
e:<wbr>s0=C2=A0 =C2=A0 0<br>
2017-04-07 18:32 asdf<br>
<br>
note how the label of the &quot;asdf&quot; file matches the label of the<br=
>
enclosing directory.<br>
<br>
However, that&#39;s not true when the directory uses categories. In that<br=
>
case, the newly created file inherits the label, but not the<br>
categories. For example:<br>
<br>
bullhead:/data/data # cd /data/data/com.android.chrome<br>
bullhead:/data/data/com.<wbr>android.chrome # ls -ladZ .<br>
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:<wbr>c512,c768 4096<=
br>
1971-07-15 15:31 .<br>
bullhead:/data/data/com.<wbr>android.chrome # touch asdf<br>
bullhead:/data/data/com.<wbr>android.chrome # ls -laZd . asdf<br>
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:<wbr>c512,c768 4096<=
br>
2017-04-07 18:35 .<br>
-rw-rw-rw- 1 root=C2=A0 =C2=A0root=C2=A0 =C2=A0u:object_r:app_data_file:s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
2017-04-07 18:35 asdf<br>
<br>
Note how the label is maintained, but the &quot;c512,c768&quot; portion is =
not<br>
maintained. While this example occurs when I&#39;m running in a permissive<=
br>
domain, it also occurs in an enforcing domain.<br>
<br>
The inconsistency seems weird, and I&#39;m sure there&#39;s a good reason w=
hy<br>
this occurs that I&#39;m not familiar with. Can someone help me understand<=
br>
if this is expected, and if so, why?<br></blockquote></div></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">If you write top secret data it s=
hould stay top secret even if you&#39;re writing to a folder that is normal=
ly reserved for secret data, or perhaps mixed data. Iirc it uses the MLS of=
 the process when creating the file entry.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><b=
lockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<font color=3D"#888888"><br>
--<br>
Nick Kralevich | Android Security | <a href=3D"mailto:nnk@google.com">nnk@g=
oogle.com</a> | <a href=3D"tel:650.214.4037" value=3D"+16502144037">650.214=
.4037</a><br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></blockquote></div><br></div></div></div>

--001a113e586ea8da6b054c981d0d--
