Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w86JnNu6008149
 for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2018 15:49:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id v198-v6so5188148oif.9
 for <selinux@tycho.nsa.gov>; Thu, 06 Sep 2018 12:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180905214906.11016-1-nicolas.iooss@m4x.org>
 <20180905214906.11016-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180905214906.11016-2-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 6 Sep 2018 12:48:33 -0700
Message-ID: <CAFftDdod6odURvyfDJAg0ZT8vzAAoKJ4gbZk_7M=oP35WhdGrw@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000c0badd0575392dac"
Subject: Re: [PATCH 2/2] semanage: add a missing space in ibendport
 help
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000c0badd0575392dac
Content-Type: text/plain; charset="UTF-8"

ack

On Wed, Sep 5, 2018 at 2:53 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:

> Currently, in:
>
>     # semanage ibendport --help
>     usage: semanage ibendport [-h] [-n] [-N] [-s STORE] [ --add -t TYPE
>     -z IBDEV_NAME -r RANGE ( port ) | --delete -z IBDEV_NAME -r RANGE(
>     port ) | --deleteall  | --extract  | --list -C | --modify -t TYPE -z
>     IBDEV_NAME -r RANGE ( port ) ]
>
> ... a space is missing between "RANGE" and "( port )" in the usage of
> --delete. Add it by splitting the string correctly in the usage line
> definition.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/semanage/semanage | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index e32d1e8ad387..f4be97507c18 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -62,7 +62,7 @@ usage_ibpkey = "semanage ibpkey [-h] [-n] [-N] [-s
> STORE] ["
>  usage_ibpkey_dict = {' --add': ('-t TYPE', '-x SUBNET_PREFIX', '-r
> RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --modify': ('-t
> TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|',
> 'pkey_range', ')'), ' --delete': ('-x SUBNET_PREFIX', '(', 'ibpkey_name',
> '|', 'pkey_range', ')'), ' --list': ('-C',), ' --extract': ('',), '
> --deleteall': ('',)}
>
>  usage_ibendport = "semanage ibendport [-h] [-n] [-N] [-s STORE] ["
> -usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r
> RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r
> RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE''(',
> 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall':
> ('',)}
> +usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r
> RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r
> RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE', '(',
> 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall':
> ('',)}
>
>  usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
>  usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r
> RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r
> RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), '
> --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> --
> 2.18.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--000000000000c0badd0575392dac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ack</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Wed, Sep 5, 2018 at 2:53 PM Nicolas Iooss &lt;<a href=3D"mailto:nicolas.i=
ooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Currently, in:<br>
<br>
=C2=A0 =C2=A0 # semanage ibendport --help<br>
=C2=A0 =C2=A0 usage: semanage ibendport [-h] [-n] [-N] [-s STORE] [ --add -=
t TYPE<br>
=C2=A0 =C2=A0 -z IBDEV_NAME -r RANGE ( port ) | --delete -z IBDEV_NAME -r R=
ANGE(<br>
=C2=A0 =C2=A0 port ) | --deleteall=C2=A0 | --extract=C2=A0 | --list -C | --=
modify -t TYPE -z<br>
=C2=A0 =C2=A0 IBDEV_NAME -r RANGE ( port ) ]<br>
<br>
... a space is missing between &quot;RANGE&quot; and &quot;( port )&quot; i=
n the usage of<br>
--delete. Add it by splitting the string correctly in the usage line<br>
definition.<br>
<br>
Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org" t=
arget=3D"_blank">nicolas.iooss@m4x.org</a>&gt;<br>
---<br>
=C2=A0python/semanage/semanage | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/python/semanage/semanage b/python/semanage/semanage<br>
index e32d1e8ad387..f4be97507c18 100644<br>
--- a/python/semanage/semanage<br>
+++ b/python/semanage/semanage<br>
@@ -62,7 +62,7 @@ usage_ibpkey =3D &quot;semanage ibpkey [-h] [-n] [-N] [-s=
 STORE] [&quot;<br>
=C2=A0usage_ibpkey_dict =3D {&#39; --add&#39;: (&#39;-t TYPE&#39;, &#39;-x =
SUBNET_PREFIX&#39;, &#39;-r RANGE&#39;, &#39;(&#39;, &#39;ibpkey_name&#39;,=
 &#39;|&#39;, &#39;pkey_range&#39;, &#39;)&#39;), &#39; --modify&#39;: (&#3=
9;-t TYPE&#39;, &#39;-x SUBNET_PREFIX&#39;, &#39;-r RANGE&#39;, &#39;(&#39;=
, &#39;ibpkey_name&#39;, &#39;|&#39;, &#39;pkey_range&#39;, &#39;)&#39;), &=
#39; --delete&#39;: (&#39;-x SUBNET_PREFIX&#39;, &#39;(&#39;, &#39;ibpkey_n=
ame&#39;, &#39;|&#39;, &#39;pkey_range&#39;, &#39;)&#39;), &#39; --list&#39=
;: (&#39;-C&#39;,), &#39; --extract&#39;: (&#39;&#39;,), &#39; --deleteall&=
#39;: (&#39;&#39;,)}<br>
<br>
=C2=A0usage_ibendport =3D &quot;semanage ibendport [-h] [-n] [-N] [-s STORE=
] [&quot;<br>
-usage_ibendport_dict =3D {&#39; --add&#39;: (&#39;-t TYPE&#39;, &#39;-z IB=
DEV_NAME&#39;, &#39;-r RANGE&#39;, &#39;(&#39;, &#39;port&#39;, &#39;)&#39;=
), &#39; --modify&#39;: (&#39;-t TYPE&#39;, &#39;-z IBDEV_NAME&#39;, &#39;-=
r RANGE&#39;, &#39;(&#39;, &#39;port&#39;, &#39;)&#39;), &#39; --delete&#39=
;: (&#39;-z IBDEV_NAME&#39;, &#39;-r RANGE&#39;&#39;(&#39;, &#39;port&#39;,=
 &#39;)&#39;), &#39; --list&#39;: (&#39;-C&#39;,), &#39; --extract&#39;: (&=
#39;&#39;,), &#39; --deleteall&#39;: (&#39;&#39;,)}<br>
+usage_ibendport_dict =3D {&#39; --add&#39;: (&#39;-t TYPE&#39;, &#39;-z IB=
DEV_NAME&#39;, &#39;-r RANGE&#39;, &#39;(&#39;, &#39;port&#39;, &#39;)&#39;=
), &#39; --modify&#39;: (&#39;-t TYPE&#39;, &#39;-z IBDEV_NAME&#39;, &#39;-=
r RANGE&#39;, &#39;(&#39;, &#39;port&#39;, &#39;)&#39;), &#39; --delete&#39=
;: (&#39;-z IBDEV_NAME&#39;, &#39;-r RANGE&#39;, &#39;(&#39;, &#39;port&#39=
;, &#39;)&#39;), &#39; --list&#39;: (&#39;-C&#39;,), &#39; --extract&#39;: =
(&#39;&#39;,), &#39; --deleteall&#39;: (&#39;&#39;,)}<br>
<br>
=C2=A0usage_node =3D &quot;semanage node [-h] [-n] [-N] [-S STORE] [&quot;<=
br>
=C2=A0usage_node_dict =3D {&#39; --add&#39;: (&#39;-M NETMASK&#39;, &#39;-p=
 PROTOCOL&#39;, &#39;-t TYPE&#39;, &#39;-r RANGE&#39;, &#39;node&#39;), &#3=
9; --modify&#39;: (&#39;-M NETMASK&#39;, &#39;-p PROTOCOL&#39;, &#39;-t TYP=
E&#39;, &#39;-r RANGE&#39;, &#39;node&#39;), &#39; --delete&#39;: (&#39;-M =
NETMASK&#39;, &#39;-p PROTOCOL&#39;, &#39;node&#39;), &#39; --list&#39;: (&=
#39;-C&#39;,), &#39; --extract&#39;: (&#39;&#39;,), &#39; --deleteall&#39;:=
 (&#39;&#39;,)}<br>
-- <br>
2.18.0<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div>

--000000000000c0badd0575392dac--
