Message-ID: <SNT139-w9FFFD60EAADE3BAD1F9A4ABCA0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_d2cf7dfb-cbd4-4780-b207-7c50810182a2_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <qingtao.cao@windriver.com>,
        "Christopher J. PeBenito"
	<cpebenito@tresys.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v2] [SELinux] Discussions about rbacsep
Date: Sat, 12 Mar 2011 12:26:33 +0000
In-Reply-To: <1299870260.16505.16.camel@moss-lions.epoch.ncsc.mil>
References: 
 <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>,<1299852669.3432.22.camel@moss-pluto>,<1299870260.16505.16.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_d2cf7dfb-cbd4-4780-b207-7c50810182a2_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen and James,
 
Thanks a lot for all your comments.
 
I've got your points, adding class support to the role_transition rule would eliminate the ambiguity and provide the required flexibility to make use of it in a general manner, I will start from the binary reprensantation of the range_transition rule and how libsepol/checkpolicy handles it.
 
Yes, all policy stuff should be migrated to userspace than in kernel. I will be very glad to try to add all these new "xxx_default <class> <fromsubject/object>" rules after the role_transition rule improvement.
 
Best regards,
Harry
 
> Subject: Re: [v2] [SELinux] Discussions about rbacsep
> From: jwcart2@tycho.nsa.gov
> To: sds@tycho.nsa.gov
> CC: qingtao.cao@windriver.com; cpebenito@tresys.com; selinux@tycho.nsa.gov
> Date: Fri, 11 Mar 2011 14:04:20 -0500
> 
> On Fri, 2011-03-11 at 09:11 -0500, Stephen Smalley wrote:
> > On Fri, 2011-03-11 at 15:20 +0800, Harry Ciao wrote:
> > > Hi Stephen and Chris,
> > > 
> > > I have fixed the semantics of the role_transtion rule for the newly created files or dirs objects same as that for the process class. Since class-specific role_transition rules would be handled after TE rules, we could make use of checking if (newcontext.type == roletr->type) and (scontext->role == roletr->role) before setting newcontext.role = roletr->new_role;
> > > 
> > > Then in the refpolicy we could adopt Stephen's suggestion for the role_transition rule such as:
> > > role_transition sysadm_r user_home_t sysadm_r;
> > > 
> > > But I think we could omit class in above rule, since such role_transition semantics only takes place when filedir == true, that is, when the new object is of file or dir class.
> > 
> > If we omit the class, then the above statement has two possible
> > interpretations:
> > 1) When a process in sysadm_r executes a program labeled user_home_t,
> > the process transitions to sysadm_r (no effect in this case, but it
> > would have an effect if the new role were something other than the old
> > one), or
> > 2) When a process creates a file in a directory labeled user_home_t,
> > then the new file will be labeled with sysadm_r.
> > 
> > I'm concerned about that ambiguity in the meaning of the rule if we
> > don't explicitly specify the class. Also, by not specifying the class,
> > you keep us from re-using this mechanism for other object classes in a
> > general manner.
> > 
> > I don't think that it would be too hard to add an optional class field
> > to the role_transition statements; you can follow the model of what we
> > did for range_transitions when we added the class field to it. That
> > does require a policy version bump and an updated checkpolicy/libsepol.
> > 
> 
> Adding the class field and making the role_transition look like other
> transition rules seem to me to be the right way to go.
> 
> > What would also be desirable would be a new policy construct that would
> > allow us to specify the default labeling behavior for each component of
> > the security context on a per-class basis, e.g.
> > role_default file fromtarget;
> > role_default process fromsource;
> > user_default socket fromsource;
> > ...
> > 
> 
> I like the idea, but something like "role_default_label_src" or
> "role_label_src" would seem to be more descriptive to me.
> 
> > That would eliminate the need for the security_is_*_class functions and
> > the special handling in the kernel for particular classes, and migrate
> > all of this logic into the policy. That however may be more than you
> > are willing to take on at the present time.
> > 
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_d2cf7dfb-cbd4-4780-b207-7c50810182a2_
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
Hi&nbsp;Stephen and James,<BR>
&nbsp;<BR>
Thanks a lot for&nbsp;all your comments.<BR>
&nbsp;<BR>
I've got your points, adding class support to the role_transition rule would eliminate the ambiguity and provide the required flexibility to make use of&nbsp;it&nbsp;in a general manner, I will start from the binary reprensantation of&nbsp;the&nbsp;range_transition rule and how&nbsp;libsepol/checkpolicy&nbsp;handles it.<BR>
&nbsp;<BR>
Yes, all policy stuff should&nbsp;be migrated to userspace than in kernel. I&nbsp;will be very glad to&nbsp;try to add all these new "xxx_default &lt;class&gt; &lt;fromsubject/object&gt;" rules&nbsp;after the role_transition&nbsp;rule improvement.<BR>
&nbsp;<BR>
Best regards,<BR>
Harry<BR>&nbsp;<BR>
&gt; Subject: Re: [v2] [SELinux] Discussions about rbacsep<BR>&gt; From: jwcart2@tycho.nsa.gov<BR>&gt; To: sds@tycho.nsa.gov<BR>&gt; CC: qingtao.cao@windriver.com; cpebenito@tresys.com; selinux@tycho.nsa.gov<BR>&gt; Date: Fri, 11 Mar 2011 14:04:20 -0500<BR>&gt; <BR>&gt; On Fri, 2011-03-11 at 09:11 -0500, Stephen Smalley wrote:<BR>&gt; &gt; On Fri, 2011-03-11 at 15:20 +0800, Harry Ciao wrote:<BR>&gt; &gt; &gt; Hi Stephen and Chris,<BR>&gt; &gt; &gt; <BR>&gt; &gt; &gt; I have fixed the semantics of the role_transtion rule for the newly created files or dirs objects same as that for the process class. Since class-specific role_transition rules would be handled after TE rules, we could make use of checking if (newcontext.type == roletr-&gt;type) and (scontext-&gt;role == roletr-&gt;role) before setting newcontext.role = roletr-&gt;new_role;<BR>&gt; &gt; &gt; <BR>&gt; &gt; &gt; Then in the refpolicy we could adopt Stephen's suggestion for the role_transition rule such as:<BR>&gt;!
  &gt; &gt; role_transition sysadm_r user_home_t sysadm_r;<BR>&gt; &gt; &gt; <BR>&gt; &gt; &gt; But I think we could omit class in above rule, since such role_transition semantics only takes place when filedir == true, that is, when the new object is of file or dir class.<BR>&gt; &gt; <BR>&gt; &gt; If we omit the class, then the above statement has two possible<BR>&gt; &gt; interpretations:<BR>&gt; &gt; 1) When a process in sysadm_r executes a program labeled user_home_t,<BR>&gt; &gt; the process transitions to sysadm_r (no effect in this case, but it<BR>&gt; &gt; would have an effect if the new role were something other than the old<BR>&gt; &gt; one), or<BR>&gt; &gt; 2) When a process creates a file in a directory labeled user_home_t,<BR>&gt; &gt; then the new file will be labeled with sysadm_r.<BR>&gt; &gt; <BR>&gt; &gt; I'm concerned about that ambiguity in the meaning of the rule if we<BR>&gt; &gt; don't explicitly specify the class. Also, by not specifying the class,<BR!
 >&gt; &gt; you keep us from re-using this mechanism for other object c
