Message-ID: <SNT139-w62C255DDAA9F2FF1B546BAB780@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_7d13151c-18e5-41a2-9136-1a0d7085ba4d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, <method@manicmethod.com>
CC: <qingtao.cao@windriver.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: RE: v0 Add role attribute support to libsepol
Date: Sun, 29 May 2011 04:46:55 +0000
In-Reply-To: <4DDFBBDC.9040909@tresys.com>
References: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
 <4DDFAC9A.50903@manicmethod.com>
 <4DDFB3F3.9040009@manicmethod.com>,<4DDFBBDC.9040909@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_7d13151c-18e5-41a2-9136-1a0d7085ba4d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Chris,

> Date: Fri, 27 May 2011 10:57:32 -0400
> From: cpebenito@tresys.com
> To: method@manicmethod.com
> CC: qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov; dwalsh@redhat.com
> Subject: Re: v0 Add role attribute support to libsepol
> 
> On 05/27/11 10:23, Joshua Brindle wrote:
> > Joshua Brindle wrote:
> >> Harry Ciao wrote:
> >>>
> >>> Comments:
> >>> ---------
> >>> Add role attribute to SELinux, which aims at replacing the deprecated
> >>> role dominance rule.
> >>
> >> Thanks. This is going to take a bit of time to absorb and most of my
> >> cycles are
> >> in use at the moment. I'll definitely get around to looking at it though.
> >>
> > 
> > I'd also like to solicit feedback from Dan and Chris as to how this will
> > be used in policy, and as to whether this implementation is suitable.
> > 
> > Dan, Chris, opinions?
> 
> Do we really want to overload the attribute statement for declaring role
> attributes?

Well, I guess we have to, since the attribute statement would be the only entrypoint to set a role_datum_t.flavor as ROLE_ATTRIB, and the role-types statement would no longer be able to declare roles, since they current syntax does not support to specify if the role is a regular role or a role attribute.

BTW, a regular role would be declared by the newly added role-attr statement exactly as the type statement, and the role-types statement would be solely used for setting up role - role attribute association and association between role attributes.

> 
> If I understand the description correctly, it seems reasonable, but will
> still run into problems for refpolicy.  We want to immediately use this
> feature for handling chains of run interfaces.  For example, say we have
> an admin (admin_r:admin_t) and he can run the foo program (foo_t
> domain).  The foo program then runs the bar program (bar_t) domain.  The
> (abbreviated) policy right now would look like this:
> 
> foo.te:
> bar_domtrans(foo_t)
> 
> foo.if:
> interface foo_run(
> 	type_transition $1 foo_exec_t:process foo_t;
> 	role $2 types foo_t;
> 	bar_run($1,$2)
> )
> 
> The reason we do this is so that the bar_t is added on to the admin_r
> role, without adding a direct transition from admin_t to bar_t.  But the
> above gets messy when the policy writer forgets to put the accompanying
> bar_run() call in the foo_run() interface implementation.  With role
> attributes it would be simplified to:
> 
> foo.te:
> role foo_roles types foo_t;
> bar_run(foo_t, foo_roles)
> 
> foo.if:
> interface foo_run(
> 	type_transition $1 foo_exec_t:process foo_t;
> 	roleattribute $2 foo_roles;
> )
> 
> But the problem that I suspect we'll see is what happens the bar_run()
> interface also has a role attribute?  Extending the above example:
> 
> bar.if:
> interface bar_run(
> 	type_transition $1 bar_exec_t:process bar_t;
> 	roleattribute $2 bar_roles;
> )
> 
> When the policy is expanded, you end up getting a roleattribute
> statement that has all role attributes in it:
> 
> roleattribute foo_roles bar_roles;
> 
> This should result in bar_roles being a superset of foo_roles.  It
> doesn't sound like this is being done.  There is at least one example of
> this case in refpolicy, see rpm_run() and seutil_run_semanage(); caller
> runs rpm->rpm_script->semanage->load_policy.
> 

Yep, I've got your point. Many thanks for clarifying your needs so that I would have a better idea of how role attributes are expected to be used.

While, I have sent out v1 patches, the last one 6/6 patch aims at setting up associations between two role attributes, while the first 5 remains the same as v0.

BTW, I also have modified rpm.* and selinuxutil.* to setup a test scenario same as what you have described above, please further refer to the attachment of the 0/6 email of v1 patches.

Thanks again! Looking forward to your feedbacks.

Best regards,
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
 		 	   		  
