Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7MDlZxI025279
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 09:47:35 -0400
Received: from snt0-omc1-s28.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7MDlYOt003796
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 13:47:34 GMT
Message-ID: <SNT139-W4228F2147CEF20A92FA2A1AB2F0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_2eaffa3b-b2b5-4caf-9ce1-ac60e775ee30_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: RE: v2 Skip role attributes for policy.X and downgraded pp
Date: Mon, 22 Aug 2011 13:47:33 +0000
In-Reply-To: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
References: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_2eaffa3b-b2b5-4caf-9ce1-ac60e775ee30_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Steve, How do you feel about this patch? Right now I am trying to test my patchset to separate tunables from booleans, unfortunately one of them would have to be based on this patch. Once you are happy with it and merge it, I could create my patchset based on the latest master branch. Thanks a lot! Best regards,Harry
 > From: qingtao.cao@windriver.com
> To: slawrence@tresys.com
> CC: selinux@tycho.nsa.gov
> Subject: v2 Skip role attributes for policy.X and downgraded pp
> Date: Tue, 16 Aug 2011 16:08:51 +0800
> 
> 
> Differnece from v1
> --------------------
> 1. Skip role attributes when pp is downgraded, as well as for policy.X.
> 
>    When pp is downgraded the flavor flag and roles ebitmap would be
>    discarded, resulting in role attributes useless at all. So in such
>    case role attributes should be skipped for pp too.
> 
> 
> Tests I've done
> -----------------
> 1. Apply the role attribute test patch from Chris, adding a new test_r
>    role and calls rpm_run() for it.
>    
> 2. Use the apol tool to analyze what types the test_r role could type with:
>    (Since the apol installed on Ubuntu so far only support max version .24,
>     we need to setup "policy-version = 24" in semanage.conf)
>    
> Note: 
> . There is no role attributes such as portage/semanage/rpm_roles in policy.24
> . By default pp's version is 13.
> 
> test_r (36 types)
>     bootloader_t
>     chfn_t
>     chkpwd_t
>     consoletype_t
>     ddclient_t
>     depmod_t
>     dhcpc_t
>     groupadd_t
>     hostname_t
>     ifconfig_t
>     insmod_t
>     iptables_t
>     ldconfig_t
>     load_policy_t
>     loadkeys_t
>     lvm_t
>     netutils_t
>     newrole_t
>     nscd_t
>     pam_t
>     passwd_t
>     ping_t
>     pppd_t
>     pptp_t
>     prelink_t
>     rpm_script_t
>     rpm_t
>     semanage_t
>     setfiles_t
>     test_t
>     traceroute_t
>     tzdata_t
>     updpwd_t
>     useradd_t
>     usernetctl_t
>     utempter_t
> 
> 3. In write_binary_policy() in checkmodule.c, trigger pp downgrade
>    by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1;", then use
>    apol to analyze what types the test_r role could type with:
> 
> Note:
> . After downgrade, pp's version is 12 now.
> 
> test_r (22 types)
>     chfn_t
>     chkpwd_t
>     consoletype_t
>     ddclient_t
>     dhcpc_t
>     hostname_t
>     ifconfig_t
>     insmod_t
>     iptables_t
>     loadkeys_t
>     netutils_t
>     newrole_t
>     pam_t
>     passwd_t
>     ping_t
>     pppd_t
>     pptp_t
>     test_t
>     traceroute_t
>     updpwd_t
>     usernetctl_t
>     utempter_t
> 
>    Where we can see that test_r could no longer type with all those
>    types that are typed by rpm_roles and semanage_roles.
> 
>    (BTW, this means that once role attributes are endorsed in refpolicy,
>     the influence of pp downgrade could be far-reaching and perhaps
>     undesirable.)
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_2eaffa3b-b2b5-4caf-9ce1-ac60e775ee30_
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
Hi Steve,<BR>&nbsp;<BR>How do you feel about this patch?&nbsp;Right now I am trying to test my patchset to separate tunables&nbsp;from booleans, unfortunately one of them would have to be based on this patch. Once you are happy with it and merge it, I&nbsp;could create my patchset&nbsp;based on&nbsp;the latest master branch.<BR>&nbsp;<BR>Thanks a lot!<BR>&nbsp;<BR>Best regards,<BR>Harry<br>&nbsp;<BR><div>&gt; From: qingtao.cao@windriver.com<br>&gt; To: slawrence@tresys.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: v2 Skip role attributes for policy.X and downgraded pp<br>&gt; Date: Tue, 16 Aug 2011 16:08:51 +0800<br>&gt; <br>&gt; <br>&gt; Differnece from v1<br>&gt; --------------------<br>&gt; 1. Skip role attributes when pp is downgraded, as well as for policy.X.<br>&gt; <br>&gt;    When pp is downgraded the flavor flag and roles ebitmap would be<br>&gt;    discarded, resulting in role attributes useless at all. So in such<br>&gt;    case role attributes should be !
 skipped for pp too.<br>&gt; <br>&gt; <br>&gt; Tests I've done<br>&gt; -----------------<br>&gt; 1. Apply the role attribute test patch from Chris, adding a new test_r<br>&gt;    role and calls rpm_run() for it.<br>&gt;    <br>&gt; 2. Use the apol tool to analyze what types the test_r role could type with:<br>&gt;    (Since the apol installed on Ubuntu so far only support max version .24,<br>&gt;     we need to setup "policy-version = 24" in semanage.conf)<br>&gt;    <br>&gt; Note: <br>&gt; . There is no role attributes such as portage/semanage/rpm_roles in policy.24<br>&gt; . By default pp's version is 13.<br>&gt; <br>&gt; test_r (36 types)<br>&gt;     bootloader_t<br>&gt;     chfn_t<br>&gt;     chkpwd_t<br>&gt;     consoletype_t<br>&gt;     ddclient_t<br>&gt;     depmod_t<br>&gt;     dhcpc_t<br>&gt;     groupadd_t<br>&gt;     hostname_t<br>&gt;     ifconfig_t<br>&gt;     insmod_t<br>&gt;     iptables_t<br>&gt;     ldconfig_t<br>&gt;     load_policy_t<br>&gt;     loadkeys_t!
 <br>&gt;     lvm_t<br>&gt;     netutils_t<br>&gt;     newrole_t<br>&gt
