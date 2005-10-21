Message-Id: <200510210233.j9L2X1Df006128@mms-r00.iijmio.jp>
Date: Thu, 20 Oct 2005 22:32:50 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: capability audit_write, audit_control
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Are capability audit_write and audit_control actually used ?
I can not find code where capability audit_control and audit_write are used.
Capability is checked capable ---> selinux_capable.
But I can not find "capable(CAP_AUDIT_WRITE)" and "capable(CAP_AUDIT_CONTROL)". 
My kernel is  2.6.12-1.1398_FC4 .
I found following in kernel/audit.c
if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
if (!cap_raised(eff_cap, CAP_AUDIT_WRITE))
However, "capable" is not used so selinux_capable will not be called.

In addition, I found strange behavior.
I add following lines in strict policy.

auditallow sshd_t self:capability { audit_control };
neverallow sshd_t self:capability audit_control;

In this policy, sshd will never be allowed to use audit_control.

However, I found following log when user logged in by ssh. 

audit(1129827338.333:34): avc:  granted  { audit_control } for  pid=2313 comm="sshd" capability=30 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=capability

ssh_t is granted audit_control in log, 
but  sshd_t is not granted auditcontrol in policy.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
