From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: audit2 in FC4T2
Date: Tue, 12 Apr 2005 18:57:42 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J24WCukDZd3HWIu"
Message-Id: <200504121857.45872.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_J24WCukDZd3HWIu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It seems that auditd now logs to /var/log/audit/audit.log.  I've attached a 
fixed version of auditd.fc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_J24WCukDZd3HWIu
Content-Type: text/plain;
  charset="us-ascii";
  name="auditd.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="auditd.fc"

# auditd
/sbin/auditd		--	system_u:object_r:auditd_exec_t
/var/log/audit(/.*)? 	 	system_u:object_r:auditd_log_t

--Boundary-00=_J24WCukDZd3HWIu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
