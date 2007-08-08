Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l781DAcR013872
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 21:13:11 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l781D8LJ016836
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 01:13:09 GMT
Message-ID: <46B91890.2020101@manicmethod.com>
Date: Tue, 07 Aug 2007 21:12:48 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: Fedora/SE-PostgreSQL
References: <46B079EF.9050909@kaigai.gr.jp> <1186489529.18881.9.camel@gorn>	 <46B878D9.6090004@ak.jp.nec.com> <1186495764.18881.17.camel@gorn> <46B8ABC5.60705@kaigai.gr.jp>
In-Reply-To: <46B8ABC5.60705@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> The attached patch adds definitions of new classes and permissions,
> and MLS/MCS rules.
> 
> Following items are differences from the first patch.
> 
> * add "db_" prefix for each object classes.
>   e.g) "table" -> "db_table"
> * interfaces in policy/modules/kernel/mls.if are renamed.
>   - mls_database_read_up    -> mls_db_read_all_levels
>   - mls_database_write_down -> mls_db_write_all_levels
>   - mls_database_upgrade    -> mls_db_upgrade
>   - mls_database_downgrade  -> mls_db_downgrade
> * MLS attributes related to database are renamed
>   - mlsdatabaseXXXXX -> mlsdbXXXXX
> 
> Any comment please,
> 
> Christopher J. PeBenito wrote:
>> On Tue, 2007-08-07 at 22:51 +0900, KaiGai Kohei wrote:
>>> Christopher J. PeBenito wrote:
>>>> On Wed, 2007-08-01 at 08:17 -0400, KaiGai Kohei wrote:
>>>> Interface naming:
>>>>
>>>>> +interface(`mls_database_read_up',`
>>>> mls_db_read_all_levels
>>>>
>>>>> +interface(`mls_database_write_down',`
>>>> mls_db_write_all_levels
>>>>
>>>>> +interface(`mls_database_upgrade',`
>>>> mls_db_upgrade
>>>>
>>>>> +interface(`mls_database_downgrade',`
>>>> mls_db_downgrade
>>> OK, I'll rename these interfaces more simple.
>>> Is it necessary to make the attribute names shorter?
>> Not strictly, but it probably would be a good idea.
>>
> 

These interface names seem kind of ambiguous, they could mean downgrade
the database files on disk or within an selinux aware database server.
They also have very low granularity, but I haven't decided if that
matters much.

It would be nice to have less ambiguous interface names though.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
