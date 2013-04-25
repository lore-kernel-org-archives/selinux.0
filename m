Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3PLZCSM001852
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2013 17:35:12 -0400
Message-ID: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com>
Date: Thu, 25 Apr 2013 14:35:07 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: SELinux errors with pam_faillock
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="1091002116-147978722-1366925707=:22597"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--1091002116-147978722-1366925707=:22597
Content-Type: text/plain; charset=us-ascii

Hello,

I'm receiving some SELinux errors related to the pam_faillock module. I'm running RHEL 6.3 with a custom policy based on the reference policy. 


When a user enters an incorrect password, the pam faillock module will track it with a file in /var/run/faillock/<user>. This is being applied whenever the user enters their password (i.e. console login, newrole, sudo). Everything works appropriately for the console login. For newrole and sudo, I'm getting errors when the /var/run/faillock/<user> file is trying to be created. Basically, newrole_t and <role>_sudo_t don't have permission to create files in a faillog_t dir. 


I found a rule in 'selinuxutil.te' allowing newrole_t to read/write to faillog: "auth_rw_faillog(newrole_t)". However, this rule only allows writing if the file already exists. It doesn't address if the faillock file needs to be created. 


I'm able to address the issues with the following rules:

# Note that these rules would be applied in the sudo interface to support all sudo types

create_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )
setattr_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )allow sysadm_sudo_t_t self:capability:chown;


create_files_pattern( newrole_t, faillog_t, faillog_t )
setattr_files_pattern( newrole_t, faillog_t, faillog_t )
allow newrole_t self:capability:chown;

Is this the correct solution? Or should a transition be happening when faillock executes?


Thanks,
Andy Ruch

--1091002116-147978722-1366925707=:22597
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hello,</div><div><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">I'm receiving some SELinux errors related to the pam_faillock module. I'm running RHEL 6.3 with a custom policy based on the reference policy. <br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">When a user enters an incorrect password, the pam faillock module will track it with a file in /var/run/faillock/&lt;user&gt;. This is being applied whenever the user enters their
 password (i.e. console login, newrole, sudo). Everything works appropriately for the console login. For newrole and sudo, I'm getting errors when the /var/run/faillock/&lt;user&gt; file is trying to be created. Basically, newrole_t and &lt;role&gt;_sudo_t don't have permission to create files in a faillog_t dir. <br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">I found a rule in 'selinuxutil.te' allowing newrole_t to read/write to faillog: "auth_rw_faillog(newrole_t)". However, this rule only allows writing if the file already exists. It doesn't address if the faillock file needs to be created. <br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new
 roman,new york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">I'm able to address the issues with the following rules:</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;"># Note that these rules would be applied in the sudo interface to support all sudo types<br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">create_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )</div><div style="color: rgb(0, 0,
 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">setattr_files_pattern( sysadm_sudo_t, faillog_t, faillog_t )</div>allow sysadm_sudo_t_t self:capability:chown;<br><br><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">create_files_pattern( newrole_t, faillog_t, faillog_t )</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">setattr_files_pattern( newrole_t, faillog_t, faillog_t )</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">allow newrole_t self:capability:chown;</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new
 york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">Is this the correct solution? Or should a transition be happening when faillock executes?<br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">Thanks,</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times,serif; background-color: transparent; font-style: normal;">Andy Ruch<br></div></div></body></html>
--1091002116-147978722-1366925707=:22597--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
