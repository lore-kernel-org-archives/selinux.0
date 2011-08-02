Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p729GmJK001096
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 05:16:48 -0400
Received: from snt0-omc4-s18.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p729GlOR020843
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 09:16:47 GMT
Message-ID: <SNT139-W14587C48242D78B1643FD7AB3B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_734526d3-5718-43ed-8400-5416d1d73f40_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <cpebenito@tresys.com>, <selinux@tycho.nsa.gov>
CC: <qingtao.cao@windriver.com>
Subject: RE: Error in monolithic role attribute
Date: Tue, 2 Aug 2011 09:16:46 +0000
In-Reply-To: <4E36A370.40001@tresys.com>
References: <4E36A370.40001@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_734526d3-5718-43ed-8400-5416d1d73f40_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hello Chris,

Many thanks for finding out this problem, I've found out the root cause, and the fix is very easy - just remove the second call of role_fix_callback() in expand_module() for processing block/decls' local p_roles table.

Ok, let me ramble on how I've analyzed this problem.

1. After I add some printf in the role_fix_callback(), I will get below results:

712, role attribute name: portage_roles
712, role attribute name: semanage_roles
712, role attribute name: rpm_roles
712, role attribute name: semanage_roles
724, regular_role_name: portage_roles, 1
semodule: expand.c:725: role_fix_callback: Assertion `0' failed.

Which shows that the semanage_role attribute has been processed TWICE, and it is the second time when the assertion finds that it still contains a sub role attribute.

How could this happen? Since the expand_role_attributes() at the end of the link phase would escalate sub role attribute's roles ebitmap into that of the parent, then remove the sub role attribute away from the parent's roles ebitmap, which supports the assertion that during the role_fix_callback() in the expand phase any role attribute's roles ebitmap should only contain regular roles, but not role attribute.

When the role_fix_callback() is called the second time in the expand phase, it is processing the p_roles symtab of some block/decl. If I comment off usermanage_run_useradd(portage_t, portage_roles), which is inside optional_policy macro, then I would get another similar error log:

712, role attribute name: portage_roles
712, role attribute name: semanage_roles
712, role attribute name: rpm_roles
712, role attribute name: semanage_roles
724, regular_role_name: rpm_roles, 1
semodule: expand.c:725: role_fix_callback: Assertion `0' failed.

Then if I further comment off usermanage_run_useradd(rpm_script_t, rpm_roles), then the problem would gone.

2. This problem makes me remember that months ago when I was developing the role attribute support, I had been doubtful about the need to call role_fix_callback() again in the expand phase for any block/decl.

Turns out this is not only redundant but also wrong!

At the end of the link phase, before expand_role_attributes() is called the populate_roleattributes() takes care of merging any role attributes's roles ebitmap recorded in any block/decl's p_roles table, into the base.p_roles table. Actually this would have complemented the effect of get_local_role(), so there is not any need to look into any block/decl's p_roles table again in the expand phase.

Moreover, any attempt to do so would be wrong, since expand_role_attributes() just works on base.p_roles table, not that of block/decl's, which explains when processing some local p_roles of some block/decl, the semange_role's roles ebitmap still contains sub role attributes! which further explains why comment off the call of usermanage_run_useradd() would make the problem disappear - since it's called in some block/decl other than the global block!

3. The tests in step 1 proves that the analysis in step 2 is correct.

Also, the call of attr_convert_callback() in the expand phase for block/decls aims to complement the effect of get_local_type(). Again, now that the effect of get_local_role() has been complemented by populate_roleattributes() in the link phase, role_fix_callback() should not be called for block/decl any more.

I would send out the fix in a separate thread.

Thanks again!

Best regards,
Harry



> Date: Mon, 1 Aug 2011 09:00:32 -0400
> From: cpebenito@tresys.com
> To: selinux@tycho.nsa.gov
> CC: qingtao.cao@windriver.com; harrytaurus2002@hotmail.com
> Subject: Error in monolithic role attribute
> 
> I started the Refpolicy implementation for the new role attribute
> support.  Unfortunately, I get the following error for monolithic policies:
> 
> /usr/bin/checkpolicy policy.conf -o policy.26
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> checkpolicy: expand.c:721: role_fix_callback: Assertion `regular_role !=
> ((void *)0) && regular_role->flavor == 0' failed.
> make: *** [policy.26] Aborted
> 
> With the same policy I get a similar error when running 'make validate'
> in a modular build:
> 
> /usr/bin/semodule_expand tmp/test.lnk tmp/policy.bin
> semodule_expand: expand.c:721: role_fix_callback: Assertion
> `regular_role != ((void *)0) && regular_role->flavor == 0' failed.
> make: *** [validate] Aborted
> 
> This is with last week's release of the toolchain.
> 
> You should be able to reproduce this by checking out current Refpolicy
> and applying the attached patch.
> 
> For monolithic:
> $ make conf
> $ make MONOLITHIC=y.
> 
> For modular:
> 
> $ make conf
> $ make validate
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
 		 	   		  
