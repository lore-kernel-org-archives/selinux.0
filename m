MIME-Version: 1.0
In-Reply-To: <4E5D2DBA.9060201@manicmethod.com>
References: <4E5D2DBA.9060201@manicmethod.com>
Date: Tue, 30 Aug 2011 22:48:58 +0200
Message-ID: <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com>
Subject: Re: sepgsql and process transition
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Joshua Brindle <method@manicmethod.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The reason why we check process:{transition} permission on invocation
of trusted procedures is an analogy to execution of program with
domain transition.

In the case of domain transition, it checks process:{transition}
permission on a pair of source and target domain, and it also checks
file:{entrypoint execute} permission on the security label of the file
to be launched.

Let's replace the file by a database object.
When a trusted procedure is invoked, it checks process:{transition}
permission on a pair of source and target *domain*. Please note that
"sepgsql_trusted_proc_t" is a domain, not an object within
db_procedure class.
And, it also checks db_procedure:{entrypoint execute} permission on
the security label of the procedure to be launched.

Also note that sepgsql_trusted_proc_exec_t is a label to be assigned
on db_procedure class; as an entrypoint of trusted procedure.


2011/8/30 Joshua Brindle <method@manicmethod.com>:
> Kaigai, I'm taking a look at the latest Postgresql master and I see that you
> are using process:transition permission to check access to transition from
> one type to another for trusted procedures.
>
> Why didn't you add a transition permission to db_procedure? We are trying
> not to reuse kernel object classes for userspace object managers these days
> (I know we haven't been great about that in the past). I know this situation
> is a little tricky because the beginning type is a process type (domain) and
> the ending type is a procedure type, which closely maps to a domain type.
>
> The beginning type may not always be a domain type though, if a procedure
> calls another procedure, or if postgres user session types become derived
> types (user_t -> sepgsql_user_t) we could completely divorce process types
> from postgres types.
>
> Stephen, do you have an opinion on this?
>



-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
