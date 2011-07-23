Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6NA5itA031579
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2011 06:05:44 -0400
Received: from snt0-omc1-s30.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6NA5hN8017857
	for <selinux@tycho.nsa.gov>; Sat, 23 Jul 2011 10:05:43 GMT
Message-ID: <SNT139-w12C64B87320EADBB4D1075AB310@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_aad1f44a-a121-4962-8686-1d457ef49a46_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <slawrence@tresys.com>
CC: <cpebenito@tresys.com>, <method@manicmethod.com>, <selinux@tycho.nsa.gov>
Subject: RE: v3 Add role attribute support to libsepol
Date: Sat, 23 Jul 2011 10:05:42 +0000
In-Reply-To: <4E29D4C9.3000903@tresys.com>
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
 <SNT139-w61848BC20E4E7F40D1E43DAB560@phx.gbl>,<4E0AD0BC.8040708@windriver.com>
 <SNT139-w20B1A1E8C4A8738E18E36AB580@phx.gbl>,<4E29D4C9.3000903@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_aad1f44a-a121-4962-8686-1d457ef49a46_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi  Steve,

It's NICE to hear back from you:-) Please see my replies below.

> Date: Fri, 22 Jul 2011 15:51:37 -0400
> From: slawrence@tresys.com
> To: harrytaurus2002@hotmail.com
> CC: cpebenito@tresys.com; method@manicmethod.com; selinux@tycho.nsa.gov
> Subject: Re: v3 Add role attribute support to libsepol
> 
> --snip--
> 
> >>
> >>>  > 2. The policy.X's binary representation and SELinux kernel role_datum_t
> >>>  > structure don't have to be changed, so the max version number for 
> >>> policy.X
> >>>  > won't have to be bumped.
> >>>  >
> >>>  > But it may be desirable to bump the max module version number.
> >>>  >
> > 
> > Write flavor flag and roles ebitmap into a pp file and read them out unconditionally, this would only run into problem only under one condition, that libsepol/checkpolicy are upgraded with this patchset but the pp files are built before the upgrade took place, which I think could be easily fixed by re-building all pp files by the upgraded libsepol/checkpolicy.
> > 
> > So I think we don't have to bump MOD_POLICYDB_VERSION_MAX higher.
> > 
> > Am I right?
> > 
> > BTW, how do we trigger a pp downgrade? Anything like OUTPUT_POLICY or policy-version to trigger policy downgrade?
> > 
> > Thanks,
> > Harry
> > 
> 
> There isn't a tool that can force a policy module downgrade, but it can
> be done programmatically, so it should be supported. Additionally, it
> shouldn't require that modules be rebuilt if the toolchain is updated.
> So please add a new module version and check that before reading/writing
> the new role attribute information.


Yep, I've got your point. Turns out it would be very easy to trigger module downgrade, for example, simply by adding one line of:

policyvers = MOD_POLICYDB_VERSION_MAX - 1;

in write_binary_policy() in checkmodule.c.

I have introduced a new MOD_POLICYDB_VERSION_ROLEATTRIB(== 13) and bump 


	
	
	
	


MOD_POLICYDB_VERSION_MAX to it, all tests passed and I would send out the v4 patchset next Monday.

> 
> Aside from that, I've reviewed this patchset and everything looks
> reasonable. I still want to test this a little more, but assuming I
> don't see any any issues with a little more testing, and pending a fix
> for a module version bump, I'm fine with merging this.
> 

Many thanks for all your(and others) help on this patchset for the last two months, any further comments or issues you may have just let me know.

BTW, once these patchset is applied, we would have to change refpolicy to declare nx_server_r and unconfined_r explicitly, since the role-types rule would be made no longer to declare a role, we should use the new role-attr rule instead to declare them(just "role nx_server_r" and "role unconfined_r" before they are ever used).

Best regards,
Harry


