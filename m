Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3ECBJI4019747
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 08:11:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3ECB8q0000449
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 12:11:08 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h3ECB4Mi000432 for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 12:11:05 GMT
Date: Mon, 14 Apr 2003 22:10:48 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: auditallow
Message-ID: <20030414121048.GB29334@snoopy.apana.org.au>
References: <200304141822.43798.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200304141822.43798.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 14, 2003 at 06:22:43PM +1000, Russell Coker wrote:
> Apr 14 18:16:21 caesar kernel: avc:  denied  { search } for  pid=8716 
> exe=/usr/sbin/sendmail path=/run dev=09:03 ino=2593 
> scontext=root:sysadm_r:sysadm_mail_t tcontext=system_u:object_r:var_run_t 
> tclass=dir
> 
> Surely it should be reporting "granted" not "denied".

Are you sure it really is granted, and not denied?

The code in
security/selinux/include/linux/flask/avc.h:avc_has_perm_ref_audit(...) and
and security/selinux/avc.c:avc_audit(...) looks pretty
clear to me, at least on this point.

Inside avc_has_perm_ref_audit if avc_audit is called with
AVC_AUDITDENY==1, it prints denied. After avc_audit returns if enforcing
mode is enabled, then the operation is immediately denied.

Assuming I have correctly understood the code, of course.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
