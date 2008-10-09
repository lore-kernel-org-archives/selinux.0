Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99LJIR6013337
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 17:19:18 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99LI5To007050
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 21:18:05 GMT
Received: from 78-3-123-90.adsl.net.t-com.hr ([78.3.123.90] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1Ko2uh-0004dt-1K
	for selinux@tycho.nsa.gov; Thu, 09 Oct 2008 14:19:16 -0700
Message-ID: <48EE7546.2080006@rubix.com>
Date: Thu, 09 Oct 2008 23:19:02 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: building base policy on RHEL5
Content-Type: multipart/alternative;
 boundary="------------080208070700040308070706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080208070700040308070706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am (SELinux newbie) working on a project which will require me to add 
new object classes to my policy. After doing much reading, I find that 
in order to add object classes I must modify and build the base policy 
(??). My approach is to download the source for the policy, modify it 
with the new object classes and TE rules, and build it. My first step is 
to try and simply build the strict (or any) policy from the sources. I 
get a syntax error when trying to build the policy. My steps are:

rpm -i selinux-policy-2.4.6-137.1.el5.src.rpm
cd /usr/src/redhat/SPECS
rpmbuild -bp selinux-policy.spec
cd /usr/src/redhat/BUILD/serefpolicy-2.4.6
make conf
make

which results in the following failure:

/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/services/fail2ban.te:59:ERROR 'syntax error' at token 
'corenet_tcp_connect_whois_port' on line 439903:
 
corenet_tcp_connect_whois_port(fail2ban_t)
checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.21] Error 1


some possibly relevant packages are:

checkpolicy.i386                         1.33.1-4.el5           
installed      
policycoreutils.i386                     1.33.12-14.el5         
installed      
policycoreutils-gui.i386                 1.33.12-14.el5         
installed      
policycoreutils-newrole.i386             1.33.12-14.el5         
installed      
selinux-policy.noarch                    2.4.6-137.1.el5        
installed      
selinux-policy-devel.noarch              2.4.6-137.1.el5        
installed      
selinux-policy-mls.noarch                2.4.6-137.1.el5        
installed      
selinux-policy-strict.noarch             2.4.6-137.1.el5        
installed      
selinux-policy-targeted.noarch           2.4.6-137.1.el5        
installed   
libselinux.i386                          1.33.4-5.el5           
installed      
libselinux-devel.i386                    1.33.4-5.el5           
installed      
libselinux-python.i386                   1.33.4-5.el5           
installed      
libsemanage.i386                         1.9.1-3.el5            
installed      
libsepol.i386                            1.15.2-1.el5           
installed      
libsepol-devel.i386                      1.15.2-1.el5           installed 
setools.i386                             3.0-3.el5              installed
setools-devel.i386                       3.0-3.el5              
installed      
setools-gui.i386                         3.0-3.el5              
installed      
setroubleshoot.noarch                    2.0.5-3.el5            
installed      
setroubleshoot-plugins.noarch            2.0.4-2.el5            
installed      
setroubleshoot-server.noarch             2.0.5-3.el5            
installed     

Any help would be greatly appreciated,

Andy

--------------080208070700040308070706
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">I am (SELinux newbie) working on a project which
will require me to add new object classes to my policy. After doing
much reading, I find that in order to add object classes I must modify
and build the base policy (??). My approach is to download the source
for the policy, modify it with the new object classes and TE rules, and
build it. My first step is to try and simply build the strict (or any)
policy from the sources. I get a syntax error when trying to build the
policy. My steps are:<br>
<br>
rpm -i selinux-policy-2.4.6-137.1.el5.src.rpm<br>
cd /usr/src/redhat/SPECS<br>
rpmbuild -bp selinux-policy.spec<br>
cd /usr/src/redhat/BUILD/serefpolicy-2.4.6<br>
make conf<br>
make<br>
<br>
which results in the following failure:<br>
<br>
/usr/bin/checkpolicy policy.conf -o policy.21<br>
/usr/bin/checkpolicy:&nbsp; loading policy configuration from policy.conf<br>
policy/modules/services/fail2ban.te:59:ERROR 'syntax error' at token
'corenet_tcp_connect_whois_port' on line 439903:<br>
&nbsp;<br>
corenet_tcp_connect_whois_port(fail2ban_t)<br>
checkpolicy:&nbsp; error(s) encountered while parsing configuration<br>
make: *** [policy.21] Error 1<br>
<br>
<br>
some possibly relevant packages are:<br>
<br>
checkpolicy.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.1-4.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
policycoreutils.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.12-14.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
policycoreutils-gui.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.12-14.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
policycoreutils-newrole.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.12-14.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
selinux-policy.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.6-137.1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
selinux-policy-devel.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.6-137.1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
selinux-policy-mls.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.6-137.1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
selinux-policy-strict.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.6-137.1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
selinux-policy-targeted.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.6-137.1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp; <br>
libselinux.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.4-5.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
libselinux-devel.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.4-5.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
libselinux-python.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.33.4-5.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
libsemanage.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.9.1-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
libsepol.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.15.2-1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
libsepol-devel.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.15.2-1.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp; <br>
setools.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.0-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed<br>
setools-devel.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.0-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
setools-gui.i386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.0-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
setroubleshoot.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.0.5-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
setroubleshoot-plugins.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.0.4-2.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
setroubleshoot-server.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.0.5-3.el5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
Any help would be greatly appreciated,<br>
<br>
Andy</font>
</body>
</html>

--------------080208070700040308070706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
