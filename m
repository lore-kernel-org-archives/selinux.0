Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7O5dopo012001
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 01:39:50 -0400
Received: from snt0-omc4-s1.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7O5dnrO025196
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 05:39:49 GMT
Message-ID: <SNT139-W1481D4140E5F66541BA29FAB110@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_9267d11c-b9fe-4a28-ae30-3a890d40f6a0_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <cpebenito@tresys.com>
CC: <refpolicy@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [refpolicy] My patchset to test "Separating tunables from
 booleans"
Date: Wed, 24 Aug 2011 05:39:48 +0000
In-Reply-To: <4E53AEC0.7040009@tresys.com>
References: 
 <SNT139-W51733746CAFD339C4E9177AB2E0@phx.gbl>,<4E53AEC0.7040009@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_9267d11c-b9fe-4a28-ae30-3a890d40f6a0_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Chris,

> Date: Tue, 23 Aug 2011 09:44:32 -0400
> From: cpebenito@tresys.com
> To: harrytaurus2002@hotmail.com
> CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
> Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"
> 
> On 08/23/11 06:27, HarryCiao wrote:
> > This is the refpolicy patchset to test along with new toolchain feature
> > of separating tunables from booleans, generally speaking a "tunable"
> > keyword is introduced and made use of by tunable_policy(), whereas a new
> > boolean_policy() macro would make use of the "bool" keyword.
> > 
> > tunable is indeed a boolean, except that the COND_BOOL_FLAGS_TUNABLE bit
> > would be set in the newly added member of flags in the cond_bool_datum_t
> > structure.
> > 
> > Once the new toolchain feature is welcomed and merged, we could change
> > refpolicy to shrink policy.X size significantly.
> > 
> > Any comments or suggestions as for how to better this new toolchain
> > feature are greatly welcomed.
> 
> To make sure I understand correctly, a tunable block will have the same
> token in the raw policy as runtime conditional blocks?  e.g.
> 
> tunable foo false;
> if (foo) {
>  ....
> }
> 
> If tunable blocks use the same token, I think Refpolicy would just drop
> the tunable_policy() macro.
> 

The tunable identifier won't be written to policy.X.

During link, the logically "true" branch of its if-else branches would be treated as permanent rules and append to the end of decl->avrules list, resulting in expanded and registered into te_avtab hashtab.

As for boolean, the identifier would be written to policy.X and both if-else branches would be expanded and registered to te_cond_avtab hashtab, so is the cond_node_t for boolean.

Both tunable and boolean identifier would share the same cond_bool_datum_t structure, a flag(COND_BOOL_FLAGS_TUNABLE) has been introduced to differentiate them, which would be set only when the identifier is defined/required by "tunable" keyword.

So both "tunable" and "bool" keywords would have to be supported by toolchain, so are tunable_policy() and boolean_policy() macros.


> There are no examples of this in Refpolicy, but can you mix Booleans and
> tunables in an expression? e.g.
> 
> tunable foo true;
> boolean bar true;
> if (foo || bar) {
> ....
> }
> 
> I'd say its not a requirement, I'm just trying to make sure I understand
> the features.

Yes, there is just one example in refpolicy. As showed in my test results, the pppd_can_ismod identifier is declared by gen_tunable(), however, it is used along with secure_mode_insmod boolean in ppp.te.

Such hybird expression is not welcomed I guess, so some warning information would be printed out during link. In my test result, the secure_mode_insmod would be blamed, since it's declared by gen_bool() but used in tunable_policy(), which would require it as a tunable. (That's also why until all p_bools.table from all modules have been copied during link could we finally determine if a cond_bool_datum_t is indeed a boolean or tunable)

For such situation since it would be difficult to correctly remove the cond_expr_t for tunables and related operators, I've decided to transform tunable to boolean(just by cleaning the TUNABLE flag bit) then the whole cond_node_t would be treated as normal.

Thanks,
Harry

> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_9267d11c-b9fe-4a28-ae30-3a890d40f6a0_
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
Hi Chris,<br><br><div>&gt; Date: Tue, 23 Aug 2011 09:44:32 -0400<br>&gt; From: cpebenito@tresys.com<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [refpolicy] My patchset to test "Separating tunables from booleans"<br>&gt; <br>&gt; On 08/23/11 06:27, HarryCiao wrote:<br>&gt; &gt; This is the refpolicy patchset to test along with new toolchain feature<br>&gt; &gt; of separating tunables from booleans, generally speaking a "tunable"<br>&gt; &gt; keyword is introduced and made use of by tunable_policy(), whereas a new<br>&gt; &gt; boolean_policy() macro would make use of the "bool" keyword.<br>&gt; &gt; <br>&gt; &gt; tunable is indeed a boolean, except that the COND_BOOL_FLAGS_TUNABLE bit<br>&gt; &gt; would be set in the newly added member of flags in the cond_bool_datum_t<br>&gt; &gt; structure.<br>&gt; &gt; <br>&gt; &gt; Once the new toolchain feature is welcomed and merged, we could change<br>&gt; &gt!
 ; refpolicy to shrink policy.X size significantly.<br>&gt; &gt; <br>&gt; &gt; Any comments or suggestions as for how to better this new toolchain<br>&gt; &gt; feature are greatly welcomed.<br>&gt; <br>&gt; To make sure I understand correctly, a tunable block will have the same<br>&gt; token in the raw policy as runtime conditional blocks?  e.g.<br>&gt; <br>&gt; tunable foo false;<br>&gt; if (foo) {<br>&gt;  ....<br>&gt; }<br>&gt; <br>&gt; If tunable blocks use the same token, I think Refpolicy would just drop<br>&gt; the tunable_policy() macro.<br>&gt; <br><br>The tunable identifier won't be written to policy.X.<br><br>During link, the logically "true" branch of its if-else branches would be treated as permanent rules and append to the end of decl-&gt;avrules list, resulting in expanded and registered into te_avtab hashtab.<br><br>As for boolean, the identifier would be written to policy.X and both if-else branches would be expanded and registered to te_cond_avtab hashtab, !
 so is the cond_node_t for boolean.<br><br>Both tunable and boolean ide
ntifier would share the same cond_bool_datum_t structure, a flag(COND_BOOL_FLAGS_TUNABLE) has been introduced to differentiate them, which would be set only when the identifier is defined/required by "tunable" keyword.<br><br>So both "tunable" and "bool" keywords would have to be supported by toolchain, so are tunable_policy() and boolean_policy() macros.<br><br><br>&gt; There are no examples of this in Refpolicy, but can you mix Booleans and<br>&gt; tunables in an expression? e.g.<br>&gt; <br>&gt; tunable foo true;<br>&gt; boolean bar true;<br>&gt; if (foo || bar) {<br>&gt; ....<br>&gt; }<br>&gt; <br>&gt; I'd say its not a requirement, I'm just trying to make sure I understand<br>&gt; the features.<br><br>Yes, there is just one example in refpolicy. As showed in my test results, the pppd_can_ismod identifier is declared by gen_tunable(), however, it is used along with secure_mode_insmod boolean in ppp.te.<br><br>Such hybird expression is not welcomed I guess, so some warnin!
 g information would be printed out during link. In my test result, the secure_mode_insmod would be blamed, since it's declared by gen_bool() but used in tunable_policy(), which would require it as a tunable. (That's also why until all p_bools.table from all modules have been copied during link could we finally determine if a cond_bool_datum_t is indeed a boolean or tunable)<br><br>For such situation since it would be difficult to correctly remove the cond_expr_t for tunables and related operators, I've decided to transform tunable to boolean(just by cleaning the TUNABLE flag bit) then the whole cond_node_t would be treated as normal.<br><br>Thanks,<br>Harry<br><br>&gt; <br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the word!
 s "unsubscribe selinux" without quotes as the message.<br></div> 		 	 
  		  </div></body>
</html>
--_9267d11c-b9fe-4a28-ae30-3a890d40f6a0_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
