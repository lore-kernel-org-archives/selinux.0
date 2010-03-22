Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2MFrrYf006813
	for <selinux@tycho.nsa.gov>; Mon, 22 Mar 2010 11:53:58 -0400
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2MFsaip010004
	for <selinux@tycho.nsa.gov>; Mon, 22 Mar 2010 15:54:36 GMT
Received: from c-76-105-117-198.hsd1.ga.comcast.net ([76.105.117.198] helo=[192.168.1.4])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1Ntjwu-000307-TE
	for selinux@tycho.nsa.gov; Mon, 22 Mar 2010 08:53:53 -0700
Message-ID: <4BA79290.8010609@rubix.com>
Date: Mon, 22 Mar 2010 11:53:52 -0400
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: userdom_unpriv_user_template use errors and creating new roles
Content-Type: multipart/alternative;
 boundary="------------090605000605030700080205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090605000605030700080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Using FC12, fully updated. I have two basic, but possibly related 
questions. The first is regarding a change to the targeted policy that 
resulted in an install error for our Trusted RUBIX policy when using the 
userdom_unpriv_user_template interface, as off the last targeted policy 
update. The second are denials I now receive after changing our policy 
to use a different interface.

First issue:

Our policy had been declaring a custom role (rubix_dbadm_r in this case) 
using the following:
userdom_unpriv_user_template(rubix_dbadm)
corecmd_exec_shell(rubix_dbadm_t)

Originally, this worked for its intended purposes with no selinux 
denials. As of installing policy update:
Name       : selinux-policy-targeted
Arch       : noarch
Version    : 3.6.32
Release    : 103.fc12

When we build our policy we received the following errors:
rubix-dev.te:175: Warning: xserver_user_client() has been deprecated, 
please use xserver_user_x_domain_template instead.
Installing rubix-dev-targeted policy
libsepol.print_missing_requirements: rubix-dev's global requirements 
were not met: type/attribute xdrawable_type (No such file or directory).
libsemanage.semanage_link_sandbox: Link packages failed (No such file or 
directory).
semodule:  Failed!

I had been receiving the depreciated warning a while (ignoring at my own 
peril), the link error was new to this targeted policy version. I also 
received errors while installing selinux-policy-targeted rpm itself, 
stating a different requirement not being met in the then installed 
rubix-dev policy. I do not recall the exact error message, but remember 
it was an X related type that was missing.

Noting the X connection between the depreciated function and the link 
error, I traced the reference to the depreciated 'xserver_user_client' 
interface to 'userdom_unpriv_user_template'. I did not call 
'xserver_user_client' directly. I replaced the call to 
'userdom_unpriv_user_template' with a call to 
'userdom_restricted_user_template' and my then policy installed properly.

But using the 'userdom_restricted_user_template ' interface, now I 
notice some selinux denials during a call to newrole, which is my second 
question below. I am not sure that the change to the new interface is 
the cause of the denials, I am just now noticing them.

Should the 'userdom_unpriv_user_template' interface either be fixed or 
removed from the userdom *.if file?

Second issue:

The rubix_dbadm_r role is now created with:
userdom_restricted_user_template(rubix_dbadm)
corecmd_exec_shell(rubix_dbadm_t)

When I perform a newrole, I receive denials as follows (note, I am in 
permissive mode so the newrole succeeds):

$ id -Z
rxdev_u:staff_r:staff_t:s0-s0:c0.c1023
$ ls -Z `tty`
crw--w----. warner tty rxdev_u:object_r:user_devpts_t:s0 /dev/pts/4
$ newrole -r rubix_dbadm_r
Password:
$

Note: I am a bit surprised that the tty type is user_devpts_t and not 
staff_devpts_t, though I am very unfamiliar with this.

Mar 22 11:04:03 localhost setroubleshoot: SELinux is preventing 
/usr/bin/newrole "write" access on /var/run/dbus/system_bus_socket. For 
complete SELinux messages. run sealert -l 
95fc56ee-8711-460c-874b-6ddb91cc9add
Mar 22 11:04:03 localhost setroubleshoot: SELinux is preventing 
/usr/bin/newrole "write" access on /var/run/dbus/system_bus_socket. For 
complete SELinux messages. run sealert -l 
95fc56ee-8711-460c-874b-6ddb91cc9add

# more securetty_types
sysadm_tty_device_t
user_tty_device_t
staff_tty_device_t
user_devpts_t
devpts_t
#

Are these denials related to how I create the rubix_dbadm_r role? Is 
there a proper way to create a role suitable for  auser to transition 
into and as a potential default logon user role?

I fully admit my choice of creating a role was through observation of 
other policy code and trail and error. It would be nice to have a 
definitive word on it.

Thanks,

Andy



--------------090605000605030700080205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Using FC12, fully updated. I have two basic, but
possibly related questions. The first is regarding a change to the
targeted policy that resulted in an install error for our Trusted RUBIX
policy when using the </font><font face="Arial">userdom_unpriv_user_template</font><font
 face="Arial"> interface, as off the last targeted policy update. The
