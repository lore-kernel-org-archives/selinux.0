Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1OFQ52M014211
 for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2016 10:26:05 -0500
Received: by mail-vk0-f46.google.com with SMTP id e6so19621080vkh.2
 for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2016 07:25:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56CDC2EC.5050502@tycho.nsa.gov>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
 <56CDC2EC.5050502@tycho.nsa.gov>
Date: Wed, 24 Feb 2016 07:25:54 -0800
Message-ID: <CAFJ0LnHvFe6PkGp2BGKj-cQ-e11kFo9DacB_MbP9xFmi5S=DNA@mail.gmail.com>
Subject: Re: getpidcon with pid == 0 (Was: Re: [PATCH 2/2] libselinux:
 procattr: return einval for <= 0 pid args.)
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel Cashman <dcashman@android.com>, SELinux <selinux@tycho.nsa.gov>,
 Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=001a1142674891dde5052c85aed6
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142674891dde5052c85aed6
Content-Type: text/plain; charset=UTF-8

A quick Google search for "getpidcon(0" shows only the Android bug.

https://www.google.com/webhp#q=%22getpidcon(0%22

-- Nick

On Wed, Feb 24, 2016 at 6:49 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 02/23/2016 03:24 PM, Daniel Cashman wrote:
>
>> From: dcashman <dcashman@android.com>
>>
>> getpidcon documentation does not specify that a pid of 0 refers to the
>> current process, and getcon exists specifically to provide this
>> functionality, and getpidcon(getpid()) would provide it as well.
>> Disallow pid values <= 0 that may lead to unintended behavior in
>> userspace object managers.
>>
>
> I'll try to see if there are any legitimate users of getpidcon with pid ==
> 0.  If anyone on the list knows of one, please speak up.
>
>
>> Signed-off-by: Daniel Cashman <dcashman@android.com>
>> ---
>>   libselinux/src/procattr.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>> index c20f003..eee4612 100644
>> --- a/libselinux/src/procattr.c
>> +++ b/libselinux/src/procattr.c
>> @@ -306,11 +306,21 @@ static int setprocattrcon(const char * context,
>>   #define getpidattr_def(fn, attr) \
>>         int get##fn##_raw(pid_t pid, char **c)  \
>>         { \
>> -               return getprocattrcon_raw(c, pid, #attr); \
>> +               if (pid <= 0) { \
>> +                       errno = EINVAL; \
>> +                       return -1; \
>> +               } else { \
>> +                       return getprocattrcon_raw(c, pid, #attr); \
>> +               } \
>>         } \
>>         int get##fn(pid_t pid, char **c)        \
>>         { \
>> -               return getprocattrcon(c, pid, #attr); \
>> +               if (pid <= 0) { \
>> +                       errno = EINVAL; \
>> +                       return -1; \
>> +               } else { \
>> +                       return getprocattrcon(c, pid, #attr); \
>> +               } \
>>         }
>>
>>   all_selfattr_def(con, current)
>>
>>
>


-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a1142674891dde5052c85aed6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A quick Google search for &quot;getpidcon(0&quot; shows on=
ly the Android bug.<div><br></div><div><a href=3D"https://www.google.com/we=
bhp#q=3D%22getpidcon(0%22">https://www.google.com/webhp#q=3D%22getpidcon(0%=
22</a><br></div><div><br></div><div>-- Nick</div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Wed, Feb 24, 2016 at 6:49 AM, Step=
hen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" targ=
et=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 02/23/2016 03:24 PM, Daniel Cashman wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: dcashman &lt;<a href=3D"mailto:dcashman@android.com" target=3D"_blank=
">dcashman@android.com</a>&gt;<br>
<br>
getpidcon documentation does not specify that a pid of 0 refers to the<br>
current process, and getcon exists specifically to provide this<br>
functionality, and getpidcon(getpid()) would provide it as well.<br>
Disallow pid values &lt;=3D 0 that may lead to unintended behavior in<br>
userspace object managers.<br>
</blockquote>
<br>
I&#39;ll try to see if there are any legitimate users of getpidcon with pid=
 =3D=3D 0.=C2=A0 If anyone on the list knows of one, please speak up.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Daniel Cashman &lt;<a href=3D"mailto:dcashman@android.com" t=
arget=3D"_blank">dcashman@android.com</a>&gt;<br>
---<br>
=C2=A0 libselinux/src/procattr.c | 14 ++++++++++++--<br>
=C2=A0 1 file changed, 12 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c<br>
index c20f003..eee4612 100644<br>
--- a/libselinux/src/procattr.c<br>
+++ b/libselinux/src/procattr.c<br>
@@ -306,11 +306,21 @@ static int setprocattrcon(const char * context,<br>
=C2=A0 #define getpidattr_def(fn, attr) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int get##fn##_raw(pid_t pid, char **c)=C2=A0 \<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return getprocattrc=
on_raw(c, pid, #attr); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid &lt;=3D 0) =
{ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0errno =3D EINVAL; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -1; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return getprocattrcon_raw(c, pid, #attr); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int get##fn(pid_t pid, char **c)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return getprocattrc=
on(c, pid, #attr); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pid &lt;=3D 0) =
{ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0errno =3D EINVAL; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -1; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return getprocattrcon(c, pid, #attr); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 all_selfattr_def(con, current)<br>
<br>
</blockquote>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div>Nick Kralevich | Android Security | <a href=3D"ma=
ilto:nnk@google.com" target=3D"_blank">nnk@google.com</a> | 650.214.4037</d=
iv></div>
</div>

--001a1142674891dde5052c85aed6--
