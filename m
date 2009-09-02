Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8237CdY010842
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 23:07:12 -0400
Received: from mail-px0-f193.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8236ZKX022595
	for <selinux@tycho.nsa.gov>; Wed, 2 Sep 2009 03:06:35 GMT
Received: by pxi31 with SMTP id 31so493996pxi.3
        for <selinux@tycho.nsa.gov>; Tue, 01 Sep 2009 20:07:11 -0700 (PDT)
Date: Wed, 2 Sep 2009 11:07:12 +0800
From: "zheyeung" <zheyeung@gmail.com>
To: "fedora-selinux-list" <fedora-selinux-list@redhat.com>
Cc: "selinux" <selinux@tycho.nsa.gov>
Subject: I cannot change my shell context
Message-ID: <200909021107080933047@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon383518832085_====="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is a multi-part message in MIME format.

--=====003_Dragon383518832085_=====
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

hi , every body ,I install selinux-policy-targeted in my F11,and run in enforce mode.
now I want to change selinux context of /tmp/test,but  failed.I thought current shell domain was unconfined_t. then I intend to change my shell context to root:sysadm_r: sysadm_t ,but also failed. 
my project team plan to develop selinux policy for our system based on selinux-policy.src.rpm. I guess is  this package have not been developed? If it has been developed ,why I cannot change to sysadm_r: sysadm_t? 

----------------------------------------------------------------------------

[root@localhost ~]# ls -lZ /tmp/testselinux
root root unconfined_u:object_r:user_t:user_tmp_t: s0 /tmp/testselinux

[root@localhost ~]#chcon unconfined_u:object_r:mytest_t /tmp/testselinux
chcon:failed to change context of '/tmp/testselinux' to 'unconfined_u:object_r:testselinux: s0 : permission denied

## here mytest_t defined in myapp.pp,which has successfully loaded by "semodule -i myapp.pp"

[root@localhost ~]# newrole -r sysadm_r -t sysadm_t
unconfined_u:unconfined_r:unconfined_t: s0 is not valid context

[root@localhost ~]# semanage login -m -s root -r s0-s0:c0.c1023 root

after reboot, graphic terminal cannot run. audit says that system_u:system_r: xdm_t require "read" permission for system_u:object_r:httpd_sys_content_t.

[root@localhost ~]# id
context= root:unconfined_r:unconfined_t: s0-s0:c0-c1023

[root@localhost ~]#  newrole -r sysadm_r -t sysadm_t
failed to exec shell: permission denied
2009-09-02 



zheyeung 

--=====003_Dragon383518832085_=====
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=us-ascii">
<META content="MSHTML 6.00.6000.16809" name=GENERATOR><LINK 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}" 
rel=stylesheet></HEAD>
<BODY style="FONT-SIZE: 10pt; MARGIN: 10px; FONT-FAMILY: verdana">
<DIV><FONT face=Verdana size=2>hi , every body ,I install 
selinux-policy-targeted in my F11,and run in enforce mode.</FONT></DIV>
<DIV>now I want to change selinux context of /tmp/test,but&nbsp; failed.I 
thought current shell domain was unconfined_t. then I intend to change my shell 
context to root:sysadm_r: sysadm_t&nbsp;,but also failed.&nbsp;</DIV>
<DIV>my project team plan to develop selinux policy for our system based on 
selinux-policy.src.rpm.&nbsp;I guess is&nbsp; this package have not been 
developed?&nbsp;If&nbsp;it&nbsp;has been 
developed&nbsp;,why&nbsp;I&nbsp;cannot&nbsp;change to sysadm_r: 
sysadm_t?&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>----------------------------------------------------------------------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]# ls -lZ /tmp/testselinux</DIV>
<DIV>root root unconfined_u:object_r:user_t:user_tmp_t: s0 
/tmp/testselinux</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]#chcon unconfined_u:object_r:mytest_t 
/tmp/testselinux</DIV>
<DIV>chcon:failed to change context of '/tmp/testselinux' to 
'unconfined_u:object_r:testselinux: s0 : permission denied</DIV>
<DIV>&nbsp;</DIV>
<DIV>## here mytest_t defined in myapp.pp,which has successfully loaded by 
"semodule -i myapp.pp"</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]# newrole -r sysadm_r -t sysadm_t</DIV>
<DIV>unconfined_u:unconfined_r:unconfined_t: s0 is not valid context</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]# semanage login -m -s root -r s0-s0:c0.c1023 root</DIV>
<DIV>&nbsp;</DIV>
<DIV>after&nbsp;reboot, graphic terminal cannot run. audit says that 
system_u&#65306;system_r: xdm_t&nbsp;require "read" permission for 
system_u:object_r:httpd_sys_content_t.</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]# id</DIV>
<DIV>context= root:unconfined_r:unconfined_t: s0-s0:c0-c1023</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]#&nbsp; newrole -r sysadm_r -t sysadm_t</DIV>
<DIV>failed to exec shell: permission denied</DIV>
<DIV align=left><FONT face=Verdana color=#c0c0c0 size=2>2009-09-02 
</FONT></DIV><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT face=Verdana color=#c0c0c0 size=2><SPAN>zheyeung</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon383518832085_=====--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
