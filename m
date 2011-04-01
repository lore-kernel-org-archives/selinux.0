Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p319C8E2023015
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 05:12:08 -0400
Received: from snt0-omc3-s47.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p319C7Y3018907
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 09:12:07 GMT
Message-ID: <SNT139-w6155F82B0FEDA03D69574CABBE0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c2acf165-b14e-4dde-817c-7e5159802e6d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: How to make restorecon/matchpathcon recognize role_transition rule
 for non-process classes?
Date: Fri, 1 Apr 2011 09:12:07 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_c2acf165-b14e-4dde-817c-7e5159802e6d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,

If we adopt role_transition rules for non-process classes then how we could have restorecon or matchpathcon tools properly recognize them? So far these tools could only read from file_contexts, or file_contexts.homedirs or file_contexts.local files and they only knows that the role for non-process class objects to be "object_r".

Suppose we have below role_transition rule:
    role_transition sysadm_r user_home_t:{ file dir } sysadm_r;

Which means any objects of the file or dir classes created in a parent directory with type as user_home_t by the sysadm_r would have sysadm_r as the objects' role. Since it is hard to know:
1. The path of such parent directories, and
2. The seuser that is assuming the sysadm_r role;
It would be impossible to use "semanage fcontext -a" command to specify special security contexts for files at run-time, nor add relevant rules in the related .fc files(so as to prevent restorecon to relabel the object's role to "object_r").

Comments?

Thanks!
Harry
 		 	   		  
--_c2acf165-b14e-4dde-817c-7e5159802e6d_
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
Hi,<br><br>If we adopt role_transition rules for non-process classes then how we could have restorecon or matchpathcon tools properly recognize them? So far these tools could only read from file_contexts, or file_contexts.homedirs or file_contexts.local files and they only knows that the role for non-process class objects to be "object_r".<br><br>Suppose we have below role_transition rule:<br>&nbsp;&nbsp;&nbsp; role_transition sysadm_r user_home_t:{ file dir } sysadm_r;<br><br>Which means any objects of the file or dir classes created in a parent directory with type as user_home_t by the sysadm_r would have sysadm_r as the objects' role. Since it is hard to know:<br>1. The path of such parent directories, and<br>2. The seuser that is assuming the sysadm_r role;<br>It would be impossible to use "semanage fcontext -a" command to specify special security contexts for files at run-time, nor add relevant rules in the related .fc files(so as to prevent restorecon to relabel the ob!
 ject's role to "object_r").<br><br>Comments?<br><br>Thanks!<br>Harry<br> 		 	   		  </body>
</html>
--_c2acf165-b14e-4dde-817c-7e5159802e6d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