> - Steve
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_aad1f44a-a121-4962-8686-1d457ef49a46_
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
Hi&nbsp; Steve,<br><br>It's NICE to hear back from you:-) Please see my replies below.<br><br><div>&gt; Date: Fri, 22 Jul 2011 15:51:37 -0400<br>&gt; From: slawrence@tresys.com<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: cpebenito@tresys.com; method@manicmethod.com; selinux@tycho.nsa.gov<br>&gt; Subject: Re: v3 Add role attribute support to libsepol<br>&gt; <br>&gt; --snip--<br>&gt; <br>&gt; &gt;&gt;<br>&gt; &gt;&gt;&gt;  &gt; 2. The policy.X's binary representation and SELinux kernel role_datum_t<br>&gt; &gt;&gt;&gt;  &gt; structure don't have to be changed, so the max version number for <br>&gt; &gt;&gt;&gt; policy.X<br>&gt; &gt;&gt;&gt;  &gt; won't have to be bumped.<br>&gt; &gt;&gt;&gt;  &gt;<br>&gt; &gt;&gt;&gt;  &gt; But it may be desirable to bump the max module version number.<br>&gt; &gt;&gt;&gt;  &gt;<br>&gt; &gt; <br>&gt; &gt; Write flavor flag and roles ebitmap into a pp file and read them out unconditionally, this would only run into problem only under o!
 ne condition, that libsepol/checkpolicy are upgraded with this patchset but the pp files are built before the upgrade took place, which I think could be easily fixed by re-building all pp files by the upgraded libsepol/checkpolicy.<br>&gt; &gt; <br>&gt; &gt; So I think we don't have to bump MOD_POLICYDB_VERSION_MAX higher.<br>&gt; &gt; <br>&gt; &gt; Am I right?<br>&gt; &gt; <br>&gt; &gt; BTW, how do we trigger a pp downgrade? Anything like OUTPUT_POLICY or policy-version to trigger policy downgrade?<br>&gt; &gt; <br>&gt; &gt; Thanks,<br>&gt; &gt; Harry<br>&gt; &gt; <br>&gt; <br>&gt; There isn't a tool that can force a policy module downgrade, but it can<br>&gt; be done programmatically, so it should be supported. Additionally, it<br>&gt; shouldn't require that modules be rebuilt if the toolchain is updated.<br>&gt; So please add a new module version and check that before reading/writing<br>&gt; the new role attribute information.<br><br><br>Yep, I've got your point. Turns o!
 ut it would be very easy to trigger module downgrade, for example, sim
ply by adding one line of:<br><br>policyvers = MOD_POLICYDB_VERSION_MAX - 1;<br><br>in write_binary_policy() in checkmodule.c.<br><br>I have introduced a new MOD_POLICYDB_VERSION_ROLEATTRIB(== 13) and bump 


	
	
	
	<style type="text/css">p { margin-bottom: 0.21cm; }</style>


MOD_POLICYDB_VERSION_MAX to it, all tests passed and I would send out the v4 patchset next Monday.<br><br>&gt; <br>&gt; Aside from that, I've reviewed this patchset and everything looks<br>&gt; reasonable. I still want to test this a little more, but assuming I<br>&gt; don't see any any issues with a little more testing, and pending a fix<br>&gt; for a module version bump, I'm fine with merging this.<br>&gt; <br><br>Many thanks for all your(and others) help on this patchset for the last two months, any further comments or issues you may have just let me know.<br><br>BTW, once these patchset is applied, we would have to change refpolicy to declare nx_server_r and unconfined_r explicitly, since the role-types rule would be made no longer to declare a role, we should use the new role-attr rule instead to declare them(just "role nx_server_r" and "role unconfined_r" before they are ever used).<br><br>Best regards,<br>Harry<br><br><br>&gt; - Steve<br>&gt; <br>&gt; --<br>&gt; This !
 message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_aad1f44a-a121-4962-8686-1d457ef49a46_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
