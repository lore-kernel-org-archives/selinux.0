Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6M1f7To001350
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 21:41:07 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6M1f5Og025236
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 01:41:06 GMT
Message-ID: <48853AA5.3040607@ak.jp.nec.com>
Date: Tue, 22 Jul 2008 10:40:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andrew Warner <warner@rubix.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com> <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
In-Reply-To: <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> I have also considered maintaining my own internal, persistent mapping
>> between string based contexts and an integer representation, the mapping
>> being stored/indexed inside the DBMS. This gives me a small storage overhead
>> with a fixed size.
> 
> I don't have a problem with internal mapping like that.

In SE-PostgreSQL, it maintains own internal mapping between text represented
security context and its integer identifier. The 'pg_security' system catalog
stores the pair of them.

Any tuple (including system catalog) has its security context. It is stored
within padding area of HeapTupleHeader as an integer value, and it means the
primary key of 'pg_security' system catalog.

It also enables to boost userspace AVC, because this idea makes possible to
implement it using a relationship between identifiers (not a text representation).


When the security policy is reloaded and it makes invalidate the stored context,
the stored one is dealt as 'unlabeled_t'.

> But, don't we already have sepostgresql?  Maybe you should be looking
> to see if that fits your needs or you might get ideas from the work
> that they performed?

FYI:
   http://code.google.com/p/sepgsql/

Andrew, what is your intended base RDBMS?

Currently, SE-PostgreSQL is the only SELinux awared RDBMS.
It is now under reviewing for the next release (v8.4) cycle.
   http://wiki.postgresql.org/wiki/CommitFest:2008-07

However, I think we can apply SELinux for any other relational model implementation.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
