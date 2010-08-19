Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7JCsk2e014320
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 08:54:46 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o7JCsbqT001634
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 12:54:37 GMT
Message-ID: <4C6D2994.6060109@tresys.com>
Date: Thu, 19 Aug 2010 08:54:44 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: TaurusHarry <harrytaurus2002@hotmail.com>, refpolicy@oss1.tresys.com,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Problem about audit-test-2090 + refpolicy-2.20091117
References: <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl>	,<1282132367.4122.8.camel@flek>	<SNT139-w499FFC8245BD574722F9F6AB9D0@phx.gbl> <1282145393.4122.45.camel@flek>
In-Reply-To: <1282145393.4122.45.camel@flek>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/18/10 11:29, Paul Moore wrote:
> On Wed, 2010-08-18 at 13:24 +0000, TaurusHarry wrote:
>> Many many thanks for your response!
>>
>> Well, after I installed SELinux header properly then I did could enter
>> audit-test/utils/selinux-policy/ successfully built lspp_test.pp
>> there, however, I run into below error messages when trying to insert
>> it:
>>
>> [root/secadm_r/s0@qemu-host selinux-policy]# semodule -i lspp_test.pp
>> libsepol.expand_terule_helper: conflicting TE rule for
>> ( lspp_test_generic_t, sepgsql_db_t:db_table): old was
>> user_sepgsql_table_t, new is sepgsql_table_t
>> libsepol.expand_module: Error during expand
>> libsemanage.semanage_expand_sandbox: Expand module failed
>> semodule: Failed!
>> [root/secadm_r/s0@qemu-host selinux-policy]#
>>
>> Very honestly speaking I am clueless about such error message, so I
>> tried to compile lspp_test.pp along with refpolicy source code just to
>> see if such problem could simply disappear. Do you have some comments
>> or suggestions about it?
>
> Hmm, it looks like perhaps there is a conflict with the sepostgres
> policy?

Yep, there are conflicting type_transitions.  Basically it is 
complaining about these two rules:

type_transition lspp_test_generic_t sepgsql_db_t:db_table 
user_sepgsql_table_t;

type_transition lspp_test_generic_t sepgsql_db_t:db_table sepgsql_table_t;

so it fails.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
