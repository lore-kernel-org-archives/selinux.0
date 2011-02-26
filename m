MIME-Version: 1.0
In-Reply-To: <01F4E579-2929-4CB0-B994-1C325DE9E6F7@gmail.com>
References: <AANLkTi=UYvBV9piRpUapcf+6gFyJpOg8yAxt0NG9J_Re@mail.gmail.com>
	<1298642860.13368.15.camel@moss-pluto>
	<01F4E579-2929-4CB0-B994-1C325DE9E6F7@gmail.com>
Date: Fri, 25 Feb 2011 19:51:26 -0800
Message-ID: <AANLkTi=tPBYGsnRmEvsh0PibGMQ_GZ7ZE3rnEFuA6SKs@mail.gmail.com>
Subject: Re: RIP: 0010:[<ffffffff811bdec1>] [<ffffffff811bdec1>] avc_audit_post_callback+0xc6/0xfe
From: Ethan Heidrick <ethanheidrick@gmail.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: multipart/alternative; boundary=00151757468c6882d0049d275c8f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00151757468c6882d0049d275c8f
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I have a similar question concerning the considerations of applying the
debug patch after implementing SeLinux policies, where return object classes
become invalid when applying tagging to TV data modulation over IP or more
specifically over [selected] cables.  The modulation exchange seems to be
creating a buffer value that is not readable on the /sys level and in
structuring bypasses the SeLinux implementation.  Is there options regarding
defining these values in policies being conducted?

thanks
ethan

On Fri, Feb 25, 2011 at 9:18 AM, Justin Mattock <justinmattock@gmail.com>wrote:

>
> On Feb 25, 2011, at 6:07 AM, Stephen Smalley wrote:
>
>  On Thu, 2011-02-24 at 12:57 -0800, Justin Mattock wrote:
>>
>>> this just popped up..:
>>>
>>>
>>> [29804.908327] SELinux:  Invalid class 3588
>>> [29804.908438] ------------[ cut here ]------------
>>> [29804.908443] kernel BUG at security/selinux/avc.c:162!
>>>
>>
>> It might help debugging to get as much of the AVC message as we can even
>> in this case, e.g.
>>
>
> cool, thanks for the debug patch... I applied it, and will run it to see if
> this fires off..
> current kernel is: 2.6.38-rc6-00116-g2821f46
>
>
>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 9da6420..8c0ad28 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -111,6 +111,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16
>> tclass, u32 av)
>>                return;
>>        }
>>
>> +       if (tclass >= ARRAY_SIZE(secclass_map)) {
>> +               audit_log_format(ab, " 0x%x", av);
>> +               return;
>> +       }
>> +
>>        perms = secclass_map[tclass-1].perms;
>>
>>        audit_log_format(ab, " {");
>> @@ -159,8 +164,10 @@ static void avc_dump_query(struct audit_buffer *ab,
>> u32 ssid, u32 tsid, u16 tcla
>>                kfree(scontext);
>>        }
>>
>> -       BUG_ON(tclass >= ARRAY_SIZE(secclass_map));
>> -       audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
>> +       if (tclass < ARRAY_SIZE(secclass_map))
>> +         audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
>> +       else
>> +         audit_log_format(ab, " tclass=%d", tclass);
>> }
>>
>> /**
>>
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>
>
> Justin P. Mattock
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--00151757468c6882d0049d275c8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I have a similar question concerning the considerations of ap=
plying the debug patch after implementing SeLinux policies, where return ob=
ject classes become invalid when applying tagging to TV data modulation ove=
r IP or more specifically over [selected] cables.=A0 The modulation exchang=
e seems to be creating a buffer value that is not readable on the /sys leve=
l and in structuring bypasses the SeLinux implementation.=A0 Is there optio=
ns regarding defining these values in policies being conducted?<br>
<br>thanks<br>ethan<br><br><div class=3D"gmail_quote">On Fri, Feb 25, 2011 =
at 9:18 AM, Justin Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinma=
ttock@gmail.com">justinmattock@gmail.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1=
px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
On Feb 25, 2011, at 6:07 AM, Stephen Smalley wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
On Thu, 2011-02-24 at 12:57 -0800, Justin Mattock wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
this just popped up..:<br>
<br>
<br>
[29804.908327] SELinux: =A0Invalid class 3588<br>
[29804.908438] ------------[ cut here ]------------<br>
[29804.908443] kernel BUG at security/selinux/avc.c:162!<br>
</blockquote>
<br>
It might help debugging to get as much of the AVC message as we can even<br=
>
in this case, e.g.<br>
</blockquote>
<br></div>
cool, thanks for the debug patch... I applied it, and will run it to see if=
 this fires off..<br>
current kernel is: 2.6.38-rc6-00116-g2821f46<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
diff --git a/security/selinux/avc.c b/security/selinux/avc.c<br>
index 9da6420..8c0ad28 100644<br>
--- a/security/selinux/avc.c<br>
+++ b/security/selinux/avc.c<br>
@@ -111,6 +111,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 t=
class, u32 av)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
+ =A0 =A0 =A0 if (tclass &gt;=3D ARRAY_SIZE(secclass_map)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 audit_log_format(ab, &quot; 0x%x&quot;, av);<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
 =A0 =A0 =A0 =A0perms =3D secclass_map[tclass-1].perms;<br>
<br>
 =A0 =A0 =A0 =A0audit_log_format(ab, &quot; {&quot;);<br>
@@ -159,8 +164,10 @@ static void avc_dump_query(struct audit_buffer *ab, u3=
2 ssid, u32 tsid, u16 tcla<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(scontext);<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 BUG_ON(tclass &gt;=3D ARRAY_SIZE(secclass_map));<br>
- =A0 =A0 =A0 audit_log_format(ab, &quot; tclass=3D%s&quot;, secclass_map[t=
class-1].name);<br>
+ =A0 =A0 =A0 if (tclass &lt; ARRAY_SIZE(secclass_map))<br>
+ =A0 =A0 =A0 =A0 audit_log_format(ab, &quot; tclass=3D%s&quot;, secclass_m=
ap[tclass-1].name);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 audit_log_format(ab, &quot; tclass=3D%d&quot;, tclass);<b=
r>
}<br>
<br>
/**<br>
<br>
<br>
-- <br>
Stephen Smalley<br>
National Security Agency<br>
</blockquote>
<br>
<br></div>
Justin P. Mattock<div><div></div><div class=3D"h5"><br>
<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--00151757468c6882d0049d275c8f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
