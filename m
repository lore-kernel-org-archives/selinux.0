Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4P0fYSj020234
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 20:41:34 -0400
Received: from smtp-2.emich.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4P0fXbH005269
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 00:41:33 GMT
Message-ID: <4474FD2C.3080004@tubbs-net.com>
Date: Wed, 24 May 2006 20:41:16 -0400
From: Christopher L Tubbs II <chris@tubbs-net.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: HTTPD network access Policy Problem
References: <44738020.3090200@tubbs-net.com> <1148479969.31984.183.camel@sgc.columbia.tresys.com>
In-Reply-To: <1148479969.31984.183.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Tue, 2006-05-23 at 17:35 -0400, Christopher L Tubbs II wrote:
>> I'm reasonably new to SELinux, but I noticed recently that a change I
>> made in my policy (from the GUI system-config-securitylevel) a while
>> back to allow the HTTPD to have network access so I can use Web-based
>> mail scripts now does not seem to work. The only change I've made since
>> then was period "yum update" with the occasionally policy updates
>> through that. However, despite the fact that the GUI still shows the
>> settings that I had changed in the past, the policy is still blocking
>> access (It works in Permissive mode). Can anybody perhaps explain why
>> this might be, and what specifically I should check to verify the
>> settings and make this functional again?
> 
> First we need to see the denial messages (avc: denied messages) to see
> exactly what permissions are being denied.  You can find them
> in /var/log/messages (or /var/log/audit/audit.log if you have auditd
> running).
> 

It should be noted that I am using PHP to do the mailing.

May 24 20:37:15 tubbs-net kernel: audit(1148517435.478:65): avc:  denied
 { execute } for  pid=2456 comm="httpd" name="bash" dev=dm-0 ino=3470057
scontext=system_u:system_r:httpd_t:s0
tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Chris
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdP0rc/oGTmWP/osRAnM6AJ9RFwZrk1O8XlZYP+U77QY20Pb/qQCgtocB
vT+rswYVCy+NZEF3ZckOZJ4=
=RvbW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
