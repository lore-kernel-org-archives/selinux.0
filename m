MIME-Version: 1.0
In-Reply-To: <1309526595.31276.2.camel@moss-pluto>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	<1308920243.15355.55.camel@moss-pluto>
	<BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	<1308924690.15355.72.camel@moss-pluto>
	<BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	<1308926890.15355.74.camel@moss-pluto>
	<BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
	<1308928177.15355.76.camel@moss-pluto>
	<BANLkTikJLUuP4g=krqa3wyxh1FF=2E52SA@mail.gmail.com>
	<1309526595.31276.2.camel@moss-pluto>
Date: Tue, 5 Jul 2011 10:43:25 -0400
Message-ID: <CAMfCo-q+O+JK9CjCcoa6rbUwqikxWHuSbUtcRc9fiGzGs2TXXA@mail.gmail.com>
Subject: Re: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=20cf305f91c29a8fbd04a753812c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf305f91c29a8fbd04a753812c
Content-Type: multipart/alternative; boundary=20cf305f91c29a8fb904a753812a

--20cf305f91c29a8fb904a753812a
Content-Type: text/plain; charset=ISO-8859-1

Hi Stephen,

Many thanks for your help. I am now able to get the correct user type
(user_t).

The problem I had was in the kernel, which was wrongly configured to use
policydb version 19.
When I changed to kernel config, I am able to login in the correct context.

Attached is the getconlist, getseuser for your reference, before and after
the kernel changes.

PS: this works for login (local_login_t), and for uxlaunch, as you said, I
am planning to have a policy transition.

Regards,
Madhu

On Fri, Jul 1, 2011 at 9:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-06-24 at 15:50 +0000, c.r.madhusudhanan@gmail.com wrote:
> > [root@localhost utils]# ./getconlist user_u
> > user_u:user_r:consoletype_t
> > [root@localhost utils]# ./getconlist root
> > root:sysadm_r:sysadm_t
> >
> > [root@localhost utils]# ./getseuser meego
> > seuser:  user_u, level (null)
> > Context 0       user_u:user_r:consoletype_t
> > [root@localhost utils]# ./getseuser root
> > seuser:  root, level (null)
> > Context 0       root:sysadm_r:sysadm_t
> > (I dont know but the getseuser dint work until I changed the code
> >  if (argc != 2). )
>
> You aren't invoking them correctly - you need to pass the security
> context of the login process as the second argument, as I showed.
>
> For example, on Fedora, we have:
> $ ./getconlist user_u system_u:system_r:local_login_t:s0
> user_u:user_r:user_t:s0
> $ ./getseuser root system_u:system_r:local_login_t:s0
> $ ./getseuser root system_u:system_r:local_login_t:s0
> seuser:  unconfined_u, level s0-s0:c0.c1023
> Context 0       unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>
> Omit the :s0 if you don't have MLS enabled in your policy.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--20cf305f91c29a8fb904a753812a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Stephen,<div><br></div><div>Many thanks for your help. I am now able to =
get the correct user type (user_t).</div><div><br></div><div>The problem I =
had was in the kernel, which was wrongly configured to use policydb version=
 19.</div>
<div>When I changed to kernel config, I am able to login in the correct con=
text.</div><div><br></div><div>Attached is the getconlist, getseuser for yo=
ur=A0reference, before and after the kernel changes.</div><div><br></div>
<div>PS: this works for login (local_login_t), and for uxlaunch, as you sai=
d, I am planning to have a policy transition.</div><div><br></div><div>Rega=
rds,</div><div>Madhu</div><div><br><div class=3D"gmail_quote">On Fri, Jul 1=
, 2011 at 9:23 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Fri, 2011-06-24 at 15:=
50 +0000, <a href=3D"mailto:c.r.madhusudhanan@gmail.com">c.r.madhusudhanan@=
gmail.com</a> wrote:<br>

&gt; [root@localhost utils]# ./getconlist user_u<br>
&gt; user_u:user_r:consoletype_t<br>
&gt; [root@localhost utils]# ./getconlist root<br>
&gt; root:sysadm_r:sysadm_t<br>
&gt;<br>
&gt; [root@localhost utils]# ./getseuser meego<br>
&gt; seuser: =A0user_u, level (null)<br>
&gt; Context 0 =A0 =A0 =A0 user_u:user_r:consoletype_t<br>
&gt; [root@localhost utils]# ./getseuser root<br>
&gt; seuser: =A0root, level (null)<br>
&gt; Context 0 =A0 =A0 =A0 root:sysadm_r:sysadm_t<br>
&gt; (I dont know but the getseuser dint work until I changed the code<br>
&gt; =A0if (argc !=3D 2). )<br>
<br>
</div>You aren&#39;t invoking them correctly - you need to pass the securit=
y<br>
context of the login process as the second argument, as I showed.<br>
<br>
For example, on Fedora, we have:<br>
$ ./getconlist user_u system_u:system_r:local_login_t:s0<br>
user_u:user_r:user_t:s0<br>
$ ./getseuser root system_u:system_r:local_login_t:s0<br>
$ ./getseuser root system_u:system_r:local_login_t:s0<br>
seuser: =A0unconfined_u, level s0-s0:c0.c1023<br>
Context 0 =A0 =A0 =A0 unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023=
<br>
<br>
Omit the :s0 if you don&#39;t have MLS enabled in your policy.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br></div>

