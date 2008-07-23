Message-ID: <4886AC81.9030202@ak.jp.nec.com>
Date: Wed, 23 Jul 2008 12:58:57 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [RFC] An idea of thread/child-domain assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com>
In-Reply-To: <48803685.1000505@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
>>>>> An idea: thread/hierarchical-domain assignment

Now, under constracting a patch.

>>>>> Issues: Domain Reverting
 - snip -
>>> (1) The number of client security context should be enough small.
>>>  If we want to assign one of MCS categories, it requires 1024 of thread
>>>  pool in maximum.
>> The main server thread could lazily create the thread pools as needed to
>> avoid unnecessary pools.  And we could possibly use a hybrid scheme
>> (e.g. one pool per sensitivity or per equivalence class of categories,
>> reuse within that pool).
> 
> I guess it requires massive reworks for Apache itself. :(
> 
> If so, it may be better to implement a SELinux specific multi processing
> module (MPM) which creates a child process with restricted domain per
> request?
> (No need to say, we will get some performance degradation.)

I reconsidered that SELinux awared MPM is better way than reverting domain
of backend processes/threads.

It requires a certain level of performance degrading compared to existing
MPMs (prefork/worker), but forking a child process for a single request
and existing later model is suitable for SELinux.
I have an assumption here that performance is not the first priority for
users of SELinux awared Apache.

I like to add it to my TODO list.

BTW, is there anyone good at the behavior of Tomcat?
>From its documentation, Tomcat create a thread for a single request and
kills it after processing, when thread pooling is disabled.
It seems to me that here is no domain reverting issues.
Is it correct?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