--_734526d3-5718-43ed-8400-5416d1d73f40_
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
Hello Chris,<br><br>Many thanks for finding out this problem, I've found out the root cause, and the fix is very easy - just remove the second call of role_fix_callback() in expand_module() for processing block/decls' local p_roles table.<br><br>Ok, let me ramble on how I've analyzed this problem.<br><br>1. After I add some printf in the role_fix_callback(), I will get below results:<br><br>712, role attribute name: portage_roles<br>712, role attribute name: semanage_roles<br>712, role attribute name: rpm_roles<br>712, role attribute name: semanage_roles<br>724, regular_role_name: portage_roles, 1<br>semodule: expand.c:725: role_fix_callback: Assertion `0' failed.<br><br>Which shows that the semanage_role attribute has been processed TWICE, and it is the second time when the assertion finds that it still contains a sub role attribute.<br><br>How could this happen? Since the expand_role_attributes() at the end of the link phase would escalate sub role attribute's roles ebitma!
 p into that of the parent, then remove the sub role attribute away from the parent's roles ebitmap, which supports the assertion that during the role_fix_callback() in the expand phase any role attribute's roles ebitmap should only contain regular roles, but not role attribute.<br><br>When the role_fix_callback() is called the second time in the expand phase, it is processing the p_roles symtab of some block/decl. If I comment off usermanage_run_useradd(portage_t, portage_roles), which is inside optional_policy macro, then I would get another similar error log:<br><br>712, role attribute name: portage_roles<br>712, role attribute name: semanage_roles<br>712, role attribute name: rpm_roles<br>712, role attribute name: semanage_roles<br>724, regular_role_name: rpm_roles, 1<br>semodule: expand.c:725: role_fix_callback: Assertion `0' failed.<br><br>Then if I further comment off usermanage_run_useradd(rpm_script_t, rpm_roles), then the problem would gone.<br><br>2. This problem !
 makes me remember that months ago when I was developing the role attri
bute support, I had been doubtful about the need to call role_fix_callback() again in the expand phase for any block/decl.<br><br>Turns out this is not only redundant but also wrong!<br><br>At the end of the link phase, before expand_role_attributes() is called the populate_roleattributes() takes care of merging any role attributes's roles ebitmap recorded in any block/decl's p_roles table, into the base.p_roles table. Actually this would have complemented the effect of get_local_role(), so there is not any need to look into any block/decl's p_roles table again in the expand phase.<br><br>Moreover, any attempt to do so would be wrong, since expand_role_attributes() just works on base.p_roles table, not that of block/decl's, which explains when processing some local p_roles of some block/decl, the semange_role's roles ebitmap still contains sub role attributes! which further explains why comment off the call of usermanage_run_useradd() would make the problem disappear - since!
  it's called in some block/decl other than the global block!<br><br>3. The tests in step 1 proves that the analysis in step 2 is correct.<br><br>Also, the call of attr_convert_callback() in the expand phase for block/decls aims to complement the effect of get_local_type(). Again, now that the effect of get_local_role() has been complemented by populate_roleattributes() in the link phase, role_fix_callback() should not be called for block/decl any more.<br><br>I would send out the fix in a separate thread.<br><br>Thanks again!<br><br>Best regards,<br>Harry<br><br><br><br><div>&gt; Date: Mon, 1 Aug 2011 09:00:32 -0400<br>&gt; From: cpebenito@tresys.com<br>&gt; To: selinux@tycho.nsa.gov<br>&gt; CC: qingtao.cao@windriver.com; harrytaurus2002@hotmail.com<br>&gt; Subject: Error in monolithic role attribute<br>&gt; <br>&gt; I started the Refpolicy implementation for the new role attribute<br>&gt; support.  Unfortunately, I get the following error for monolithic policies:<br>&gt; <!
 br>&gt; /usr/bin/checkpolicy policy.conf -o policy.26<br>&gt; /usr/bin
/checkpolicy:  loading policy configuration from policy.conf<br>&gt; checkpolicy: expand.c:721: role_fix_callback: Assertion `regular_role !=<br>&gt; ((void *)0) &amp;&amp; regular_role-&gt;flavor == 0' failed.<br>&gt; make: *** [policy.26] Aborted<br>&gt; <br>&gt; With the same policy I get a similar error when running 'make validate'<br>&gt; in a modular build:<br>&gt; <br>&gt; /usr/bin/semodule_expand tmp/test.lnk tmp/policy.bin<br>&gt; semodule_expand: expand.c:721: role_fix_callback: Assertion<br>&gt; `regular_role != ((void *)0) &amp;&amp; regular_role-&gt;flavor == 0' failed.<br>&gt; make: *** [validate] Aborted<br>&gt; <br>&gt; This is with last week's release of the toolchain.<br>&gt; <br>&gt; You should be able to reproduce this by checking out current Refpolicy<br>&gt; and applying the attached patch.<br>&gt; <br>&gt; For monolithic:<br>&gt; $ make conf<br>&gt; $ make MONOLITHIC=y.<br>&gt; <br>&gt; For modular:<br>&gt; <br>&gt; $ make conf<br>&gt; $ make validate<!
 br>&gt; <br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br></div> 		 	   		  </div></body>
</html>
--_734526d3-5718-43ed-8400-5416d1d73f40_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
