Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2MKGjol016809
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2013 16:16:50 -0400
Message-ID: <1363983388.48128.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Date: Fri, 22 Mar 2013 13:16:28 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: sudo best practices
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hello,

I’m requesting information on some “best practices” regarding using sudo in an SELinux environment. I’m implementing a very locked down RHEL6 system using the Reference Policy as a base.  The following scenario is just one example of many use cases, so don’t worry about the “mounting” details, just the sudo aspect. 

Scenario:
Auditadm role needs the ability to mount a drive. However, I don’t want auditadm to be able to mount anything else. Therefore, I’ve created a script (mymount.sh) to mount a particular drive in a particular location. The script also does some extra stuff around the mount command for convenience and logging. The script is labeled mymount_exec_t. When executed, it will transition to mymount_t. Rules were created so that Auditadm is allowed to execute mymount_exec_t and transition appropriately to mymount_t. Because mounting a drive requires root permissions, sudo must be used somewhere. Currently, I made the script only executable by root. Auditadm then executes the script using sudo. My reasoning for this was to allow sudo to be executed using the built-in sudo domain for auditadm (auditadm_sudo_t). Then all I had to do was allow my script domain (mymount_t) to run mount. 


Problem:
I discovered that ‘sudo_role_template’ allows the auditadm sudo domain to execute all executables (corecmd_exec_all_executables). I didn’t necessarily want to grant auditadm the ability to execute any command as sudo. For example, I have other scripts that should only be executed by sysadm. At the same time, auditadm needs to be able to use sudo for day-to-day responsibilities such as ls, less, cp, etc. for working with /var/log/audit/*. 



Questions:
1) What are the “best practices” regarding using sudo? 

2) What’s the best way to allow some sudo access but restrict others?

3) In the above example, would it be better to call sudo just on the mount command? Then I would have to allow all permissions for mymount_t to run sudo.


Thanks,
Andy Ruch


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
