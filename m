Subject: Re: Not sure the best way to handle this one.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <416FCFEB.90504@redhat.com>
References: <416FCFEB.90504@redhat.com>
Content-Type: text/plain
Message-Id: <1098120682.27895.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 13:31:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-15 at 09:26, Daniel J Walsh wrote:
> Oct 15 08:37:55 dhcppc1 kernel: audit(1097843874.920:692545): avc:  
> denied  { sys_module } for  pid=4338 exe=/usr/bin/nifd capability=16 
> scontext=system_u:system_r:howl_t tcontext=system_u:system_r:howl_t 
> tclass=capability

Boot with audit=1 and reproduce please, then provide the full syscall
audit information.  In general, SELinux users would likely always
benefit from enabling the syscall auditing as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
