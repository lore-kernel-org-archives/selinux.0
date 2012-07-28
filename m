MIME-Version: 1.0
In-Reply-To: <1343429484-6978-1-git-send-email-hqjiang1988@gmail.com>
References: <1343429484-6978-1-git-send-email-hqjiang1988@gmail.com>
Date: Sat, 28 Jul 2012 12:04:57 -0700
Message-ID: <CAO-4OdHJAdd-wSnr24F6ZeEbXPmo=6qvrwJhtxfhg5=QcZpB6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Appdomain write to cgroup on android_cts enabled
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com,
        Haiqing Jiang <hqjiang1988@gmail.com>
Content-Type: multipart/alternative; boundary=f46d0401240b2c96b904c5e88113
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401240b2c96b904c5e88113
Content-Type: text/plain; charset=ISO-8859-1

The denial info is:

*<5>[ 2223.830596] type=1400 audit(1342221805.835:19): avc:  denied  {
write } for  pid=2687 comm="ationTestRunner" name="10038" dev=cgroup
ino=4532 scontext=u:r:untrusted_app:s0:c38 tcontext=u:object_r:cgroup:s0
tclass=dir*

I really appreciate your comments. Thanks.

On Fri, Jul 27, 2012 at 3:51 PM, Haiqing Jiang <hqjiang1988@gmail.com>wrote:

> ---
>  cts.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/cts.te b/cts.te
> index ff8a9f0..7877b19 100644
> --- a/cts.te
> +++ b/cts.te
> @@ -31,6 +31,9 @@ allow appdomain system_file:file rx_file_perms;
>  allow appdomain apk_tmp_file:file rw_file_perms;
>  allow appdomain shell_data_file:file r_file_perms;
>
> +# Write to cgroup
> +allow appdomain cgroup:dir write;
> +
>  # Read routing information.
>  allow netdomain self:netlink_route_socket { create read write nlmsg_read
> };
>
> --
> 1.7.0.4
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d0401240b2c96b904c5e88113
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The denial info is:=A0<div><br></div><div><b id=3D"internal-source-marker_0=
.03467495436780155" style=3D"font-family:&#39;Times New Roman&#39;;font-siz=
e:medium;font-weight:normal"><span style=3D"font-size:15px;font-family:Aria=
l;vertical-align:baseline;white-space:pre-wrap">&lt;5&gt;[ 2223.830596] typ=
e=3D1400 audit(1342221805.835:19): avc: =A0denied =A0{ write } for =A0pid=
=3D2687 comm=3D&quot;ationTestRunner&quot; name=3D&quot;10038&quot; dev=3Dc=
group ino=3D4532 scontext=3Du:r:untrusted_app:s0:c38 tcontext=3Du:object_r:=
cgroup:s0 tclass=3Ddir</span></b></div>
<div><font face=3D"Arial"><span style=3D"font-size:15px;white-space:pre-wra=
p"><br></span></font></div><div><font face=3D"Arial"><span style=3D"font-si=
ze:15px;white-space:pre-wrap">I really appreciate your comments. Thanks. <b=
r></span></font><br>
<div class=3D"gmail_quote">On Fri, Jul 27, 2012 at 3:51 PM, Haiqing Jiang <=
span dir=3D"ltr">&lt;<a href=3D"mailto:hqjiang1988@gmail.com" target=3D"_bl=
ank">hqjiang1988@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
---<br>
=A0cts.te | =A0 =A03 +++<br>
=A01 files changed, 3 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/cts.te b/cts.te<br>
index ff8a9f0..7877b19 100644<br>
--- a/cts.te<br>
+++ b/cts.te<br>
@@ -31,6 +31,9 @@ allow appdomain system_file:file rx_file_perms;<br>
=A0allow appdomain apk_tmp_file:file rw_file_perms;<br>
=A0allow appdomain shell_data_file:file r_file_perms;<br>
<br>
+# Write to cgroup<br>
+allow appdomain cgroup:dir write;<br>
+<br>
=A0# Read routing information.<br>
=A0allow netdomain self:netlink_route_socket { create read write nlmsg_read=
 };<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.0.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>
</div>

--f46d0401240b2c96b904c5e88113--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
