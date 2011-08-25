Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PBGcc5028666
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 07:16:38 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PBGbUn009419
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 11:16:37 GMT
Message-ID: <4E562F14.8020405@tresys.com>
Date: Thu, 25 Aug 2011 07:16:36 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: <refpolicy@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"
References: <SNT139-W51733746CAFD339C4E9177AB2E0@phx.gbl>,<4E53AEC0.7040009@tresys.com> <SNT139-W1481D4140E5F66541BA29FAB110@phx.gbl>,<4E54ED50.3060802@tresys.com> <SNT139-W395816A4087EE52F92B2B8AB100@phx.gbl>
In-Reply-To: <SNT139-W395816A4087EE52F92B2B8AB100@phx.gbl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/24/11 23:10, HarryCiao wrote:
> Hi Chris,
> 
>> Date: Wed, 24 Aug 2011 08:23:44 -0400
>> From: cpebenito@tresys.com
>> To: harrytaurus2002@hotmail.com
>> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
>> Subject: Re: [refpolicy] My patchset to test "Separating tunables from
> booleans"
>>
>> On 08/24/11 01:39, HarryCiao wrote:
>> >> Date: Tue, 23 Aug 2011 09:44:32 -0400
>> >> From: cpebenito@tresys.com
>> >> To: harrytaurus2002@hotmail.com
>> >> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
>> >> Subject: Re: [refpolicy] My patchset to test "Separating tunables from
>> > booleans"
>> >>
>> >> On 08/23/11 06:27, HarryCiao wrote:
>> >> > This is the refpolicy patchset to test along with new toolchain
> feature
>> >> > of separating tunables from booleans, generally speaking a "tunable"
>> >> > keyword is introduced and made use of by tunable_policy(),
> whereas a new
>> >> > boolean_policy() macro would make use of the "bool" keyword.
>> >> >
>> >> > tunable is indeed a boolean, except that the
> COND_BOOL_FLAGS_TUNABLE bit
>> >> > would be set in the newly added member of flags in the
> cond_bool_datum_t
>> >> > structure.
>> >> >
>> >> > Once the new toolchain feature is welcomed and merged, we could
> change
>> >> > refpolicy to shrink policy.X size significantly.
>> >> >
>> >> > Any comments or suggestions as for how to better this new toolchain
>> >> > feature are greatly welcomed.
>> >>
>> >> To make sure I understand correctly, a tunable block will have the same
>> >> token in the raw policy as runtime conditional blocks? e.g.
>> >>
>> >> tunable foo false;
>> >> if (foo) {
>> >> ....
>> >> }
>> >>
>> >> If tunable blocks use the same token, I think Refpolicy would just drop
>> >> the tunable_policy() macro.
>> >>
>> >
>> > The tunable identifier won't be written to policy.X.
>> >
>> > During link, the logically "true" branch of its if-else branches would
>> > be treated as permanent rules and append to the end of decl->avrules
>> > list, resulting in expanded and registered into te_avtab hashtab.
>> >
>> > As for boolean, the identifier would be written to policy.X and both
>> > if-else branches would be expanded and registered to te_cond_avtab
>> > hashtab, so is the cond_node_t for boolean.
>> >
>> > Both tunable and boolean identifier would share the same
>> > cond_bool_datum_t structure, a flag(COND_BOOL_FLAGS_TUNABLE) has been
>> > introduced to differentiate them, which wo uld be set only when the
>> > identifier is defined/required by "tunable" keyword.
>> >
>> > So both "tunable" and "bool" keywords would have to be supported by
>> > toolchain, so are tunable_policy() and boolean_policy() macros.
>>
>> I don't understand why you say boolean_policy() and tunable_policy()
>> macros are needed. Based on the implementation in your test patch, they
>> are not different in the raw policy. Are you suggesting it for the
>> automatic bool/tunable gen_require block generation?
>>
> 
> boolean_policy() and tunable_policy() are not for raw policy, their goal
> is to tell toolchain the difference between a boolean and a tunable, and
> that's all.

Yes I know that.  Please give an example of declaring a tunable and
making a tunable block, in the raw policy.


>> >> There are no examples of this in Refpolicy, but can you mix
> Booleans and
>> >> tunables in an expression? e.g.
>> >>
>> >> tunable foo true;
>> >> boolean bar true;
>> >> if (foo || bar) {
>> >> ....
>> >> }
>> >>
>> >> I'd say its not a requirement, I'm just trying to make sure I
> understand
>> >> the features.
>> >
>> > Yes, there is just one example in refpolicy. As showed in my test
>> > results, the pppd_can_ismod identifier is declared by gen_tunable(),
>> > however, it is used along with secure_mode_insmod boolean in ppp.te.
>> >
>> > Such hybird expression is not welcomed I guess, so some warning
>> > information would be printed out during link. In my test result, the
>> > secure_mode_insmod would be blamed, since it's declared by gen_bool()
>> > but used in tunable_policy(), which would require it as a tunable.
>> > (That's also why until all p_bools.table from all modules have been
>> > copied during link could we finally determine if a cond_bool_datum_t is
>> > indeed a boolean or tunable)
>>
>> The reason it has to be like this is because nested conditional policy
>> is not supported. Otherwise it would be written like:
>>
>> tunable_policy(`pppd_can_insmod',`
>> modutils_domtrans_insmod(pppd_t)*> ')
>>
>>
>> > For such situation since it would be difficult to correctly remove the
>> > cond_expr_t for tunables and related operators, I've decided to
>> > transform tunable to boolean(just by cleaning the TUNABLE flag bit) then
>> > the whole cond_node_t would be treated as normal.
>>
>> I think it would be better to error. Then the user can decided what to
>> do about it.
>>
> 
> I understand this is for working around the need to nest tunable with
> tunable/boolean.
> 
> Since pppd_can_insmod has been used with secure_mode_insmod in current
> refpolicy, error out would break the build, that's why I've chosen to
> just put some information. BTW, in this situation the toolchain would
> bump the pppd_can_insmod from tunable to boolean(by clearing it TUNABLE
> flag), then the policy writer won't even bother to change the
> declaration of pppd_can_insmod from gen_tunable() to gen_bool().

I still want this to error out.  I'll fix the policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
