Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NGMVw6018770
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 11:22:31 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NGNoPU002719
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 16:23:50 GMT
Subject: Re: PATCH: Remove redundant role statement from the apache.te file.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702181540r3734cb6bh7c68ed1f9f323d1e@mail.gmail.com>
References: <e739902b0702181540r3734cb6bh7c68ed1f9f323d1e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 16:24:05 +0000
Message-Id: <1172247845.15371.58.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-02-18 at 15:40 -0800, Ryan Bradetich wrote:
> I am working on writing a policy for the Boa web server.  I am using
> the SELinux by example book and the apache modules for guidance.
> Going through the apache.te file I noticed the following entry is
> redundant:
> 
>     role system_r types httpd_t;
> 
> This statement is provided as part of the init_daemon_domain interface
> in the modules/system/init.if interface file.  Here is the line in the
> init_daemon_domain interface function:
> 
>    role system_r types $1;
> 
> I have attached a patch to remove role entry from the apache.te file.

Since this doesn't hurt anything, I'd rather just leave it since its all
over the policy right now.  The issue is that if you rely on the
interface to allow the role the daemon type, you still have to allow the
role to any subdomains of the daemon (like httpd_sys_script_t)
explicitly.  This makes the handling of the primary domain and sub
domains of a daemon slightly inconsistent.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
