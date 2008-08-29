Subject: Re: About Domain Transition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hong <kindloaf@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
References: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 09:16:25 -0400
Message-Id: <1220015785.5708.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-28 at 16:33 -0400, Hong wrote:
> Suppose a process is in domain "CurrDom".  Now the process invokes a
> program with type "Type".
> Following is my understanding of whether the execution can succeed,
> can anyone help me to see if it's correct?
> 
> (1) If "CurrDom" does not have "execute" permission on "Type" with
> security class "file"(or variations), access is denied.

Correct.

> (2) If there is a type_transition rule says that "CurrDom" should
> transition to "NewDom" after executing type "Type", then

Or if the process explicitly requests "NewDom" via setexeccon(3) prior
to invoking execve().

>      (2.1) If "CurrDom" does not have "transition" permission on
> "Type" with security class "file" (or variations), access is denied.

No, the transition check is:  If "CurrDom" does not have "transition"
permission to "NewDom" (class process), access is denied.

>      (2.2) If "NewDom" does not have "entrypoint" permission on "Type"
> with security class "file" (or variations), access is denied.

Correct.

>      (2.3) Access is granted if both (2.1) and (2.2) are passed.

Yes, with the modification above.

> (3) There is no type_transition rules says anything about new domain
> for "CurrDom" when executing "Type"

And the process did not explicitly request a new domain via
setexeccon(3) prior to invoking execve().

>      Access is granted only when "CurrDom" has "execute_no_trans"
> permission on "Type" with security class "file" (or variations).

Correct.

> I am not sure about following questions:
> (A)  In (2), if multiple type_transition rules specify a new domain
> for "CurrDom", what'll happen?

There can only be one type_transition rule per (domain, type, class)
tuple.  However, the application may explicitly request a particular
domain transition via setexeccon(3), and this will override any default
transition.

> (B)  In (1), what if CurrDom has permission "execute_no_trans"?

Makes no difference.

> (C)  If a process fails to transition to another domain in (2), and if
> CurrDom has permission "execute_no_trans", can it execute the program
> and stay in the current domain?

Only if it explicitly asks to stay in the same domain by using
setexeccon().

> Is there any documentation I can refer to so I can see how the access
> decision is made? Or where in the kernel source code above logic is
> implement?

http://www.nsa.gov/selinux/papers/module/x645.html
http://lxr.linux.no/linux+v2.6.26.3/security/selinux/hooks.c#L1946

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