;     nscd_t<br>&gt;     pam_t<br>&gt;     passwd_t<br>&gt;     ping_t<br>&gt;     pppd_t<br>&gt;     pptp_t<br>&gt;     prelink_t<br>&gt;     rpm_script_t<br>&gt;     rpm_t<br>&gt;     semanage_t<br>&gt;     setfiles_t<br>&gt;     test_t<br>&gt;     traceroute_t<br>&gt;     tzdata_t<br>&gt;     updpwd_t<br>&gt;     useradd_t<br>&gt;     usernetctl_t<br>&gt;     utempter_t<br>&gt; <br>&gt; 3. In write_binary_policy() in checkmodule.c, trigger pp downgrade<br>&gt;    by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1;", then use<br>&gt;    apol to analyze what types the test_r role could type with:<br>&gt; <br>&gt; Note:<br>&gt; . After downgrade, pp's version is 12 now.<br>&gt; <br>&gt; test_r (22 types)<br>&gt;     chfn_t<br>&gt;     chkpwd_t<br>&gt;     consoletype_t<br>&gt;     ddclient_t<br>&gt;     dhcpc_t<br>&gt;     hostname_t<br>&gt;     ifconfig_t<br>&gt;     insmod_t<br>&gt;     iptables_t<br>&gt;     loadkeys_t<br>&gt;     netutils_t<br>&gt;     newrole_t<br>&gt!
 ;     pam_t<br>&gt;     passwd_t<br>&gt;     ping_t<br>&gt;     pppd_t<br>&gt;     pptp_t<br>&gt;     test_t<br>&gt;     traceroute_t<br>&gt;     updpwd_t<br>&gt;     usernetctl_t<br>&gt;     utempter_t<br>&gt; <br>&gt;    Where we can see that test_r could no longer type with all those<br>&gt;    types that are typed by rpm_roles and semanage_roles.<br>&gt; <br>&gt;    (BTW, this means that once role attributes are endorsed in refpolicy,<br>&gt;     the influence of pp downgrade could be far-reaching and perhaps<br>&gt;     undesirable.)<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_2eaffa3b-b2b5-4caf-9ce1-ac60e775ee30_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
