Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4AD3cn6001923
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2012 09:03:38 -0400
Received: from 93-143-176-17.adsl.net.t-com.hr ([93.143.176.17] helo=[192.168.1.152])
	by hebe.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1SST1t-0003P5-HX
	for selinux@tycho.nsa.gov; Thu, 10 May 2012 06:03:38 -0700
Message-ID: <4FABBCA4.8090006@rubix.com>
Date: Thu, 10 May 2012 15:03:32 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: execute system-config-selinux while enforcing
Content-Type: multipart/alternative;
 boundary="------------050906060606010406000104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050906060606010406000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am running Scientific Linux 6.0, fully updated using the targeted policy.

Is there a method to execute the SELinux admin GUI tool 
system-config-selinux while in enforcing mode of the targeted policy?

My assumption is that root linux user combined with sysadm_r role would 
work. However, after creating a shell with sudo -i -r sysadm_r (from the 
staff_r role), the tool fails to start. I then tried to create a user 
that would login via the GUI login and receive the sysadm_r role by 
default. In this case I was unsuccessful in even getting the sysadm_r 
role to have the sysadm_t upon login. It receives a context of 
sysadm_u:sysadm_r:oddjob_mkhomedir_t. This despite having the following 
/etc/selinux/targeted/contexts/users/sysadm_u file:

system_r:local_login_t:s0    sysadm_r:sysadm_t:s0
system_r:remote_login_t:s0    sysadm_r:sysadm_t:s0
system_r:sshd_t:s0        sysadm_r:sysadm_t:s0
system_r:crond_t:s0        sysadm_r:sysadm_t:s0
system_r:xdm_t:s0        sysadm_r:sysadm_t:s0
sysadm_r:sysadm_su_t:s0        sysadm_r:sysadm_t:s0
sysadm_r:sysadm_sudo_t:s0    sysadm_r:sysadm_t:s0
system_r:initrc_su_t:s0        sysadm_r:sysadm_t:s0
sysadm_r:sysadm_t:s0        sysadm_r:sysadm_t:s0
sysadm_r:sysadm_su_t:s0        sysadm_r:sysadm_t:s0
sysadm_r:sysadm_sudo_t:s0    sysadm_r:sysadm_t:s0

Thanks,

Andy



--------------050906060606010406000104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <font face="Arial">I am running Scientific Linux 6.0, fully updated
      using the targeted policy. <br>
      <br>
      Is there a method to execute the SELinux admin GUI tool
      system-config-selinux while in enforcing mode of the targeted
      policy? <br>
      <br>
      My assumption is that root linux user combined with sysadm_r role
      would work. However, after creating a shell with sudo -i -r
      sysadm_r (from the staff_r role), the tool fails to start. I then
      tried to create a user that would login via the GUI login and
      receive the sysadm_r role by default. In this case I was
      unsuccessful in even getting the sysadm_r role to have the
      sysadm_t upon login. It receives a context of
      sysadm_u:sysadm_r:oddjob_mkhomedir_t. This despite having the
      following /etc/selinux/targeted/contexts/users/sysadm_u file:<br>
      <br>
      system_r:local_login_t:s0&nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      system_r:remote_login_t:s0&nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      system_r:sshd_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      system_r:crond_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      system_r:xdm_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      sysadm_r:sysadm_su_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      sysadm_r:sysadm_sudo_t:s0&nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      system_r:initrc_su_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      sysadm_r:sysadm_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      sysadm_r:sysadm_su_t:s0&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0 <br>
      sysadm_r:sysadm_sudo_t:s0&nbsp;&nbsp;&nbsp; sysadm_r:sysadm_t:s0<br>
      <br>
      Thanks,<br>
      <br>
      Andy<br>
      <br>
      <br>
    </font>
  </body>
</html>

--------------050906060606010406000104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
