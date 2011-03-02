Message-ID: <SNT139-w55786BC753A3BF026F86CBABC00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_de92ebf3-d6e3-4df7-b770-d72cbfe76457_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>
Subject: RE: Separate socket SID than its creator
Date: Wed, 2 Mar 2011 05:22:52 +0000
In-Reply-To: <1298901158.17143.14.camel@moss-pluto>
References: 
 <SNT139-W222AD5AB4BFF6776A5A244ABDF0@phx.gbl>,<1298901158.17143.14.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_de92ebf3-d6e3-4df7-b770-d72cbfe76457_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hello Stephen,

> Subject: Re: Separate socket SID than its creator
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Date: Mon, 28 Feb 2011 08:52:38 -0500
> 
> On Sun, 2011-02-27 at 10:14 +0000, HarryCiao wrote:
> > Hello Stephen, James and Eric,
> > 
> > The attached is the v1 patches to compute socket SID on creation. 
> > 
> > The propagation of the return code of security_transition_sid is a
> > good practice and actually helps identifying the problem that the
> > socket creator's role also needs to be able to type the socket role. 
> > 
> > The class number(orig_tclass) used by SELinux kernel driver is checked
> > against SECCLASS_XXX macros and if it's any one of those 22 socket
> > classes both security_compute_sid and mls_comput_sid will preserve the
> > scontext's role and MLS attribute as what they have been done for
> > policydb.policy_class. (we are not checking access vectors so we don't
> > have to concern about the unmapped, real class number allocated by
> > checkpolicy)
> > 
> > I've also come up with a debug patch to make use of the
> > security_sid_to_context which helps to reveal that the
> > unix_dgram_socket object created by syslogd differs only in type from
> > its creator and shares the same user, role and MLS at! tribute. The
> > relevant changes to logging.pp used for debugging is also attached.
> > 
> > Please kindly help commenting and suggesting how I could further test
> > these two patches.
> 
> Kernel patches need to be posted one patch per message, inline, as per
> SubmittingPatches.  http://userweb.kernel.org/~akpm/stuff/tpp.txt is
> also a good resource on preparing kernel patches.
> 

Ok, I will try to send patches to selinux mailing list by git-send-emails with one patch per message inline.

> The order of your patches needs to be reversed so that there is no
> change in behavior and everything still works after each patch is
> applied - this is important for git bisect.

Understand, will do.

> 
> I'm a bit concerned about the maintainability of the socket class list
> in security_is_socket_class().  We need to do something to ensure that
> if someone later adds a new socket security class to the kernel, they
> know to update this list.  At least a comment in classmap.h; ideally
> some kind of compile-time check (similar to the #error case in hooks.c
> to catch when someone adds more than 64 capabilities) to detect when
> someone adds a socket class without updating the list there.  Or maybe
> security_is_socket_class() needs to be auto-generated from classmap.h by
> genheaders?
> 

Good idea!

Actually it won't take much effort to have the genheaders auto-generate the security_is_socket_class() function by traversing the secclass_map[] array and collecting all socket classes' name into the 'case' branch. I will send it out in v2 patches.


> Since you are checking against the kernel values rather than the policy
> values, you need to make sure you only apply this check when called from
> the kernel (if kern == true).  
> 

Yeah, since the security_is_socket_class() function checks class kernel value against SECCLASS_XXX macros we should also mapping the class policy value to the relevant kernel value when the security_compue_sid() is called with kern == false, say by compute_create program, which should compute the same SID for socket as in kernel. For this purpose the index for an current_mapping[] entry should be returned if its value is the same as the class policy value.

Thanks!

Best regards,
Harry


> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_de92ebf3-d6e3-4df7-b770-d72cbfe76457_
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
Hello Stephen,<br><br>&gt; Subject: Re: Separate socket SID than its creator<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Date: Mon, 28 Feb 2011 08:52:38 -0500<br>&gt; <br>&gt; On Sun, 2011-02-27 at 10:14 +0000, HarryCiao wrote:<br>&gt; &gt; Hello Stephen, James and Eric,<br>&gt; &gt; <br>&gt; &gt; The attached is the v1 patches to compute socket SID on creation. <br>&gt; &gt; <br>&gt; &gt; The propagation of the return code of security_transition_sid is a<br>&gt; &gt; good practice and actually helps identifying the problem that the<br>&gt; &gt; socket creator's role also needs to be able to type the socket role. <br>&gt; &gt; <br>&gt; &gt; The class number(orig_tclass) used by SELinux kernel driver is checked<br>&gt; &gt; against SECCLASS_XXX macros and if it's any one of those 22 socket<br>&gt; &gt; classes both security_compute_sid and mls_comput_sid will preser!
 ve the<br>&gt; &gt; scontext's role and MLS attribute as what they have been done for<br>&gt; &gt; policydb.policy_class. (we are not checking access vectors so we don't<br>&gt; &gt; have to concern about the unmapped, real class number allocated by<br>&gt; &gt; checkpolicy)<br>&gt; &gt; <br>&gt; &gt; I've also come up with a debug patch to make use of the<br>&gt; &gt; security_sid_to_context which helps to reveal that the<br>&gt; &gt; unix_dgram_socket object created by syslogd differs only in type from<br>&gt; &gt; its creator and shares the same user, role and MLS at! tribute. The<br>&gt; &gt; relevant changes to logging.pp used for debugging is also attached.<br>&gt; &gt; <br>&gt; &gt; Please kindly help commenting and suggesting how I could further test<br>&gt; &gt; these two patches.<br>&gt; <br>&gt; Kernel patches need to be posted one patch per message, inline, as per<br>&gt; SubmittingPatches.  http://userweb.kernel.org/~akpm/stuff/tpp.txt is<br>&gt; also a good re!
 source on preparing kernel patches.<br>&gt; <br><br>Ok, I will try to 
send patches to selinux mailing list by git-send-emails with one patch per message inline.<br><br>&gt; The order of your patches needs to be reversed so that there is no<br>&gt; change in behavior and everything still works after each patch is<br>&gt; applied - this is important for git bisect.<br><br>Understand, will do.<br><br>&gt; <br>&gt; I'm a bit concerned about the maintainability of the socket class list<br>&gt; in security_is_socket_class().  We need to do something to ensure that<br>&gt; if someone later adds a new socket security class to the kernel, they<br>&gt; know to update this list.  At least a comment in classmap.h; ideally<br>&gt; some kind of compile-time check (similar to the #error case in hooks.c<br>&gt; to catch when someone adds more than 64 capabilities) to detect when<br>&gt; someone adds a socket class without updating the list there.  Or maybe<br>&gt; security_is_socket_class() needs to be auto-generated from classmap.h by<br>&gt; genheaders?<br>!
 &gt; <br><br>Good idea!<br><br>Actually it won't take much effort to have the genheaders auto-generate the security_is_socket_class() function by traversing the secclass_map[] array and collecting all socket classes' name into the 'case' branch. I will send it out in v2 patches.<br><br><br>&gt; Since you are checking against the kernel values rather than the policy<br>&gt; values, you need to make sure you only apply this check when called from<br>&gt; the kernel (if kern == true).  <br>&gt; <br><br>Yeah, since the security_is_socket_class() function checks class kernel value against SECCLASS_XXX macros we should also mapping the class policy value to the relevant kernel value when the security_compue_sid() is called with kern == false, say by compute_create program, which should compute the same SID for socket as in kernel. For this purpose the index for an current_mapping[] entry should be returned if its value is the same as the class policy value.<br><br>Thanks!<br><br>!
 Best regards,<br>Harry<br><br><br>&gt; -- <br>&gt; Stephen Smalley<br>
&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_de92ebf3-d6e3-4df7-b770-d72cbfe76457_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
