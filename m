Message-ID: <42AC5B89.9080902@kaigai.gr.jp>
Date: Mon, 13 Jun 2005 00:58:01 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "SELinux(NSA)" <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] independent with attribute declararion oeder for attachment
References: <42AC23B6.8070304@kaigai.gr.jp> <42AC457C.6020805@tresys.com>
In-Reply-To: <42AC457C.6020805@tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Joshua, Thanks for your comments.

This patch does NOT mean implict declaration of attribute, ALL attributes
require explict declaration when it's used in any TE statements such as ALLOW.
I wrote this patch to resolve declaration ordering problem. The feature of
problem is different from ROLE statement does not has explicitly declaration
statement.

Currently, the declaration statement of attribute must be placed in forward
of where it is used by any TE statements and TYPE declaration.
After you apply this patch, the declaration statement of attribute must be
placed in forward or backward of where it is used.
So, we still require ATTRIBUTE statments for explict declaration.

We can always discover an attribute declaration per effective attribute
in policy sources.
(An attached attribute to type without declaration is ignored.)
Does the declaration order in the policy source have a significant effect
for Tresys's loadable policy module ?

Thanks,

>>The following actions are same as current checkpolicy.
>>* ALLOW and any TE statements with undeclared attributes are restricted.
>>* Duplicate attribute declaration is restricted.
>>
>>* Any attribute need a declaration by ATTRIBUTE statement.
>>
> 
> It is undesirable to implicitly declare symbols by using them. In fact
> with the loadable policy modules this becomes problematic since we have
> to keep track of all dependancy information. For example, since roles
> are declared implicitly when assigned a type it isn't possible to
> discern declaring a role from using a role. In a module using a role
> should always have a dependancy on the role but declaring it wouldn't.
> This is something we are trying to solve but adding more implictly
> declared symbols would only make it harder.
> 
> Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
