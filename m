Message-ID: <4DDFBBDC.9040909@tresys.com>
Date: Fri, 27 May 2011 10:57:32 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, <sds@tycho.nsa.gov>,
        <jmorris@namei.org>, <eparis@parisplace.org>, <selinux@tycho.nsa.gov>,
        Daniel
 J Walsh <dwalsh@redhat.com>
Subject: Re: v0 Add role attribute support to libsepol
References: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com> <4DDFAC9A.50903@manicmethod.com> <4DDFB3F3.9040009@manicmethod.com>
In-Reply-To: <4DDFB3F3.9040009@manicmethod.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/27/11 10:23, Joshua Brindle wrote:
> Joshua Brindle wrote:
>> Harry Ciao wrote:
>>>
>>> Comments:
>>> ---------
>>> Add role attribute to SELinux, which aims at replacing the deprecated
>>> role dominance rule.
>>
>> Thanks. This is going to take a bit of time to absorb and most of my
>> cycles are
>> in use at the moment. I'll definitely get around to looking at it though.
>>
> 
> I'd also like to solicit feedback from Dan and Chris as to how this will
> be used in policy, and as to whether this implementation is suitable.
> 
> Dan, Chris, opinions?

Do we really want to overload the attribute statement for declaring role
attributes?

If I understand the description correctly, it seems reasonable, but will
still run into problems for refpolicy.  We want to immediately use this
feature for handling chains of run interfaces.  For example, say we have
an admin (admin_r:admin_t) and he can run the foo program (foo_t
domain).  The foo program then runs the bar program (bar_t) domain.  The
(abbreviated) policy right now would look like this:

foo.te:
bar_domtrans(foo_t)

foo.if:
interface foo_run(
	type_transition $1 foo_exec_t:process foo_t;
	role $2 types foo_t;
	bar_run($1,$2)
)

The reason we do this is so that the bar_t is added on to the admin_r
role, without adding a direct transition from admin_t to bar_t.  But the
above gets messy when the policy writer forgets to put the accompanying
bar_run() call in the foo_run() interface implementation.  With role
attributes it would be simplified to:

foo.te:
role foo_roles types foo_t;
bar_run(foo_t, foo_roles)

foo.if:
interface foo_run(
	type_transition $1 foo_exec_t:process foo_t;
	roleattribute $2 foo_roles;
)

But the problem that I suspect we'll see is what happens the bar_run()
interface also has a role attribute?  Extending the above example:

bar.if:
interface bar_run(
	type_transition $1 bar_exec_t:process bar_t;
	roleattribute $2 bar_roles;
)

When the policy is expanded, you end up getting a roleattribute
statement that has all role attributes in it:

roleattribute foo_roles bar_roles;

This should result in bar_roles being a superset of foo_roles.  It
doesn't sound like this is being done.  There is at least one example of
this case in refpolicy, see rpm_run() and seutil_run_semanage(); caller
runs rpm->rpm_script->semanage->load_policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
