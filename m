Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j372JfDo022829
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 22:19:45 -0400 (EDT)
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j372HAkY021278
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 02:17:12 GMT
Message-ID: <425497FF.9090705@ak.jp.nec.com>
Date: Thu, 07 Apr 2005 11:16:31 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: russell@coker.com.au
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp> <200504062249.14886.russell@coker.com.au> <4253F745.9070609@kaigai.gr.jp> <200504070130.46902.russell@coker.com.au>
In-Reply-To: <200504070130.46902.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

>>I think that the required skill for tracking the security policy with
>>inherited type is same as one for the security policy writen with
>>attributes.
>
>
> When inspecting policy to determine it's operation you can see a list of
> attributes on a type declaration and know that each applies to the type.
>
> With inheritance as you describe you have exclusion rules such that you don't
> necessarily know that domain user_foo_t can access bar_t just because user_t
> can access bar_t and user_foo_t inherits.

Is it same as attributes work ?
A permission is often granted implicitly via attributes.
We have to check a type declaration and attached attributes,
when a permission is granted to types/attributes.

When a type is declared with attribute, we have to check this.
When a type is declared with parent type, we have to check this.
Both are essentially same, I think.

> If we want to make a change to the inheritance it doesn't change the access
> granted to just one domain or type but instead it operates on an unknown
> number of domains/types.

Sorry, what does mean 'make a change to the inheritance' ?

If it means that changing the permission attached to parent-type make effects
to some child-types, 'unknown number of domains/types' is over expression.
A permission granted via parent-type is limited to child-types explicitly
declared as an inherited type.

If it means that changing the relationship between parent and child make effects
to some child-types, it is fact that we have to grant all necessary permissions
to child-types from scrach. But I think it's redundant and needlessness.
This situation is similar trying to declare a new file-type without file_type attributes.


>>Does the example of user_t/user_r/user_ssh_t mean 'inherited domain'?
>>It has not been a significant issue yet, I think.
>>I think it's enough benefit to create a new type which can be accessed from
>>multi domains. (e.g Apache & FTPd shared directory)
>
>
> It does mean inherited domain.
>
> I want to write policy such that someone can load a binary policy module for a
> new user role professor_r which then automatically creates the domain
> professor_foo_t because the base policy has appropriate statements that are
> equivalent in functionality to the macros we currently use in macros/programs
> for such things.

Generally, any methods have strong and weak point.
I have no intention to disallow the availability of existing macros.
Each methods should be used for own strong point.

Thanks,
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
