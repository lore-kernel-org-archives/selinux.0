Date: Wed, 15 Oct 2003 19:17:16 -0700
From: Michael Reilly <michaelr@cisco.com>
To: SELinux@tycho.nsa.gov
Subject: Yet another question - newrole and xterm's
Message-Id: <20031015191716.5478c74b.michaelr@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry to keep asking questions - I am still relatively new to this and would
like to make things as secure as possible.  I am hoping to run selinux on my
laptop along with an encrypted file system when I travel.  (Disclaimers all
read and understood - I know I am on my own and there are no guarantees,
etc.)

Anyway on my system in enforcing mode -
%  id
uid=200(michaelr) gid=200(staff)
groups=200(staff),1(bin),6(disk),10(wheel),300(vmware)
context=michaelr:staff_r:staff_t sid=287
% newrole -r sysadm_r
Authenticating michaelr.
Password: 
newrole: incorrect password for michaelr
%  id
uid=200(michaelr) gid=200(staff)
groups=200(staff),1(bin),6(disk),10(wheel),300(vmware)
context=michaelr:staff_r:staff_t sid=287

I found this in newrole.te.
# Failed reads to /proc cause no harm, so do not audit them
dontaudit newrole_t proc_t:dir search;

changing the dontaudit line to this and reloading the policy
allow newrole_t proc_t:dir search;

% newrole -r sysadm_r
Authenticating michaelr.
Password: 
% id
uid=200(michaelr) gid=200(staff)
groups=200(staff),1(bin),6(disk),10(wheel),300(vmware)
context=michaelr:sysadm_r:sysadm_t sid=286
%

What is wrong on my system that I need to allow this instead of not auditing
it?  USE_PAM is defined and I am using PAM for login, etc.

Thanks,

michael
-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
