Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2NEu7Xg001429
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 10:56:07 -0400
Received: from mail-qy0-f108.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2NEu64x008443
	for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 14:56:06 GMT
Received: by qyk6 with SMTP id 6so2345577qyk.32
        for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2009 07:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49C7667A.3020804@ak.jp.nec.com>
References: <49C7667A.3020804@ak.jp.nec.com>
Date: Mon, 23 Mar 2009 19:56:06 +0500
Message-ID: <7b740b700903230756g78cd6c29ke17b6e25fae93e46@mail.gmail.com>
Subject: Re: The status of SE-PostgreSQL
From: Shaz <shazalive@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss.tresys.com
Content-Type: multipart/alternative; boundary=0016361640ad4e68380465ca77f1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016361640ad4e68380465ca77f1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Some updates on SE-posgreSql.

2009/3/23 KaiGai Kohei <kaigai@ak.jp.nec.com>

> Here is a bad news.
>
> I've had a discussion in pgsql-hackers list for a long time, but
> we cannot get a conclusion that SE-PostgreSQL should be merged
> in the PostgreSQL v8.4 which is the next major release, and it
> was postponed to the v8.5 development cycle due to lack of time
> for enough reviewing the feature.
>
> If it can be released on schedule, the v8.4 is released on the
> second quarter of 2009, and the v8.5 will be relased on a year
> later (but it tend to delay a few months).
> So, it is necessary to apply SE-PostgreSQL patches or install
> it from RPM package distributed via Fedora project. :(
>
> Under the discussion, I got a few suggestions in its security
> design, and it seems to me fair enough. Some of them needs to
> change definitions in the default policy.
>
> See the following items,
>
> * new permission: db_database:{superuser}
>
> They required a new permission to control database superuser
> privileges similar to "root" capability in operating system.
> The concept of superuser is common for some of major DBMSs,
> not only PostgreSQL. In addition, it seems to me well symmetric
> with operating system.
>
> The db_database:{superuser} controls whether the client can
> perform as database superuser on the given database, or not.
>
> * undesired permission: db_database:{set_param get_param}
>
> They wondered the necessity of these checks, because SQL spec
> does not require checks in set/get database parameters.
> I didn't think it is necessary the security design of SELinux
> should be symmetric with SQL, but I also thought these might
> be unnecessary due to another reason.
> In PostgreSQL, the scope of database parameters are session
> local and initialized on the connection startup, so we cannot
> use it as a pass to communicate between different two or more
> domains.
>
> * undesired permission: db_table/db_column/db_tuple:{use}
>
> I originally proposed the {use} permission to set up write-only
> tables, but it might be a misdesign.
> (Sorry, a bit long description.)
>
> At the initial design, SE-PostgreSQL applied {select} permission
> for all the refered tables, columns and tuples. But, it also means
> {select} permission is necessary for conditional DELETE or UPDATE
> even if its content is not exposed to the client.
> So, I proposed the privilege into two different permission: {select}
> and {use}. The {select} allows the client to refer the object and
> its content can be returned to him. The {use} also allows the client
> to refer the object but its content has to be consumed internally.
>
>  Example)
>    SELECT a, b FROM t WHERE c = 5;
>  In this case, we need {select} on column t.a and t.b, but {use}
>  is required on column t.c because its content is consumed by
>  SE-PostgreSQL itself and not returned to the client.
>
>  Example)
>    UPDATE t SET x = 20 WHERE y = 'aaa';
>  In this case, we need {update} on column t.x, and {use} on t.y,
>  but {select} is not necessary.
>
> However, we can break it rapidly with a clever condition clause.
> For example, we can get a result from the first trial:
>  DELETE FROM account WHERE userid = 100 and creditno like '1%';
>
> If this query removes a tuple, it means the first character of
> credit card number is '1'. If not so, he can try it 9 times.
> Then, he can get the information without {select} permission,
> with enough small number of trials.
>
> They concluded the "{use}" permission cannot work correctly, and
> danger to expect it does not allow to leak contexnt to the outside.
> I can agree this opinion.
>
>
> The attached patch add/remove these permissions.
> Any comments please.
>
> Thanks,
> --
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>



-- 
Shaz

