Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36EqYDo018401
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 10:52:34 -0400 (EDT)
Received: from mail-old.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36EoCkY007800
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 14:50:13 GMT
Message-ID: <4253F745.9070609@kaigai.gr.jp>
Date: Wed, 06 Apr 2005 23:50:45 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp> <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil> <4236CC03.5010104@kaigai.gr.jp> <200504062249.14886.russell@coker.com.au>
In-Reply-To: <200504062249.14886.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, Thanks for your comments.

Russell Coker wrote:
> On Tuesday 15 March 2005 22:50, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
>
>>Does 'unifying file type' means as follows ?
>>e.g)
>> /var             ... var_t
>> /var/lib         ... var_lib_t extends var_t
>> /var/log         ... var_log_t extends var_t
>> /var/log/message ... var_log_message_t extends var_log_t
>>Of course, such a usage is also possible.
>
>
> This is an example of how not to do it.
>
> Many domains need search access to /var.  Most of them should not be granted
> any access to /var/log, but your example would have them granted search
> access to /var/log as var_log_t inherits from var_t.
>
> Many domains access /var/log (probably more than we desire but that's a
> separate issue - the fact that user_ssh_t is granted read access to files of
> type var_log_t seems like a policy bug to me).  /var/log/message may have
> data that is more secret than the other files/directories labeled as
> var_log_t, and we don't want user_ssh_t to read it.

Yes, you are right.
The above /var/XXX is not appropriate for example, I also think now.


>>I have an idea that ALLOW statement is added an new option
>>For example:
>>  ALLOW @user_t @user_t:process {ptrace};
>>  ALLOW user_t @user_t:process {transition};
>
>
> I don't like that idea.  Tracking when the '@' symbol should be used will be
> beyond the skill of most people who write policy.  Then there is the issue of
> someone writing a domain with the idea that it will never be used for
> inheritance but then having it used for inheritance later.  If the inherited
> domain has it's policy in the public repository then things can get fixed,
> but if someone inherits a domain for their own private use then they could
> get surprised by a policy update that grants some access they didn't expect
> because the upstream policy developers didn't plan for inheritance and didn't
> use the '@' symbol.

I think that the required skill for tracking the security policy with inherited type
is same as one for the security policy writen with attributes.
Tracking difficulty will not change between the legacy statement and new one.

But I understand your concern about an inherited domain.
My original idea was started from 'inherited domain', but I noticed
the worth of 'unified type' via this discussion.

This statement can't ban an 'inherited domain', but it will not be
significant requirement for using '@' prefix for any domain in upstream policy.
It's more importantly that the permissions of Apache/Samba/FTPd/etc... to
its contents files/directories will be granted with '@' prefix for extensiton
on end-user configuration.


> Your message on the 23rd of March seems to be OK in terms of access, but I
> doubt that the '@' operator will result in good policy.

I think that '@' prefix and inheritable type can reduce the amount of description
and redundancy. Indeed, it's not resolve all of the difficulty for policy description.

> About a year ago I was involved in some discussions about these issues, and
> one of the major factors was how to deal with user_t/user_r/user_ssh_t and
> other_t/other_r/other_ssh_t type inheritance.  One of the NSA guys asked me
> to write up a proposal for how to do this.  After thinking about it for a
> year I haven't devised a good answer.  If your work can result in a solution
> to this problem then I'm sure that everyone will be willing to accept some
> trade-offs.  But currently I am not convinced that the benefits outweigh the
> costs of this.

Does the example of user_t/user_r/user_ssh_t mean 'inherited domain'?
It has not been a significant issue yet, I think.
I think it's enough benefit to create a new type which can be accessed from
multi domains. (e.g Apache & FTPd shared directory)

Thanks,
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
