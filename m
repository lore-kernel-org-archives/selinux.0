Message-ID: <52652B51.8050601@tresys.com>
Date: Mon, 21 Oct 2013 09:25:37 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: James Carter <jwcart2@tycho.nsa.gov>,
        SELinux List
	<selinux@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382126564.3041.13.camel@d30> <1382189566.3041.34.camel@d30>
In-Reply-To: <1382189566.3041.34.camel@d30>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2013 09:32 AM, Dominick Grift wrote:
> On Fri, 2013-10-18 at 22:02 +0200, Dominick Grift wrote:
>> On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
>>> I pushed an update of CIL to bitbucket.
>>
>> I had to do this, to make it compile ( not sure what i might have broken
>> by doing this ):
>>
>> --- a/src/cil.c
>> +++ b/src/cil.c
>> @@ -1493,7 +1493,6 @@ void cil_userbounds_init(struct cil_userbounds
>> **userbounds)
>>          *userbounds = cil_malloc(sizeof(**userbounds));
>>
>>          (*userbounds)->user_str = NULL;
>> -       (*userbounds)->user = NULL;
>>          (*userbounds)->bounds_str = NULL;
>>   }
>>
>> Also a thing i noticed, which is unrelated to secilc, but related to
>> cilpolicy is that object_r role is associated to identities.
>>
>> The object_r string is not really a role, although it looks like it.
>>
>> Its just a string that is used as a place holder for the role security
>> attribute of objects.
>>
>> Anyhow, i am going to write a minimum policy with secilc tomorrow i
>> think, so maybe then i will find new bugs, insights.
>>
>> Thanks for your work
>>
>
> Been playing with this today and so far so good except for a few things:
>
> Not sure if its due to my incompetence or due to the line i removed
> ( see above) from cil.c, login programs (pam) is not able to get a valid
> context for my users. I believe i set all the associations up properly

Sounds like you've figure out this problem.

> I noticed that no matter if you just want to create a default policy
> model, you always have to take the option security models (MLS/MCS) into
> account at least to some degree. For example you need to specify current
> and clearance with filecon even if you wish to not use use MLS/MCS

We want to avoid optional arguments to and CIL statements. Because of 
this, the mls/mcs arguments are required, even when building non-mls/mcs 
policies.

> Another thing i noticed which is loosely related is that if you build a
> mcs policy, and install it, then run restorecon -R -v -F, it will reset
> contexts using current and clearance (it has s0-s0 specified in
> file_contexts) no matter how many times you run it. It will always reset
> from s0 to s0-s0

This should be easy enough to fix. If the low and high levels are the 
same, then we'll just output the low.

> As said above already, i now also encountered the object_r issue myself:
> it sucks. One needs to allow object_r role access to all types...
> object_r is not even a role (or atleast it should not be AFAIK)

True, but this actually isn't going to be bad. The majority of types are 
going to be associated with an attribute, and usually through a macro, e.g.:

   (type foo_t)
   (call files_type (foo_t))

Either the files_type macro could perform the object_r association:

   (macro files_type ((type t))
     (typeattributeset file_type t)
     (roletype object_r t))

or you could just associate object_r with the attribute somewhere else:

   (roletype object_r (file_type))

> Lastly i have to get used to the cil syntax, The documentation is a bit
> inaccurate. For example it seems that typeattributetypes was renamed to
> typeattributeset.

Yes, the documentation is lacking right now. There are still ongoing 
discussions on changes to the CIL syntax. As things settle down, we 
should be able to put some focus towards improving the documentation. 
Right now, the best source is probably Jim's cilpolicy.git repo.

> I was trying to associate 3 types to a single type attribute and i first
> encountered typeattribute set, and the example showed how its supposed
> to be used with "and or xor not", and so i tried that, but it turned out
> you can only associate two types to a type attribute using any of those
> keywords

I believe you can associate more than one type via the following:

   (typeattributeset attr (type1 type2 type3))

But, typeattributeset is one of the syntax changes we are discussing. As 
you mentioned, you can only associate two types to a type attribute 
using expressions. This is going to change. Of course it requires adding 
more parenthesis, but we already have a ton of those, so what's one more 
set.

> Later on i stumbled upon typeattributetypes, and the examples looked
> promissing. it mentioned that you can use it to associate more types to
> the attribute with it. But when i tried it, it turned out it no longer
> existed.

Yes, we replaced typeattributetypes with typeattributeset.

> However, i tied the strings together and managed to associate 3 types to
> a single type attribute using the typeattributetypes example with the
> typeattributeset statement.
>
> Also i was not able to write TE AV rules with two target types. e.g.
> where we previously used brace expansion: allow bla_t { foo_t
> bar_t }:file read;

Yes, the source/target parameters of the allow rule only allow a single 
type or typeattribute. CIL is not meant to be succinct. You'll find 
there's a great deal of repetition. The idea is that higher level 
languages would allow for succinctness.

> I tried several things like: (allow (bla_t ( foo_t bar_t))
> all_file_perms), but no go

If you really don't want two allow rules, you can create a typeattribute:

   (typeattribute foobar)
   (typeattributeset foobar (foo_t bar_t))
   (allow bla_t foobar all_file_perms)

But unless the foobar attribute has some kind of meaning, it probably 
makes more sense to just have two allow rules.

> It is just a matter of getting used to the new way of doing things, but
> i feel that its very powerful, and i like it alot.
>
> Also secilc seems nice and fast, especially if it also takes care of the
> neverallow rules (doing that with semodule link/expand takes ages)

It does check neverallow rules.

> So, yea, the only pressing issue now for me is to get my users to log
> in. I have created a nice minimal policy today with cil and other than
> this issue it works great!
>
>>     Classes:            54    Permissions:       193
>>     Sensitivities:       1    Categories:       1024
>>     Types:               4    Attributes:          1
>>     Users:               1    Roles:               2
>>     Booleans:            0    Cond. Expr.:         0
>>     Allow:              54    Neverallow:          0
>>     Auditallow:          0    Dontaudit:           0
>>     Type_trans:          0    Type_change:         0
>>     Type_member:         0    Role allow:          0
>>     Role_trans:          0    Range_trans:         0
>>     Constraints:         0    Validatetrans:       0
>>     Initial SIDs:       27    Fs_use:             23
>>     Genfscon:           84    Portcon:             2
>>     Netifcon:            0    Nodecon:             0
>>     Permissives:         0    Polcap:              2
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
