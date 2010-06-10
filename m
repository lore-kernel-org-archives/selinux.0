Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5A9FX9w010998
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 05:15:33 -0400
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5A9EjWx016549
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 09:14:45 GMT
Received: from cm61-15-71-24.hkcable.com.hk ([61.15.71.24] helo=[192.168.11.3])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1OMdrD-0006LT-81
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2010 02:15:27 -0700
Message-ID: <4C10AD2B.9080802@rubix.com>
Date: Thu, 10 Jun 2010 17:15:23 +0800
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: mcs_systemhigh use
Content-Type: multipart/alternative;
 boundary="------------010904080507090900070707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010904080507090900070707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the policy for the Trusted RUBIX DBMS, we assign file contexts using 
the following (only one representative dir, 'backups', shown):

ifdef(`enable_mls',`
/var/lib/RUBIXdbms/backups(/.*)?      
gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh)
')
ifdef(`enable_mcs',`
/var/lib/RUBIXdbms/backups(/.*)?     
gen_context(system_u:object_r:rubix_backup_t,mcs_systemhigh)
')

When using the mls policy, I get the expected level of mls_systemhigh 
(s15:c0.c1023). But when using the targeted policy, I get an unexpected 
value for mcs_systemhigh. I would expect to get s0:c0.c1023, but get s0. 
I have verified this behavior on Fedora 9 and 12. Is my assumption wrong 
about what mcs_systemhigh should be or am I missing something?

Relevant output from 'semanage fcontext -l'
/var/lib/RUBIXdbms/backups(/.*)?                   all files          
system_u:object_r:rubix_backup_t:s0

Thanks,

Andy



--------------010904080507090900070707
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">In the policy for the Trusted RUBIX DBMS, we assign
file contexts using the following (only one representative dir,
'backups', shown):<br>
<br>
ifdef(`enable_mls',`<br>
/var/lib/RUBIXdbms/backups(/.*)?&nbsp;&nbsp;&nbsp; &nbsp;
gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh)<br>
')<br>
ifdef(`enable_mcs',`<br>
/var/lib/RUBIXdbms/backups(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;
gen_context(system_u:object_r:rubix_backup_t,mcs_systemhigh)<br>
')<br>
<br>
When using the mls policy, I get the expected level of mls_systemhigh
(s15:c0.c1023). But when using the targeted policy, I get an unexpected
value for mcs_systemhigh. I would expect to get s0:c0.c1023, but get
s0. I have verified this behavior on Fedora 9 and 12. Is my assumption
wrong about what mcs_systemhigh should be or am I missing something?<br>
<br>
Relevant output from 'semanage fcontext -l'<br>
/var/lib/RUBIXdbms/backups(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all files&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
system_u:object_r:rubix_backup_t:s0 <br>
<br>
Thanks,<br>
<br>
Andy<br>
<br>
<br>
</font>
</body>
</html>

--------------010904080507090900070707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
