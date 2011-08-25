Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7P3ASMl007921
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 23:10:35 -0400
Received: from snt0-omc4-s36.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7P3ASKK004682
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 03:10:28 GMT
Message-ID: <SNT139-W395816A4087EE52F92B2B8AB100@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_ec056b54-73d2-44b4-8e78-2af7f7893058_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <cpebenito@tresys.com>
CC: <refpolicy@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [refpolicy] My patchset to test "Separating tunables from
 booleans"
Date: Thu, 25 Aug 2011 03:10:23 +0000
In-Reply-To: <4E54ED50.3060802@tresys.com>
References: 
 <SNT139-W51733746CAFD339C4E9177AB2E0@phx.gbl>,<4E53AEC0.7040009@tresys.com>
 <SNT139-W1481D4140E5F66541BA29FAB110@phx.gbl>,<4E54ED50.3060802@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_ec056b54-73d2-44b4-8e78-2af7f7893058_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Chris,

> Date: Wed, 24 Aug 2011 08:23:44 -0400
> From: cpebenito@tresys.com
> To: harrytaurus2002@hotmail.com
> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
> Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"
> 
> On 08/24/11 01:39, HarryCiao wrote:
> >> Date: Tue, 23 Aug 2011 09:44:32 -0400
> >> From: cpebenito@tresys.com
> >> To: harrytaurus2002@hotmail.com
> >> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
> >> Subject: Re: [refpolicy] My patchset to test "Separating tunables from
> > booleans"
> >>
> >> On 08/23/11 06:27, HarryCiao wrote:
> >> > This is the refpolicy patchset to test along with new toolchain feature
> >> > of separating tunables from booleans, generally speaking a "tunable"
> >> > keyword is introduced and made use of by tunable_policy(), whereas a new
> >> > boolean_policy() macro would make use of the "bool" keyword.
> >> >
> >> > tunable is indeed a boolean, except that the COND_BOOL_FLAGS_TUNABLE bit
> >> > would be set in the newly added member of flags in the cond_bool_datum_t
> >> > structure.
> >> >
> >> > Once the new toolchain feature is welcomed and merged, we could change
> >> > refpolicy to shrink policy.X size significantly.
> >> >
> >> > Any comments or suggestions as for how to better this new toolchain
> >> > feature are greatly welcomed.
> >>
> >> To make sure I understand correctly, a tunable block will have the same
> >> token in the raw policy as runtime conditional blocks? e.g.
> >>
> >> tunable foo false;
> >> if (foo) {
> >> ....
> >> }
> >>
> >> If tunable blocks use the same token, I think Refpolicy would just drop
> >> the tunable_policy() macro.
> >>
> > 
> > The tunable identifier won't be written to policy.X.
> > 
> > During link, the logically "true" branch of its if-else branches would
> > be treated as permanent rules and append to the end of decl->avrules
> > list, resulting in expanded and registered into te_avtab hashtab.
> > 
> > As for boolean, the identifier would be written to policy.X and both
> > if-else branches would be expanded and registered to te_cond_avtab
> > hashtab, so is the cond_node_t for boolean.
> > 
> > Both tunable and boolean identifier would share the same
> > cond_bool_datum_t structure, a flag(COND_BOOL_FLAGS_TUNABLE) has been
> > introduced to differentiate them, which would be set only when the
> > identifier is defined/required by "tunable" keyword.
> > 
> > So both "tunable" and "bool" keywords would have to be supported by
> > toolchain, so are tunable_policy() and boolean_policy() macros.
> 
> I don't understand why you say boolean_policy() and tunable_policy()
> macros are needed.  Based on the implementation in your test patch, they
> are not different in the raw policy.  Are you suggesting it for the
> automatic bool/tunable gen_require block generation?
> 

boolean_policy() and tunable_policy() are not for raw policy, their goal is to tell toolchain the difference between a boolean and a tunable, and that's all.

Then toolchain would handle boolean and tunable in different manner, for tunable, no identifiers written to policy.X and the logically true branch of its conditional would be expanded to policy.X permanently.

In a nutshell, booleans provide the capability to switch on/off blocks of rules at run-time, whereas tunable are more about "once-and-for-all" situations:  once the system administrator figures out the desirable branch in a tunable's conditional, he/she could set the tuanble's default value and very likely won't change it much, in such case only the effective branch of a tunable conditional should be written to raw policy.

The automatic gen_require block generation is good to have, doesn't it?