lasses in a<BR>&gt; &gt; general manner.<BR>&gt; &gt; <BR>&gt; &gt; I don't think that it would be too hard to add an optional class field<BR>&gt; &gt; to the role_transition statements; you can follow the model of what we<BR>&gt; &gt; did for range_transitions when we added the class field to it. That<BR>&gt; &gt; does require a policy version bump and an updated checkpolicy/libsepol.<BR>&gt; &gt; <BR>&gt; <BR>&gt; Adding the class field and making the role_transition look like other<BR>&gt; transition rules seem to me to be the right way to go.<BR>&gt; <BR>&gt; &gt; What would also be desirable would be a new policy construct that would<BR>&gt; &gt; allow us to specify the default labeling behavior for each component of<BR>&gt; &gt; the security context on a per-class basis, e.g.<BR>&gt; &gt; role_default file fromtarget;<BR>&gt; &gt; role_default process fromsource;<BR>&gt; &gt; user_default socket fromsource;<BR>&gt; &gt; ...<BR>&gt; &gt; <BR>&gt; <BR>&gt; I like the ide!
 a, but something like "role_default_label_src" or<BR>&gt; "role_label_src" would seem to be more descriptive to me.<BR>&gt; <BR>&gt; &gt; That would eliminate the need for the security_is_*_class functions and<BR>&gt; &gt; the special handling in the kernel for particular classes, and migrate<BR>&gt; &gt; all of this logic into the policy. That however may be more than you<BR>&gt; &gt; are willing to take on at the present time.<BR>&gt; &gt; <BR>&gt; <BR>&gt; -- <BR>&gt; James Carter &lt;jwcart2@tycho.nsa.gov&gt;<BR>&gt; National Security Agency<BR>&gt; <BR>&gt; <BR>&gt; --<BR>&gt; This message was distributed to subscribers of the selinux mailing list.<BR>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>&gt; the words "unsubscribe selinux" without quotes as the message.<BR> 		 	   		  </body>
</html>
--_d2cf7dfb-cbd4-4780-b207-7c50810182a2_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
