Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2LLoObj008329
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 17:50:24 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2LLoMk4010886
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 21:50:23 GMT
Received: by iyb26 with SMTP id 26so7638186iyb.12
        for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 14:50:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D40F249.5020606@ak.jp.nec.com>
References: <4D256BE8.2010704@ak.jp.nec.com>
	<4D40F249.5020606@ak.jp.nec.com>
Date: Mon, 21 Mar 2011 22:50:21 +0100
Message-ID: <AANLkTi=oW2zv5m3MwGvtj1hB=+OaqSs7xNjrLt-XBVqo@mail.gmail.com>
Subject: Re: [libselinux] add db_language support on label_db.c
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: KaiGai Kohei <kohei.kaigai@EU.NEC.COM>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Without this patch, we will see the following warning message on the initial
setting up of SE-PostgreSQL, however, it is ugly.
Right now, security label on db_language object class is not implemented yet,
but it needs to be supported prior to my implementation.
Please commit this patch.

[kaigai@vmlinux ~]$ postgres --single -F -O -c exit_on_error=true postgres \
        < /usr/local/pgsql/share/contrib/sepgsql.sql > /dev/null
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 33 has invalid
object type db_blobs
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 36 has invalid
object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 37 has invalid
object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 38 has invalid
object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 39 has invalid
object type db_language
/etc/selinux/targeted/contexts/sepgsql_contexts:  line 40 has invalid
object type db_language

2011年1月27日5:19 KaiGai Kohei <kaigai@ak.jp.nec.com>:
> How about getting inclusion of this patch?
>
> The db_language class is already merged to refpolicy.
> I think it is also necessary to be merged to libselinux.
>
> Thanks,
>
> (2011/01/06 16:14), KaiGai Kohei wrote:
>> The attached patch add support db_language object class
>> to the selabel_lookup(_raw) interfaces.
>> It is needed to inform object manager initial label of
>> procedural language object.
>>
>> Thanks,
>
> --
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