> >> There are no examples of this in Refpolicy, but can you mix Booleans and
> >> tunables in an expression? e.g.
> >>
> >> tunable foo true;
> >> boolean bar true;
> >> if (foo || bar) {
> >> ....
> >> }
> >>
> >> I'd say its not a requirement, I'm just trying to make sure I understand
> >> the features.
> > 
> > Yes, there is just one example in refpolicy. As showed in my test
> > results, the pppd_can_ismod identifier is declared by gen_tunable(),
> > however, it is used along with secure_mode_insmod boolean in ppp.te.
> > 
> > Such hybird expression is not welcomed I guess, so some warning
> > information would be printed out during link. In my test result, the
> > secure_mode_insmod would be blamed, since it's declared by gen_bool()
> > but used in tunable_policy(), which would require it as a tunable.
> > (That's also why until all p_bools.table from all modules have been
> > copied during link could we finally determine if a cond_bool_datum_t is
> > indeed a boolean or tunable)
> 
> The reason it has to be like this is because nested conditional policy
> is not supported.  Otherwise it would be written like:
> 
> tunable_policy(`pppd_can_insmod',`
> 	modutils_domtrans_insmod(pppd_t)
> ')
> 		
> 
> > For such situation since it would be difficult to correctly remove the
> > cond_expr_t for tunables and related operators, I've decided to
> > transform tunable to boolean(just by cleaning the TUNABLE flag bit) then
> > the whole cond_node_t would be treated as normal.
> 
> I think it would be better to error.  Then the user can decided what to
> do about it.
> 

I understand this is for working around the need to nest tunable with tunable/boolean.

Since pppd_can_insmod has been used with secure_mode_insmod in current refpolicy, error out would break the build, that's why I've chosen to just put some information. BTW, in this situation the toolchain would bump the pppd_can_insmod from tunable to boolean(by clearing it TUNABLE flag), then the policy writer won't even bother to change the declaration of pppd_can_insmod from gen_tunable() to gen_bool().

Thanks,
Harry

> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_ec056b54-73d2-44b4-8e78-2af7f7893058_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Chris,<br><br><div>&gt; Date: Wed, 24 Aug 2011 08:23:44 -0400<br>&gt; From: cpebenito@tresys.com<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"<br>&gt; <br>&gt; On 08/24/11 01:39, HarryCiao wrote:<br>&gt; &gt;&gt; Date: Tue, 23 Aug 2011 09:44:32 -0400<br>&gt; &gt;&gt; From: cpebenito@tresys.com<br>&gt; &gt;&gt; To: harrytaurus2002@hotmail.com<br>&gt; &gt;&gt; CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov<br>&gt; &gt;&gt; Subject: Re: [refpolicy] My patchset to test "Separating tunables from<br>&gt; &gt; booleans"<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 08/23/11 06:27, HarryCiao wrote:<br>&gt; &gt;&gt; &gt; This is the refpolicy patchset to test along with new toolchain feature<br>&gt; &gt;&gt; &gt; of separating tunables from booleans, generally speaking a "tunable"<br>&gt; &gt;&gt; &gt; keyword is introduced and made use of by!
  tunable_policy(), whereas a new<br>&gt; &gt;&gt; &gt; boolean_policy() macro would make use of the "bool" keyword.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; tunable is indeed a boolean, except that the COND_BOOL_FLAGS_TUNABLE bit<br>&gt; &gt;&gt; &gt; would be set in the newly added member of flags in the cond_bool_datum_t<br>&gt; &gt;&gt; &gt; structure.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Once the new toolchain feature is welcomed and merged, we could change<br>&gt; &gt;&gt; &gt; refpolicy to shrink policy.X size significantly.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Any comments or suggestions as for how to better this new toolchain<br>&gt; &gt;&gt; &gt; feature are greatly welcomed.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; To make sure I understand correctly, a tunable block will have the same<br>&gt; &gt;&gt; token in the raw policy as runtime conditional blocks? e.g.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; tunable foo false;<br>&gt; &gt;&gt; if (foo) {<br>&gt; &gt;&!
 gt; ....<br>&gt; &gt;&gt; }<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; If tunab
le blocks use the same token, I think Refpolicy would just drop<br>&gt; &gt;&gt; the tunable_policy() macro.<br>&gt; &gt;&gt;<br>&gt; &gt; <br>&gt; &gt; The tunable identifier won't be written to policy.X.<br>&gt; &gt; <br>&gt; &gt; During link, the logically "true" branch of its if-else branches would<br>&gt; &gt; be treated as permanent rules and append to the end of decl-&gt;avrules<br>&gt; &gt; list, resulting in expanded and registered into te_avtab hashtab.<br>&gt; &gt; <br>&gt; &gt; As for boolean, the identifier would be written to policy.X and both<br>&gt; &gt; if-else branches would be expanded and registered to te_cond_avtab<br>&gt; &gt; hashtab, so is the cond_node_t for boolean.<br>&gt; &gt; <br>&gt; &gt; Both tunable and boolean identifier would share the same<br>&gt; &gt; cond_bool_datum_t structure, a flag(COND_BOOL_FLAGS_TUNABLE) has been<br>&gt; &gt; introduced to differentiate them, which would be set only when the<br>&gt; &gt; identifier is defined/requir!
 ed by "tunable" keyword.<br>&gt; &gt; <br>&gt; &gt; So both "tunable" and "bool" keywords would have to be supported by<br>&gt; &gt; toolchain, so are tunable_policy() and boolean_policy() macros.<br>&gt; <br>&gt; I don't understand why you say boolean_policy() and tunable_policy()<br>&gt; macros are needed.  Based on the implementation in your test patch, they<br>&gt; are not different in the raw policy.  Are you suggesting it for the<br>&gt; automatic bool/tunable gen_require block generation?<br>&gt; <br><br>boolean_policy() and tunable_policy() are not for raw policy, their goal is to tell toolchain the difference between a boolean and a tunable, and that's all.<br><br>Then toolchain would handle boolean and tunable in different manner, for tunable, no identifiers written to policy.X and the logically true branch of its conditional would be expanded to policy.X permanently.<br><br>In a nutshell, booleans provide the capability to switch on/off blocks of rules at run-tim!
 e, whereas tunable are more about "once-and-for-all" situations:&nbsp;
 once the system administrator figures out the desirable branch in a tunable's conditional, he/she could set the tuanble's default value and very likely won't change it much, in such case only the effective branch of a tunable conditional should be written to raw policy.<br><br>The automatic gen_require block generation is good to have, doesn't it?<br><br><br>&gt; &gt;&gt; There are no examples of this in Refpolicy, but can you mix Booleans and<br>&gt; &gt;&gt; tunables in an expression? e.g.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; tunable foo true;<br>&gt; &gt;&gt; boolean bar true;<br>&gt; &gt;&gt; if (foo || bar) {<br>&gt; &gt;&gt; ....<br>&gt; &gt;&gt; }<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; I'd say its not a requirement, I'm just trying to make sure I understand<br>&gt; &gt;&gt; the features.<br>&gt; &gt; <br>&gt; &gt; Yes, there is just one example in refpolicy. As showed in my test<br>&gt; &gt; results, the pppd_can_ismod identifier is declared by gen_tunable(),<br>&gt; &gt; ho!
 wever, it is used along with secure_mode_insmod boolean in ppp.te.<br>&gt; &gt; <br>&gt; &gt; Such hybird expression is not welcomed I guess, so some warning<br>&gt; &gt; information would be printed out during link. In my test result, the<br>&gt; &gt; secure_mode_insmod would be blamed, since it's declared by gen_bool()<br>&gt; &gt; but used in tunable_policy(), which would require it as a tunable.<br>&gt; &gt; (That's also why until all p_bools.table from all modules have been<br>&gt; &gt; copied during link could we finally determine if a cond_bool_datum_t is<br>&gt; &gt; indeed a boolean or tunable)<br>&gt; <br>&gt; The reason it has to be like this is because nested conditional policy<br>&gt; is not supported.  Otherwise it would be written like:<br>&gt; <br>&gt; tunable_policy(`pppd_can_insmod',`<br>&gt; 	modutils_domtrans_insmod(pppd_t)<br>&gt; ')<br>&gt; 		<br>&gt; <br>&gt; &gt; For such situation since it would be difficult to correctly remove the<br>&gt; &gt; cond!
 _expr_t for tunables and related operators, I've decided to<br>&gt; &g
t; transform tunable to boolean(just by cleaning the TUNABLE flag bit) then<br>&gt; &gt; the whole cond_node_t would be treated as normal.<br>&gt; <br>&gt; I think it would be better to error.  Then the user can decided what to<br>&gt; do about it.<br>&gt; <br><br>I understand this is for working around the need to nest tunable with tunable/boolean.<br><br>Since pppd_can_insmod has been used with secure_mode_insmod in current refpolicy, error out would break the build, that's why I've chosen to just put some information. BTW, in this situation the toolchain would bump the pppd_can_insmod from tunable to boolean(by clearing it TUNABLE flag), then the policy writer won't even bother to change the declaration of pppd_can_insmod from gen_tunable() to gen_bool().<br><br>Thanks,<br>Harry<br><br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux!
  mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_ec056b54-73d2-44b4-8e78-2af7f7893058_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
