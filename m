Message-ID: <4236CC03.5010104@kaigai.gr.jp>
Date: Tue, 15 Mar 2005 20:50:27 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp>	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>	 <4235C937.3030404@kaigai.gr.jp> <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen, Thanks for your comments.

>> This makes sense for unifying file types, as in the earlier multiple
>> contexts thread.  I'm not sure I see how it is useful for domains; any
>> permissions allowed to the child domain can be indirectly gained by the
>> parent domain (or any domain which can control the parent domain) and
>> any program executables that can be used to enter the parent domain can
>> be used to enter the child domain, so you might as well just directly
>> allow the permissions to the parent domain.  As a trivial example, if
>> you declare 'type user_ext_t extends user_t;', then user_t gets ptrace
>> permission to user_ext_t because it has ptrace permission to itself, so
>> any user_t process has full control over user_ext_t and can thus
>> exercise its permissions at will.

Does 'unifying file type' means as follows ?
e.g)
 /var             ... var_t
 /var/lib         ... var_lib_t extends var_t
 /var/log         ... var_log_t extends var_t
 /var/log/message ... var_log_message_t extends var_log_t
Of course, such a usage is also possible.

In user_t/user_ext_t example, user_ext_t is same as user_t without tiny difference.
Thus, it is strange, if user_t process which has a permission to user_t does not
have a same permission to user_ext_t.
Common part of user_t and user_ext_t should have a permission for each other, I think.
The outbounds part of user_ext_t from user_t should not have a permission
for each other, indeed.

>>>>I think definition of reductive permission child-type/domain is the next
>>>>action assignment. If child does not need a part of the parent's permissions,
>>>>those should be revoked by DENY statement for example.
>
>>
>>
>> Hmmm...given the way in which you are computing inheritance, it seems
>> that it could be very easy to miss something being implicitly allowed
>> and fail to define a corresponding deny statement.  Maintainability also
>> becomes a problem as you have to reassess the deny rules whenever a new
>> allow rule is added.  And we need to consider not only limiting the
>> child, but limiting the parent from controlling the child, if we are
>> going to allow more permissions to the child than the parent.

I want to reserve this matter once for a certain time.
Because there is a problem as you notice, and I noticed the amount of modification
with DENY implementation is so large.
Sorry, I want to concentrate the discussion for TYPE ... EXTENDS first.

>>>>When child_t inherit parent_t, "allow parent_t parent_t:process sigkill;"
>>>>is unrolled to "allow {parent_t child_t} {parent_t child_t}:process sigkill;"
>>>>The number of conbination is 4.
>>>>
>>>>"allow parent_t self:process sigkill;" is unrolled as follows:
>>>>  "allow parent_t parent_t:process sigkill;"
>>>>  "allow parent_t child_t:process  sigkill;"
>>>>  "allow child_t  child_t:process  sigkill;"
>
>>
>>
>> The latter is more in line with what I would expect, and regardless, I
>> think that they should be unrolled consistently regardless of whether
>> the allow rule was written with "self" or explicitly with the same
>> domain (or an attribute that included the domain); self was purely
>> intended as a convenience notation and a way to express the self
>> relationship when using an attribute/set for the source type.

I see.
But I thought it may be unnaturalness that child_t doesn't have a permission to parent_t.
What you say first is straightforward explanation.
It's natual "allow parent_t self:..." is unrolled to
"allow {parent_t child_t} {parent_t child_t}:...", and I'll fix it.

>> Typically, when creating a derived domain (e.g. for a program run by a
>> user domain), we don't want to inherit any of the transition rules of
>> the base user domain.  A template-based approach as suggested by Karl
>> seems necessary here, effectively turning the existing macro constructs
>> into a language feature.

In my implementation, derived domain inherit any of transition rules of
the own parent domain in default. If we don't want to apply same type
transition rules, we must define a different rules to derived domain
explicitly.
So, I can't decide whether this essence is advantage or disadvantage...

In addition, it's possible not to decide a transition type/domain
when a type has multiple parents. Should the number of parent
types/domains be limited to one ?

Thanks.
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
