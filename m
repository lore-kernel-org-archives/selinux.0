Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JAF3rT011660
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 06:15:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JAE32w019533
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 10:14:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: atsar system stats
Date: Sun, 19 Sep 2004 20:14:58 +1000
Cc: selinux@tycho.nsa.gov
References: <20040913225410.GB14736@wintermute.xmldesign.de>
In-Reply-To: <20040913225410.GB14736@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iwVTBLs2sFCC9FW"
Message-Id: <200409192014.58452.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_iwVTBLs2sFCC9FW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 14 Sep 2004 08:54, Erich Schubert <erich@debian.org> wrote:
> "atsar" is a system statistics utility. There is already a file context
> defined so it runs in the sysstat_t type, but i added the following
> rule to get rid of a warning:
>
> dontaudit sysstat_t staff_home_dir_t:dir { search getattr };

sysstat is one of many programs that runs as UID==0 and tries to access it's 
home directory (probably because of being run from cron and cron will set the 
current directory before execution).

The policy for sysstat has a dontaudit rule for access to sysadm_home_dir_t 
but none for staff_home_dir_t.

Put sysadm_r before staff_r in the "users" entry for "root" and then rebuild 
the file_contexts file and relabel /root and things will work fine.

It's best to use sysadm_home_dir_t for /root so that someone who logs in as 
staff_r can't write to /root.  If you have /root labelled as staff_home_dir_t 
then an attacker who gains access to staff_r:staff_t (IE someone who 
compromises sshd with strict policy) can replace /root/.bashrc etc and thus 
make it impossible for an administrator to safely login at the console.

I've attached a patch for the users file which does this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_iwVTBLs2sFCC9FW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/users	2004-05-30 16:26:57.000000000 +1000
+++ users	2004-09-19 20:14:26.000000000 +1000
@@ -41,7 +41,7 @@
 
 # The sysadm_r user also needs to be permitted system_r if we are to allow
 # direct execution of daemons
-user root roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', `system_r') };
+user root roles { sysadm_r staff_r ifdef(`direct_sysadm_daemon', `system_r') };
 
 # sample for administrative user
 #user jadmin roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', `system_r') };

--Boundary-00=_iwVTBLs2sFCC9FW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
