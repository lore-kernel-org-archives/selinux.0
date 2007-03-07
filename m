Message-ID: <45EEE1C1.4070804@tresys.com>
Date: Wed, 07 Mar 2007 11:01:05 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        russell@coker.com.au, selinux@tycho.nsa.gov
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
>>     
>
> How does this method compare to the schemes
> used in the Oracle evaluated MLS DBMS?
>
>   
IIRC Oracle basically has polyinstanciated tables (using views) to 
implement MLS, which gives far less granularity and doesn't allow for 
labeled rows or columns. KaiGai's work leverages all the security models 
SELinux can use to allow for flexible policies. The technical decision 
to use another table to store the oid of the context seems appropriate, 
since that is how rdbms's operate in general.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
