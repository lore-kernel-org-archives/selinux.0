Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FK5ZWt028380
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:05:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FK5YmR023559
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 20:05:34 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id h9FK5Wjp023556 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 20:05:33 GMT
Message-ID: <3F8D9B39.4060904@ipen.br>
Date: Wed, 15 Oct 2003 17:08:41 -0200
From: =?UTF-8?B?Q2FybG9zIEFuw61zaW8gTW9udGVpcm8=?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: =?UTF-8?B?Q2FybG9zIEFuw61zaW8gTW9udGVpcm8=?= <monteiro@ipen.br>
Subject: Re: enforce mode problems
References: <3F8D2B57.2080807@ipen.br> <1066242001.7399.87.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------080106050905060903020806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------080106050905060903020806
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>You need to address the avc messages before switching into enforcing
>mode.  From the sound of it, you still haven't labeled your
>filesystems.  Did you run 'make relabel' to completion?  What does ls -Z
>/sbin/init show?
>
>  
>
1) Yes, 'make relabel' to completion. I think that all filesystem  is 
labeled, except /selinux and /proc directories.

2) ls -Z /sbin/init
    invalid option.

obs.:
ls --context /sbin/init
-rwxr-xr-x  root     root     system_u:object_r:init_exec_t    /sbin/init

Regards.



--------------080106050905060903020806
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1066242001.7399.87.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap=""></pre>
  <pre wrap=""><!---->You need to address the avc messages before switching into enforcing
mode.  From the sound of it, you still haven't labeled your
filesystems.  Did you run 'make relabel' to completion?  What does ls -Z
/sbin/init show?

  </pre>
</blockquote>
1) Yes, 'make relabel' to completion. I think that all filesystem  is labeled,
except /selinux and /proc directories.<br>
<br>
2) ls -Z /sbin/init <br>
    invalid option.<br>
<br>
obs.:<br>
ls --context /sbin/init<br>
-rwxr-xr-x  root     root     system_u:object_r:init_exec_t    /sbin/init<br>
<br>
Regards.<br>
<br>
<br>
</body>
</html>

--------------080106050905060903020806--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
