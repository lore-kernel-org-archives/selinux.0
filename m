Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2R2Z8LD016646
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 22:35:08 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2R2Z6Ht011415
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 02:35:07 GMT
Message-ID: <49CC3B48.3070006@ak.jp.nec.com>
Date: Fri, 27 Mar 2009 11:34:48 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Matthew Booth <mbooth@redhat.com>
CC: linux-audit@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] database audit integration (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>	<49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1C7A.2050206@ak.jp.nec.com> <49CB313B.7020507@redhat.com>
In-Reply-To: <49CB313B.7020507@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Matthew Booth wrote:
> KaiGai Kohei wrote:
>> Hello,
>>
>> I'm a developer of SE-PostgreSQL which is an enhancement of
>> database security using SELinux. It enables to apply the
>> security policy of the operating system on accesses to
>> database objects also.
>> It makes an access control decision and audit messages, but
>> these are not written out to system audit mechanism.
>>
>> I believe our preferable behavior is the system audit collects
>> all the audit messages come from SELinux, not a logfile of
>> PostgreSQL.
>>
>> Currently, the audit-libs has an interface to write a message
>> come from userspace avc, but some of parameter is not suitable
>> for the reference monitor in database management system.
>>
>> This patch adds a new interface as follows:
>>     int audit_log_database_message(int audit_fd, int type,
>>                                    const char *message,
>>                                    const char *hostname,
>>                                    const char *addr,
>>                                    const char *dbuser);
>>
>> It is differ from audit_log_user_avc_message() in the point of
>> a new parameter of dbuser, instead of tty and uid.
>> I don't think these are meaningful information for DBMS, but
>> we would like to record what database user invokes this audit
>> record.
> 
> A few points:
> 
> When I have tried to use this mechanism in the past I have found the
> existing proliferation of user messages types confusing. If possible,
> please don't add a new custom message to the library. Instead, maybe it
> would be better to recognise that there will be continue to be new and
> unanticipated uses for structured audit data, and provide an api which
> allows that to be expressed.

What I would like to audit is AUDIT_USER_AVC type message, not a new
custome message type. But the current interface does not allow to
record some of meaningful information.
So, it was necessary to propose a new audit_log_database_message().
Perhaps, it might be misnamed. If confusable, it is possible to rename
it something like audit_log_db_avc_message().

> While where may be no tty as such, the idea is still meaningful.
> Specifically, one of the first things an auditor will want to know is
> where the user who performed a particular action logged on from. If you
> have that information, you should include it in the audit record.

In this case, all the audit record has same tty which is used by
the server process, independent from the client who performed a
particular action. :(

> A concept of a session ID would probably have meaning in this context.
> If you have one, or can create one, please include it in all messages,
> including login messages.

When a database client connects to the server via TCP/IP, we don't have
any valid session id. In addition, the server does not have a method to
know what session id is used for the client logged in.

> Lastly, please no freeform text! It should be possible to determine
> everything relevant about an event without looking at freeform text.

Yes, the expected style is same as ones for audit_log_user_avc_message(),
without any freedom text. The most significant purpose is to allow users
to use utilities such as audit2allow.

> I look forward to playing with this :)

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