--20cf305f91c29a8fb904a753812a--

--20cf305f91c29a8fbd04a753812c
Content-Type: text/plain; charset=US-ASCII; name="libsemanage_utils_output.txt"
Content-Disposition: attachment; filename="libsemanage_utils_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gprj0g240

V3Jvbmcga2VybmVsIG9wdGlvbiB3YXM6Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNPTkZJR19T
RUNVUklUWV9TRUxJTlVYX1BPTElDWURCX1ZFUlNJT05fTUFYPXkKQ09ORklHX1NFQ1VSSVRZX1NF
TElOVVhfUE9MSUNZREJfVkVSU0lPTl9NQVhfVkFMVUU9MTkKCkJlZm9yZQotLS0tLS0KW3Jvb3RA
bG9jYWxob3N0IHV0aWxzXSMgLi9nZXRjb25saXN0IHJvb3Qgc3lzdGVtX3U6c3lzdGVtX3I6bG9j
YWxfbG9naW5fdApyb290OnN0YWZmX3I6Y2hrcHdkX3QKcm9vdDpzdGFmZl9yOnVwZHB3ZF90CnJv
b3Q6c3lzYWRtX3I6Y2hrcHdkX3QKcm9vdDpzeXNhZG1fcjp1cGRwd2RfdApbcm9vdEBsb2NhbGhv
c3QgdXRpbHNdIyAuL2dldGNvbmxpc3QgdXNlcl91IHN5c3RlbV91OnN5c3RlbV9yOmxvY2FsX2xv
Z2luX3QKdXNlcl91OnVzZXJfcjpjaGtwd2RfdAp1c2VyX3U6dXNlcl9yOnVwZHB3ZF90Cltyb290
QGxvY2FsaG9zdCB1dGlsc10jIC4vZ2V0c2V1c2VyIHJvb3Qgc3lzdGVtX3U6c3lzdGVtX3I6bG9j
YWxfbG9naW5fdApzZXVzZXI6ICByb290LCBsZXZlbCAobnVsbCkKQ29udGV4dCAwICAgICAgIHJv
b3Q6c3RhZmZfcjpjaGtwd2RfdApDb250ZXh0IDEgICAgICAgcm9vdDpzdGFmZl9yOnVwZHB3ZF90
CkNvbnRleHQgMiAgICAgICByb290OnN5c2FkbV9yOmNoa3B3ZF90CkNvbnRleHQgMyAgICAgICBy
b290OnN5c2FkbV9yOnVwZHB3ZF90Cltyb290QGxvY2FsaG9zdCB1dGlsc10jIC4vZ2V0c2V1c2Vy
IHVzZXJfdSBzeXN0ZW1fdTpzeXN0ZW1fcjpsb2NhbF9sb2dpbl90CnNldXNlcjogIHVzZXJfdSwg
bGV2ZWwgKG51bGwpCkNvbnRleHQgMCAgICAgICB1c2VyX3U6dXNlcl9yOmNoa3B3ZF90CkNvbnRl
eHQgMSAgICAgICB1c2VyX3U6dXNlcl9yOnVwZHB3ZF90Cltyb290QGxvY2FsaG9zdCB1dGlsc10j
IAoKQWZ0ZXIKLS0tLS0KW3Jvb3RAbG9jYWxob3N0IHV0aWxzXSMgLi9nZXRjb25saXN0IHJvb3Qg
c3lzdGVtX3U6c3lzdGVtX3I6bG9jYWxfbG9naW5fdApyb290OnN5c2FkbV9yOnN5c2FkbV90CnJv
b3Q6c3RhZmZfcjpzdGFmZl90Cltyb290QGxvY2FsaG9zdCB1dGlsc10jICAuL2dldGNvbmxpc3Qg
dXNlcl91IHN5c3RlbV91OnN5c3RlbV9yOmxvY2FsX2xvZ2luX3QKdXNlcl91OnVzZXJfcjp1c2Vy
X3QKW3Jvb3RAbG9jYWxob3N0IHV0aWxzXSMgIC4vZ2V0c2V1c2VyIHJvb3Qgc3lzdGVtX3U6c3lz
dGVtX3I6bG9jYWxfbG9naW5fdApzZXVzZXI6ICByb290LCBsZXZlbCAobnVsbCkKQ29udGV4dCAw
ICAgICAgIHJvb3Q6c3lzYWRtX3I6c3lzYWRtX3QKQ29udGV4dCAxICAgICAgIHJvb3Q6c3RhZmZf
cjpzdGFmZl90Cltyb290QGxvY2FsaG9zdCB1dGlsc10jIC4vZ2V0c2V1c2VyIHVzZXJfdSBzeXN0
ZW1fdTpzeXN0ZW1fcjpsb2NhbF9sb2dpbl90CnNldXNlcjogIHVzZXJfdSwgbGV2ZWwgKG51bGwp
CkNvbnRleHQgMCAgICAgICB1c2VyX3U6dXNlcl9yOnVzZXJfdAo=
--20cf305f91c29a8fbd04a753812c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
