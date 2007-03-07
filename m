Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27FwDVN022818
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 10:58:13 -0500
Received: from mail2.atl.registeredsite.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l27FxdxR018561
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:59:40 GMT
Message-ID: <45EEE11B.3080901@MagitekLtd.com>
Date: Wed, 07 Mar 2007 07:58:19 -0800
From: "James W. Hoeft" <Jim@MagitekLtd.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <989281.84407.qm@web36612.mail.mud.yahoo.com>
In-Reply-To: <989281.84407.qm@web36612.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> 
>  
>> I think unique identification for all tuples are
>> difficult, because we can
>> create a table without Oid (object id) or primary
>> key to identify a tuple
>> from outside of the table...
>>
>> BTW, the string representations of security contexts
>> are stored in a separate
>> table named as 'pg_selinux', defined with Oid (which
>> have 4-byte length).
>> In SE-PostgreSQL, any tuples have Oid of pg_selinux
>> as a security context.
>> Thus, storage consumption is limited.
> 
> How does this method compare to the schemes
> used in the Oracle evaluated MLS DBMS?

MLS ("Trusted Oracle", rev 9 was last one produced and is no longer 
supported) or current OLS? The mechanisms and level of certification are 
different.

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
