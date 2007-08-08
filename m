Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78HOjqc019854
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 13:24:45 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78HOhCU006961
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 17:24:44 GMT
Message-ID: <46B9FC81.6080804@kaigai.gr.jp>
Date: Thu, 09 Aug 2007 02:25:21 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: Fedora/SE-PostgreSQL
References: <46B079EF.9050909@kaigai.gr.jp> <1186489529.18881.9.camel@gorn>	 <46B878D9.6090004@ak.jp.nec.com> <1186495764.18881.17.camel@gorn>	 <46B8ABC5.60705@kaigai.gr.jp>  <46B91890.2020101@manicmethod.com> <1186576381.18881.39.camel@gorn>
In-Reply-To: <1186576381.18881.39.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2007-08-07 at 21:12 -0400, Joshua Brindle wrote:
>> KaiGai Kohei wrote:
>>> The attached patch adds definitions of new classes and permissions,
>>> and MLS/MCS rules.
>>>
>>> Following items are differences from the first patch.
>>>
>>> * add "db_" prefix for each object classes.
>>>   e.g) "table" -> "db_table"
>>> * interfaces in policy/modules/kernel/mls.if are renamed.
>>>   - mls_database_read_up    -> mls_db_read_all_levels
>>>   - mls_database_write_down -> mls_db_write_all_levels
>>>   - mls_database_upgrade    -> mls_db_upgrade
>>>   - mls_database_downgrade  -> mls_db_downgrade
>>> * MLS attributes related to database are renamed
>>>   - mlsdatabaseXXXXX -> mlsdbXXXXX

>> These interface names seem kind of ambiguous, they could mean downgrade
>> the database files on disk or within an selinux aware database server.
>> They also have very low granularity, but I haven't decided if that
>> matters much.
>>
>> It would be nice to have less ambiguous interface names though.
> 
> All of the mls interfaces are coarse, as they make mls exemptions.  If
> it was talking about the files on disk, you would be using the mls file
> downgrade interface.

I don't have any special opinion about its naming scheme.
(It is possible to update the patch again, if necessary.)

Is there any other opinion for the "db_" prefixed new object classes?
I just started to modify SE-PostgreSQL to use these prefixed ones.

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
