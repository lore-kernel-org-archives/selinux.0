Message-ID: <42E65ACD.1030805@guardiandigital.com>
Date: Tue, 26 Jul 2005 11:46:21 -0400
From: Pax Dickinson <pax@guardiandigital.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Failed to get default security context?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm using a slightly modified version of the reference policy and I'm 
having trouble getting regular users logged in under the correct context.

When I log in as root over ssh, everything is OK and my context is 
root:sysadm_r:sysadm_t.  However if I create a regular user and log in 
over ssh I'm given a system_u:system_r:sshd_t context and the system log 
reads :

Jul 26 11:32:36 salle2 sshd[2711]: Accepted password for pax from 
192.168.1.208 port 55677
Jul 26 11:32:36 salle2 sshd[2713]: error: Failed to get default security 
context for pax. Continuing in permissve mode
Jul 26 11:32:36 salle2 sshd[2711]: error: Failed to get default security 
context for pax. Continuing in permissve mode
Jul 26 11:32:36 salle2 sshd[2711]: error: 
security_compute_relabel(/dev/ttyp2) failed: Invalid argument
Jul 26 11:32:36 salle2 sshd[2714]: error: Failed to get default security 
context for pax. Continuing in permissve mode

I tried adding an entry to local.users and specifying a role for that 
username, but it doesn't seem to help.  If I log in at the console as 
root I'm given a context of system_u:system_r:local_login_t which may be 
part of the same problem or something completely different.

Is this a known problem with the reference policy or am I doing 
something wrong?  Any advice would be greatly appreciated.

Thanks, Pax

--
Pax Dickinson
Guardian Digital, Inc.
pax@guardiandigital.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
