Message-ID: <487D5A3D.6090801@ak.jp.nec.com>
Date: Wed, 16 Jul 2008 11:17:33 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [RFC] An idea of thread/child-domain assignment
References: <487C7698.60503@ak.jp.nec.com> <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-07-15 at 19:06 +0900, KaiGai Kohei wrote:
>> Hi,
>>
>> I'm now considering the way to apply SELinux from the bottom of LAPP
>> stack to the head. But there is a fundamental matter. Web/Application
>> server can execute a request come from users in a worker thread.
>>
>> This idea enables to assign an indivisual domain on a thread under
>> the paticular condition.
> 
> Yes, this came up recently, e.g.:
> http://marc.info/?l=selinux&m=121320242220824&w=2
> 
> And James added it to the kernel todo list on selinuxproject.org.

Thanks, I overlooked this message.


>> An idea: thread/hierarchical-domain assignment
>> ----------------------------------------------
>> If possible, Apache should change the security context of web backend
>> during it executes a request come from users.
>> However, Apache can execute it on a worker thread. It conflicts a wired
>> constraint of SELinux which does not allow a multi-threaded process dynamic
>> domain transition.
>>
>> It is a reasonable constraint, if the source and destination domains are
>> completely independent. Because it shares a local memory, mixed security
>> context within a process can make a violation in domain separation.
>>
>> However, a characteristic relationship between hierarchical domains can
>> help the situation. It restricts a child domain (like "httpd_t.staff")
>> cannot over the boundary of its parent ("httpd_t"). It also means
>> a multi-threaded process cannot over the (parent) domain boundary,
>> even if a part of threads has different security context.
>>
>> My suggestion is the hard-wired constraint should be modified.
>> It allows to assign threads an indivisual domain, if the new domain
>> is a child one of the current domain.
>>
>>   For example:
>>     httpd_t -> httpd_t.staff           = allowed
>>     httpd_t -> staff_t                 = disallowed
>>     httpd_t.staff -> httpd_t.staff.php = allowed
>>
>> In other words, this idea requires to change our viewpoint for child domain.
>> Previously, these are mutually independent domain, but a child domain will
>> mean a state with restricted operations compared to its parent domain.
> 
> I tend to agree that we should support such changes in the kernel
> mechanism and let the use of it be determined by the policy.
> 
> In terms of hierarchy though, the plan was to replace the current
> name-based hierarchy with an explicitly declared hierarchy.

It needs a new policy statement like:

  TYPE <child domain> DOMBY <parent domain>;
    or
  TYPEDOMINANCE <parent domain> <child domain> [,<child domain>] ;

I guess these relationships are represented as a ebitmap structure
in the kernel, and used to mask permissions during AVC entry creation.

>> Issues: Domain Reverting
>> ------------------------
>> There is a related issue. To change security context during user request
>> execution also means that we have to revert its domain after executions,
>> because Apache repeatedly uses worker thread/process for some reasons.
>>
>> I don't have any good idea for this issue yet.
>> A one time cookie like AppArmor is an approach, but it is basically weak
>> separation compared from execve() transition.
> 
> Perhaps it could pre-populate different pools of threads for different
> client security contexts, and then just draw from the correct pool for
> each client.  Then the thread context doesn't have to be reverted at all
> and we can make the transition unidirectional.

I think this approach requires two precondition.

(1) The number of client security context should be enough small.
 If we want to assign one of MCS categories, it requires 1024 of thread
 pool in maximum.

(2) We have to know what client security context should be assigned
    before the communication between client and backend thread.
 In the case when we use HTTP authentication to decide client security
 context, the authentication process has to be done in the backend
 process after the communication started.
 It may also require major works in application updates.

In my impression, AA's approach is not perfect, but second best one...

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
