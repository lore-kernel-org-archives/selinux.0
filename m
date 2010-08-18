Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7IDOh2m004338
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 09:24:43 -0400
Received: from snt0-omc1-s44.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o7IDP3Hj016873
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2010 13:25:03 GMT
Message-ID: <SNT139-w499FFC8245BD574722F9F6AB9D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_cee376bf-7daf-47e1-9c94-e0601bccda10_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <paul.moore@hp.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>, <refpolicy@oss1.tresys.com>
Subject: RE: Problem about audit-test-2090 + refpolicy-2.20091117
Date: Wed, 18 Aug 2010 13:24:41 +0000
In-Reply-To: <1282132367.4122.8.camel@flek>
References: 
 <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl>,<1282132367.4122.8.camel@flek>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_cee376bf-7daf-47e1-9c94-e0601bccda10_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Paul,
 
> Subject: Re: Problem about audit-test-2090 + refpolicy-2.20091117
> From: paul.moore@hp.com
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com
> Date: Wed, 18 Aug 2010 07:52:47 -0400
> 
> On Wed, 2010-08-18 at 10:26 +0000, TaurusHarry wrote:
> > Hi SELinux exports,
> > 
> > When I am trying to build the lspp_test.pp provided by
> > audit-test-2090/utils/selinux-policy/lspp_test.* along with the
> > refpolicy-20091117 source code, I copied lspp_test.* files to
> > policy/modules/apps/ and then modified policy/modules.conf to declare
> > "lspp_test = module", but I run into below error message ...
> 
> Is there any reason why you copied the lspp_test policy files to the
> refpolicy sources and tried to build it there? I'm not completely sure
> that this is the cause of your problem but I can say for certain that
> this is not a tested procedure for building the lspp_test module.
> 
> The normal procedure is to build the lspp_test policy module separately
> from the system's main SELinux policy, e.g. build and install the normal
> system's SELinux policy (refpolicy-20091117 in your case) and after you
> have verified that everything is working correctly you can change to the
> directory audit-test-*/utils/selinux-policy directory and use the
> Makefile located their to build the lspp_test module.
> 
 
Many many thanks for your response!
 
Well, after I installed SELinux header properly then I did could enter audit-test/utils/selinux-policy/ successfully built lspp_test.pp there, however, I run into below error messages when trying to insert it:
 
[root/secadm_r/s0@qemu-host selinux-policy]# semodule -i lspp_test.pp
libsepol.expand_terule_helper: conflicting TE rule for (lspp_test_generic_t, sepgsql_db_t:db_table): old was user_sepgsql_table_t, new is sepgsql_table_t
libsepol.expand_module: Error during expand
libsemanage.semanage_expand_sandbox: Expand module failed
semodule: Failed!
[root/secadm_r/s0@qemu-host selinux-policy]#
 
Very honestly speaking I am clueless about such error message, so I tried to compile lspp_test.pp along with refpolicy source code just to see if such problem could simply disappear. Do you have some comments or suggestions about it? 

 

Moreover, the audit-test-2090 seems to be a little "old" than the refpolicy-2.20091117, for example, the lspp_test.te calls mls_file_read_up() rather than the expected mls_file_read_all_levels(), do you know if I could find some latest version of audit-test package or some latest version of the lspp_test.* files?

 

Thank you very much!

 

Best regards,

Harry

> -- 
> paul moore
> linux @ hp
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


 		 	   		  
--_cee376bf-7daf-47e1-9c94-e0601bccda10_
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
Hi Paul,<BR>&nbsp;<BR>&gt; Subject: Re: Problem about audit-test-2090 + refpolicy-2.20091117<BR>&gt; From: paul.moore@hp.com<BR>&gt; To: harrytaurus2002@hotmail.com<BR>&gt; CC: selinux@tycho.nsa.gov; refpolicy@oss1.tresys.com<BR>&gt; Date: Wed, 18 Aug 2010 07:52:47 -0400<BR>&gt; <BR>&gt; On Wed, 2010-08-18 at 10:26 +0000, TaurusHarry wrote:<BR>&gt; &gt; Hi SELinux exports,<BR>&gt; &gt; <BR>&gt; &gt; When I am trying to build the lspp_test.pp provided by<BR>&gt; &gt; audit-test-2090/utils/selinux-policy/lspp_test.* along with the<BR>&gt; &gt; refpolicy-20091117 source code, I copied lspp_test.* files to<BR>&gt; &gt; policy/modules/apps/ and then modified policy/modules.conf to declare<BR>&gt; &gt; "lspp_test = module", but I run into below error message ...<BR>&gt; <BR>&gt; Is there any reason why you copied the lspp_test policy files to the<BR>&gt; refpolicy sources and tried to build it there? I'm not completely sure<BR>&gt; that this is the cause of your problem but I can !
 say for certain that<BR>&gt; this is not a tested procedure for building the lspp_test module.<BR>&gt; <BR>&gt; The normal procedure is to build the lspp_test policy module separately<BR>&gt; from the system's main SELinux policy, e.g. build and install the normal<BR>&gt; system's SELinux policy (refpolicy-20091117 in your case) and after you<BR>&gt; have verified that everything is working correctly you can change to the<BR>&gt; directory audit-test-*/utils/selinux-policy directory and use the<BR>&gt; Makefile located their to build the lspp_test module.<BR>&gt; <BR>&nbsp;<BR>Many many thanks for your response!<BR>&nbsp;<BR>Well, after I installed SELinux header properly then I did could enter audit-test/utils/selinux-policy/ successfully built lspp_test.pp there, however, I run into below error messages when trying to&nbsp;insert it:<BR>&nbsp;<BR>[root/secadm_r/s0@qemu-host selinux-policy]# semodule -i lspp_test.pp<BR>libsepol.expand_terule_helper: conflicting TE rule for!
  (lspp_test_generic_t, sepgsql_db_t:db_table): old was user_sepgsql_ta
ble_t, new is sepgsql_table_t<BR>libsepol.expand_module: Error during expand<BR>libsemanage.semanage_expand_sandbox: Expand module failed<BR>semodule: Failed!<BR>[root/secadm_r/s0@qemu-host selinux-policy]#<BR>&nbsp;<BR>Very honestly speaking I am clueless about such error message, so I tried to compile lspp_test.pp along with refpolicy source code just to see if such problem could simply disappear. Do you have some comments or suggestions about it? <BR>
&nbsp;<BR>
Moreover, the audit-test-2090 seems to be a little "old" than the refpolicy-2.20091117, for example, the lspp_test.te calls mls_file_read_up() rather than the expected mls_file_read_all_levels(), do you know if I could find some latest version of audit-test package or some latest version of the lspp_test.* files?<BR>
&nbsp;<BR>
Thank you very much!<BR>
&nbsp;<BR>
Best regards,<BR>
Harry<BR><BR>&gt; -- <BR>&gt; paul moore<BR>&gt; linux @ hp<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; --<BR>&gt; This message was distributed to subscribers of the selinux mailing list.<BR>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>&gt; the words "unsubscribe selinux" without quotes as the message.<BR><BR><BR> 		 	   		  </body>
</html>
--_cee376bf-7daf-47e1-9c94-e0601bccda10_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