--0016361640ad4e68380465ca77f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Some updates on SE-posgreSql.<br><br><div class=3D"gmail_quote">2009/3/23 K=
aiGai Kohei <span dir=3D"ltr">&lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">k=
aigai@ak.jp.nec.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Here is a bad news.<br>
<br>
I&#39;ve had a discussion in pgsql-hackers list for a long time, but<br>
we cannot get a conclusion that SE-PostgreSQL should be merged<br>
in the PostgreSQL v8.4 which is the next major release, and it<br>
was postponed to the v8.5 development cycle due to lack of time<br>
for enough reviewing the feature.<br>
<br>
If it can be released on schedule, the v8.4 is released on the<br>
second quarter of 2009, and the v8.5 will be relased on a year<br>
later (but it tend to delay a few months).<br>
So, it is necessary to apply SE-PostgreSQL patches or install<br>
it from RPM package distributed via Fedora project. :(<br>
<br>
Under the discussion, I got a few suggestions in its security<br>
design, and it seems to me fair enough. Some of them needs to<br>
change definitions in the default policy.<br>
<br>
See the following items,<br>
<br>
* new permission: db_database:{superuser}<br>
<br>
They required a new permission to control database superuser<br>
privileges similar to &quot;root&quot; capability in operating system.<br>
The concept of superuser is common for some of major DBMSs,<br>
not only PostgreSQL. In addition, it seems to me well symmetric<br>
with operating system.<br>
<br>
The db_database:{superuser} controls whether the client can<br>
perform as database superuser on the given database, or not.<br>
<br>
* undesired permission: db_database:{set_param get_param}<br>
<br>
They wondered the necessity of these checks, because SQL spec<br>
does not require checks in set/get database parameters.<br>
I didn&#39;t think it is necessary the security design of SELinux<br>
should be symmetric with SQL, but I also thought these might<br>
be unnecessary due to another reason.<br>
In PostgreSQL, the scope of database parameters are session<br>
local and initialized on the connection startup, so we cannot<br>
use it as a pass to communicate between different two or more<br>
domains.<br>
<br>
* undesired permission: db_table/db_column/db_tuple:{use}<br>
<br>
I originally proposed the {use} permission to set up write-only<br>
tables, but it might be a misdesign.<br>
(Sorry, a bit long description.)<br>
<br>
At the initial design, SE-PostgreSQL applied {select} permission<br>
for all the refered tables, columns and tuples. But, it also means<br>
{select} permission is necessary for conditional DELETE or UPDATE<br>
even if its content is not exposed to the client.<br>
So, I proposed the privilege into two different permission: {select}<br>
and {use}. The {select} allows the client to refer the object and<br>
its content can be returned to him. The {use} also allows the client<br>
to refer the object but its content has to be consumed internally.<br>
<br>
 =A0Example)<br>
 =A0 =A0SELECT a, b FROM t WHERE c =3D 5;<br>
 =A0In this case, we need {select} on column t.a and t.b, but {use}<br>
 =A0is required on column t.c because its content is consumed by<br>
 =A0SE-PostgreSQL itself and not returned to the client.<br>
<br>
 =A0Example)<br>
 =A0 =A0UPDATE t SET x =3D 20 WHERE y =3D &#39;aaa&#39;;<br>
 =A0In this case, we need {update} on column t.x, and {use} on t.y,<br>
 =A0but {select} is not necessary.<br>
<br>
However, we can break it rapidly with a clever condition clause.<br>
For example, we can get a result from the first trial:<br>
 =A0DELETE FROM account WHERE userid =3D 100 and creditno like &#39;1%&#39;=
;<br>
<br>
If this query removes a tuple, it means the first character of<br>
credit card number is &#39;1&#39;. If not so, he can try it 9 times.<br>
Then, he can get the information without {select} permission,<br>
with enough small number of trials.<br>
<br>
They concluded the &quot;{use}&quot; permission cannot work correctly, and<=
br>
danger to expect it does not allow to leak contexnt to the outside.<br>
I can agree this opinion.<br>
<br>
<br>
The attached patch add/remove these permissions.<br>
Any comments please.<br>
<br>
Thanks,<br>
<font color=3D"#888888">--<br>
OSS Platform Development Division, NEC<br>
KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.c=
om</a>&gt;<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--0016361640ad4e68380465ca77f1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
