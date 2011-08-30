Message-ID: <4E5D6F62.40900@manicmethod.com>
Date: Tue, 30 Aug 2011 19:16:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sepgsql and process transition
References: <4E5D2DBA.9060201@manicmethod.com> <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com>
In-Reply-To: <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei KaiGai wrote:
> The reason why we check process:{transition} permission on invocation
> of trusted procedures is an analogy to execution of program with
> domain transition.

Analogy, sure, but not a process and not a domain.

>
> In the case of domain transition, it checks process:{transition}
> permission on a pair of source and target domain, and it also checks
> file:{entrypoint execute} permission on the security label of the file
> to be launched.
>
> Let's replace the file by a database object.

That is the crux. A database object isn't a file and a stored procedure 
isn't a process. We've abused kernel object classes before but as far as 
I'm concerned we need to stop.

> When a trusted procedure is invoked, it checks process:{transition}
> permission on a pair of source and target *domain*. Please note that
> "sepgsql_trusted_proc_t" is a domain, not an object within
> db_procedure class.

It is a different class then, db_process, db_domain, whatever.

> And, it also checks db_procedure:{entrypoint execute} permission on
> the security label of the procedure to be launched.
>

> Also note that sepgsql_trusted_proc_exec_t is a label to be assigned
> on db_procedure class; as an entrypoint of trusted procedure.

Yes, so db_procedure is more like file, we need a database object class 
that is more like process.

>
>
> 2011/8/30 Joshua Brindle<method@manicmethod.com>:
>> Kaigai, I'm taking a look at the latest Postgresql master and I see that you
>> are using process:transition permission to check access to transition from
>> one type to another for trusted procedures.
>>
>> Why didn't you add a transition permission to db_procedure? We are trying
>> not to reuse kernel object classes for userspace object managers these days
>> (I know we haven't been great about that in the past). I know this situation
>> is a little tricky because the beginning type is a process type (domain) and
>> the ending type is a procedure type, which closely maps to a domain type.
>>
>> The beginning type may not always be a domain type though, if a procedure
>> calls another procedure, or if postgres user session types become derived
>> types (user_t ->  sepgsql_user_t) we could completely divorce process types
>> from postgres types.
>>
>> Stephen, do you have an opinion on this?
>>
>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
