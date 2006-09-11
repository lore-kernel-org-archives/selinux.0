Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BCAphi014559
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 08:10:51 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BCAQEI029657
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 12:10:27 GMT
Received: by py-out-1112.google.com with SMTP id 39so1802374pyu
        for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 05:10:50 -0700 (PDT)
Message-ID: <45055236.5010500@kaigai.gr.jp>
Date: Mon, 11 Sep 2006 21:10:30 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <44FFEB42.90203@kaigai.gr.jp> <45039AC2.3040309@kaigai.gr.jp> <200609101708.03454.russell@coker.com.au>
In-Reply-To: <200609101708.03454.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Sunday 10 September 2006 14:55, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
>> In recent days, I'm making a plan to enhance PostgreSQL with SELinux.
>> I posted the first draft of this plan a few days ago, and I got many
>> response. Thanks for your comments so much.
>> (Especially, Joshua and Russell)
>
> Firstly, I didn't notice any getattr permission...

I also agreed your opinion.
But we have to pay attention on what select and getattr are always used
together on regular tables, because PostgreSQL packed metadata of each
column into result set.
(It's a purely implementation matter.)

In the special case, how should we consider the system catalog which is
the non-regular table contains only metadata?
I think a query for it should be purely handled as a metadata reference
operation, so only getattr is required for 'select * from pg_attribute;'
for example.

In addition, setattr is neccesary to control ALTER XXXX operations,
isn't it?

>> - delete a row
>> Becaues the delete opetation involves the whole of one row, column:delete
>> is not evaluated when we try to delete a row.
>> (Thus, it's not defined.)
>> This behavior may be a bit controvertible.
>
> Maybe the column object class could have an entry deletefrom which allows
> deleting a row that has an entry in that column.

It will solve the matter from TE viewpoint, but how dose it handle
the MLS/MCS constraint?
If the client must dominate any columns when a row is deleted, it seems
to me that the client must have the highest or upper clearance originally.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