--_7d13151c-18e5-41a2-9136-1a0d7085ba4d_
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
<body class='hmmessage'>
Hi Chris,<br><br>&gt; Date: Fri, 27 May 2011 10:57:32 -0400<br>&gt; From: cpebenito@tresys.com<br>&gt; To: method@manicmethod.com<br>&gt; CC: qingtao.cao@windriver.com; sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov; dwalsh@redhat.com<br>&gt; Subject: Re: v0 Add role attribute support to libsepol<br>&gt; <br>&gt; On 05/27/11 10:23, Joshua Brindle wrote:<br>&gt; &gt; Joshua Brindle wrote:<br>&gt; &gt;&gt; Harry Ciao wrote:<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; Comments:<br>&gt; &gt;&gt;&gt; ---------<br>&gt; &gt;&gt;&gt; Add role attribute to SELinux, which aims at replacing the deprecated<br>&gt; &gt;&gt;&gt; role dominance rule.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Thanks. This is going to take a bit of time to absorb and most of my<br>&gt; &gt;&gt; cycles are<br>&gt; &gt;&gt; in use at the moment. I'll definitely get around to looking at it though.<br>&gt; &gt;&gt;<br>&gt; &gt; <br>&gt; &gt; I'd also like to solicit feedback from Dan an!
 d Chris as to how this will<br>&gt; &gt; be used in policy, and as to whether this implementation is suitable.<br>&gt; &gt; <br>&gt; &gt; Dan, Chris, opinions?<br>&gt; <br>&gt; Do we really want to overload the attribute statement for declaring role<br>&gt; attributes?<br><br>Well, I guess we have to, since the attribute statement would be the only entrypoint to set a role_datum_t.flavor as ROLE_ATTRIB, and the role-types statement would no longer be able to declare roles, since they current syntax does not support to specify if the role is a regular role or a role attribute.<br><br>BTW, a regular role would be declared by the newly added role-attr statement exactly as the type statement, and the role-types statement would be solely used for setting up role - role attribute association and association between role attributes.<br><br>&gt; <br>&gt; If I understand the description correctly, it seems reasonable, but will<br>&gt; still run into problems for refpolicy.  We want !
 to immediately use this<br>&gt; feature for handling chains of run int
erfaces.  For example, say we have<br>&gt; an admin (admin_r:admin_t) and he can run the foo program (foo_t<br>&gt; domain).  The foo program then runs the bar program (bar_t) domain.  The<br>&gt; (abbreviated) policy right now would look like this:<br>&gt; <br>&gt; foo.te:<br>&gt; bar_domtrans(foo_t)<br>&gt; <br>&gt; foo.if:<br>&gt; interface foo_run(<br>&gt; 	type_transition $1 foo_exec_t:process foo_t;<br>&gt; 	role $2 types foo_t;<br>&gt; 	bar_run($1,$2)<br>&gt; )<br>&gt; <br>&gt; The reason we do this is so that the bar_t is added on to the admin_r<br>&gt; role, without adding a direct transition from admin_t to bar_t.  But the<br>&gt; above gets messy when the policy writer forgets to put the accompanying<br>&gt; bar_run() call in the foo_run() interface implementation.  With role<br>&gt; attributes it would be simplified to:<br>&gt; <br>&gt; foo.te:<br>&gt; role foo_roles types foo_t;<br>&gt; bar_run(foo_t, foo_roles)<br>&gt; <br>&gt; foo.if:<br>&gt; interface foo_run!
 (<br>&gt; 	type_transition $1 foo_exec_t:process foo_t;<br>&gt; 	roleattribute $2 foo_roles;<br>&gt; )<br>&gt; <br>&gt; But the problem that I suspect we'll see is what happens the bar_run()<br>&gt; interface also has a role attribute?  Extending the above example:<br>&gt; <br>&gt; bar.if:<br>&gt; interface bar_run(<br>&gt; 	type_transition $1 bar_exec_t:process bar_t;<br>&gt; 	roleattribute $2 bar_roles;<br>&gt; )<br>&gt; <br>&gt; When the policy is expanded, you end up getting a roleattribute<br>&gt; statement that has all role attributes in it:<br>&gt; <br>&gt; roleattribute foo_roles bar_roles;<br>&gt; <br>&gt; This should result in bar_roles being a superset of foo_roles.  It<br>&gt; doesn't sound like this is being done.  There is at least one example of<br>&gt; this case in refpolicy, see rpm_run() and seutil_run_semanage(); caller<br>&gt; runs rpm-&gt;rpm_script-&gt;semanage-&gt;load_policy.<br>&gt; <br><br>Yep, I've got your point. Many thanks for clarifying your n!
 eeds so that I would have a better idea of how role attributes are exp
ected to be used.<br><br>While, I have sent out v1 patches, the last one 6/6 patch aims at setting up associations between two role attributes, while the first 5 remains the same as v0.<br><br>BTW, I also have modified rpm.* and selinuxutil.* to setup a test scenario same as what you have described above, please further refer to the attachment of the 0/6 email of v1 patches.<br><br>Thanks again! Looking forward to your feedbacks.<br><br>Best regards,<br>Harry<br><br><br><br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_7d13151c-18e5-41a2-9136-1a0d7085ba4d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
