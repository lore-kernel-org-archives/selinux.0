Message-ID: <4E5E933B.6060604@manicmethod.com>
Date: Wed, 31 Aug 2011 16:02:03 -0400
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
>
> In the case of domain transition, it checks process:{transition}
> permission on a pair of source and target domain, and it also checks
> file:{entrypoint execute} permission on the security label of the file
> to be launched.
>

I think I hit the exact reason why this bothers me today. As 
staff_t:SystemLow-SystemHigh I wanted a stored procedure that ran at 
sepgsql_trusted_proc_t:SystemHigh (so that it could read a SystemHigh column and 
fuzz the results).

Because of the current process constraint:
  mlsconstrain process transition
        (( h1 dom h2 ) and
         (( l1 eq l2 ) or ( t1 == mlsprocsetsl ) or
          (( t1 == privrangetrans ) and ( t2 == mlsrangetrans ))));

it isn't possible unless staff_t is part of privrangetrans and 
sepgsql_trusted_proc_t is part of mlsrangetrans. I don't mind the latter but the 
former is clearly a violation of how MLS is suppose to work on multi-level 
SELinux systems (in general, unprivileged users should not be able to change 
their level without going through newrole or logging out and back in).

If there was a different object class for procedures-while-executing, akin to 
process but called something different we could have a different constraint that 
made more sense for this use case.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
