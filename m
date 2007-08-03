Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l733vnr9018267
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 23:57:49 -0400
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l733vkG9019257
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 03:57:47 GMT
Date: Thu, 2 Aug 2007 20:57:36 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH][RFC] V1 Remove SELinux dependencies from linux-audit via LSM
To: casey@schaufler-ca.com, LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
In-Reply-To: <600616.50420.qm@web36614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <487163.89353.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Casey Schaufler <casey@schaufler-ca.com> wrote:

> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> This patch removes SELinux specific code from the kernel auditing
> system, replacing it with LSM hook invocations that perform the
> functions appropriate to those behaviors.
> 
> The LSM interface is extended to provide interfaces for a module
> to add audit filters. Interfaces are added to get secids from
> inodes and ipcs.
> 
> The audit code is revised to call these hooks instead of the SELinux
> functions. This requires some structure definitions to change header
> files.
> 
> The SELinux code is changed to export the old interfaces as LSM hooks
> instead of doing so directly. The SELinux specific audit filter code
> has been moved into the SELinux module.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> ---

Forgot to include: The patch is relative to 2.6.22.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
