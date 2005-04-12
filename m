From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: Re: audit2 in FC4T2
Date: Tue, 12 Apr 2005 23:12:27 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
References: <200504121857.45872.russell@coker.com.au>
In-Reply-To: <200504121857.45872.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+k8WCz5t1/ifsk6"
Message-Id: <200504122312.30239.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_+k8WCz5t1/ifsk6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 12 April 2005 18:57, Russell Coker <russell@coker.com.au> wrote:
> It seems that auditd now logs to /var/log/audit/audit.log.  I've attached a
> fixed version of auditd.fc.

Had a second problem, auditctl didn't work if initrc_t wasn't unrestricted.  
I've attached a new auditd.fc which labels auditctl as auditd_exec_t.

Also in auditd.te log_domain needs to be changed to logdir_domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_+k8WCz5t1/ifsk6
Content-Type: text/plain;
  charset="utf-8";
  name="auditd.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="auditd.fc"

# auditd
/sbin/auditd		--	system_u:object_r:auditd_exec_t
/sbin/auditctl		--	system_u:object_r:auditd_exec_t
/var/log/audit(/.*)? 	 	system_u:object_r:auditd_log_t

--Boundary-00=_+k8WCz5t1/ifsk6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
