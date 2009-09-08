Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n880tK9k002275
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 20:55:20 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n880sdTu017441
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 00:54:40 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n880tGs3028956
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 09:55:16 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n880tGL26533 for selinux@tycho.nsa.gov; Tue, 8 Sep 2009 09:55:16 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id n880tGnY017380
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 09:55:16 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id D916EE4FD5C
	for <selinux@tycho.nsa.gov>; Tue,  8 Sep 2009 09:55:15 +0900 (JST)
Message-ID: <4AA5AB73.6050306@ak.jp.nec.com>
Date: Tue, 08 Sep 2009 09:55:15 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Limitations in modular policy
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any good reason why the current modular policy doesn't, cannot
or shouldn't support to contain definitions of object classes and its
access vectors except for the base policy?

For example, it seems to me reasonable to have the following statement
to support experimental object classes and access vectors.
--------------------------------
policy_module(sepostgresql-devel, 1.23)

gen_require(`
    class db_database all_db_database_perms;
    attribute sepgsql_unconfined_type;
    type sepgsql_db_t;
')

## 1. Add an experimental access vector
class db_database { superuser };

## 2. Add an experimental object class
class db_schema
inherits database
{
	search
	add_name
	remove_name
};

## 3. Add an experimental MLS/MCS rules
ifdef(`enable_mcs',`
	mlsconstrain db_database { superuser }
		( h1 dom h2 );
	mlsconstrain db_schema { create relabelto }
		(( h1 dom h2 ) and ( l2 eq h2 ));
	mlsconstrain db_schema { drop getattr setattr relabelfrom search add_name remove_name }
		( h1 dom h2 );
')
ifdef(`enable_mls`,`
	  :
	<snip>
	  :
')
## 4. avtab rules currently supported
type sepgsql_schema_t;

allow sepgsql_unconfined_type sepgsql_db_t : db_database *;
allow sepgsql_unconfined_type sepgsql_schema_t : db_schema *;
--------------------------------

Currently, SE-PostgreSQL has several experimental object classes and access
vectors (such as db_schema class and db_database:{superuser}), but we will
need more several months to fix its specifications at least, because progress
in the pgsql-hackers too slow.
So, we must replace the standard selinux-policy package to run it with full
functionalities, but it will get troubled for each "yum update".

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
