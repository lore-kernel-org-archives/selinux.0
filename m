Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BD43VE016015
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 09:04:03 -0400
Received: from nz-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BD3cEI006003
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 13:03:38 GMT
Received: by nz-out-0102.google.com with SMTP id i11so493186nzi
        for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 06:04:02 -0700 (PDT)
Message-ID: <45055EAF.4080405@kaigai.gr.jp>
Date: Mon, 11 Sep 2006 22:03:43 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <6FE441CD9F0C0C479F2D88F959B015883C173C@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015883C173C@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> Firstly, I didn't notice any getattr permission...
>> I also agreed your opinion.
>> But we have to pay attention on what select and getattr are 
>> always used together on regular tables, because PostgreSQL 
>> packed metadata of each column into result set.
>> (It's a purely implementation matter.)
>>
> 
> Which includes all data and schema labels..

Of course, updating system catalog should be protected by
relabelfrom/relabelto and setattr permission, not only update.

>>>> - delete a row
>>>> Becaues the delete opetation involves the whole of one row, 
>>>> column:delete is not evaluated when we try to delete a row.
>>>> (Thus, it's not defined.)
>>>> This behavior may be a bit controvertible.
>>> Maybe the column object class could have an entry deletefrom which 
>>> allows deleting a row that has an entry in that column.
>> It will solve the matter from TE viewpoint, but how dose it 
>> handle the MLS/MCS constraint?
>> If the client must dominate any columns when a row is 
>> deleted, it seems to me that the client must have the highest 
>> or upper clearance originally.
>>
> 
> Only if the policy says that. Delete would be a write which means anyone
> below it can do so. A worse problem is when someone is a high clearance
> and can't delete a row because one of the fields is below him. I think
> this makes the deletefrom permission unnecessarilly restrictive. It
> might be sufficient to need delete on the table and row.

Indeed, it seems to me a bit strange behavior.
I also think row deletion should be controlled by table and row's permission.

Thanks.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