second are denials I now receive after changing our policy to use a
different interface.<br>
<br>
First issue:<br>
<br>
Our policy had been declaring a custom role (rubix_dbadm_r in this
case) using the following:<br>
</font><font face="Arial">userdom_unpriv_user_template</font><font
 face="Arial">(</font><font face="Arial">rubix_dbadm</font><font
 face="Arial">)<br>
corecmd_exec_shell(</font><font face="Arial">rubix_dbadm</font><font
 face="Arial">_t)</font><br>
<br>
Originally, this worked for its intended purposes with no selinux
denials. As of installing policy update:<br>
Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : selinux-policy-targeted<br>
Arch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : noarch<br>
Version&nbsp;&nbsp;&nbsp; : 3.6.32<br>
Release&nbsp;&nbsp;&nbsp; : 103.fc12<br>
<br>
When we build our policy we received the following errors:<br>
rubix-dev.te:175: Warning: xserver_user_client() has been deprecated,
please use xserver_user_x_domain_template instead.<br>
Installing rubix-dev-targeted policy<br>
libsepol.print_missing_requirements: rubix-dev's global requirements
were not met: type/attribute xdrawable_type (No such file or directory).<br>
libsemanage.semanage_link_sandbox: Link packages failed (No such file
or directory).<br>
semodule:&nbsp; Failed!<br>
<br>
I had been receiving the depreciated warning a while (ignoring at my
own peril), the link error was new to this targeted policy version. I
also received errors while installing selinux-policy-targeted rpm
itself, stating a different requirement not being met in the then
installed rubix-dev policy. I do not recall the exact error message,
but remember it was an X related type that was missing.<br>
<br>
Noting the X connection between the depreciated function and the link
error, I traced the reference to the depreciated 'xserver_user_client'
interface to '<font face="Arial">userdom_unpriv_user_template'. I did
not call </font>'xserver_user_client' directly. I replaced the call to
'<font face="Arial">userdom_unpriv_user_template' </font>with a call
to '<font face="Arial">userdom_restricted_user_template' and my then
policy installed properly. </font><br>
<br>
But using the '<font face="Arial">userdom_restricted_user_template ' </font>interface,
now I notice some selinux denials during a call to newrole, which is my
second question below. I am not sure that the change to the new
interface is the cause of the denials, I am just now noticing them.<br>
<br>
Should the '<font face="Arial">userdom_unpriv_user_template' interface
either be fixed or removed from the userdom *.if file?</font><br>
<font face="Arial"><br>
Second issue:<br>
<br>
The rubix_dbadm_r role is now created with:<br>
userdom_restricted_user_template(</font><font face="Arial">rubix_dbadm</font><font
 face="Arial">)<br>
corecmd_exec_shell(</font><font face="Arial">rubix_dbadm</font><font
 face="Arial">_t)<br>
<br>
When I perform a newrole, I receive denials as follows (note, I am in
permissive mode so the newrole succeeds):<br>
<br>
$ id -Z<br>
rxdev_u:staff_r:staff_t:s0-s0:c0.c1023<br>
$ ls -Z `tty`<br>
crw--w----. warner tty rxdev_u:object_r:user_devpts_t:s0 /dev/pts/4<br>
$ newrole -r rubix_dbadm_r<br>
Password: <br>
$ <br>
<br>
Note: I am a bit surprised that the tty type is </font><font
 face="Arial">user_devpts_t and not </font><font face="Arial">staff_devpts_t</font>,
though I am very unfamiliar with this.<br>
<font face="Arial"><br>
Mar 22 11:04:03 localhost setroubleshoot: SELinux is preventing
/usr/bin/newrole "write" access on /var/run/dbus/system_bus_socket. For
complete SELinux messages. run sealert -l
95fc56ee-8711-460c-874b-6ddb91cc9add<br>
Mar 22 11:04:03 localhost setroubleshoot: SELinux is preventing
/usr/bin/newrole "write" access on /var/run/dbus/system_bus_socket. For
complete SELinux messages. run sealert -l
95fc56ee-8711-460c-874b-6ddb91cc9add<br>
<br>
# more securetty_types<br>
sysadm_tty_device_t<br>
user_tty_device_t<br>
staff_tty_device_t<br>
user_devpts_t<br>
devpts_t<br>
#<br>
<br>
Are these denials related to how I create the rubix_dbadm_r role? Is
there a proper way to create a role suitable for&nbsp; auser to transition
into and as a potential default logon user role?<br>
<br>
I fully admit my choice of creating a role was through observation of
other policy code and trail and error. It would be nice to have a
definitive word on it.<br>
<br>
Thanks,<br>
<br>
Andy <br>
<br>
<br>
</font>
</body>
</html>

--------------090605000605030700080205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
