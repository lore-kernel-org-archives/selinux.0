Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4HEuhvt014781
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 10:56:43 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4HEufju016297
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 14:56:42 GMT
Subject: Re: Latest diffs in policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4468A509.50207@redhat.com>
References: <4468A509.50207@redhat.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 10:58:26 -0400
Message-Id: <1147877907.31984.40.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, except for auditadm.  I'm waiting for the separation issues to
be sorted out, then it can be merged.

On Mon, 2006-05-15 at 11:58 -0400, Daniel J Walsh wrote:
> Add boolean to allow mount to mount any file/filesystem.  (Bind Mounts).
> 
> More fixes for auditadm role.  Any chance of getting this into ref 
> policy or should I separate out the patch?
> 
> Fixes for traceroute
> 
> prelink wants to read sbin symlinks
> 
> Mono needs to chat with unconfined_t (acquire_svc).
> 
> Fix label on scsi_id to stop matchpathcon error message
> 
> 
> Lots of new network ports for hplib and http.
> 
> Traceroute port range defined.
> 
> Add setrans domain
> 
> Want to associate all files with tmpfs so the user can mv /etc/FILE /tmp 
> and not blow up.
> 
> Add clamscan policy
> 
> Allow bluetooth to communicate with xdm pipes.
> 
> Allow sysadm to run cvs and rdisk
> 
> Dovecod wants quota support
> 
> ftpd needs dav override when logging in to users homedirs
> 
> Hal wants to search all directories in case they are mount points
> 
> Fixes to inn.if for executing inn and allowin domtrans
> 
> ypbind needs to be able to bind to rpc ports
> 
> postgresql wants to look at the routing table.
> 
> pyzor domain for strict/mls policy
> 
> rpc wants to red /dev/random
> nfsd needs dac privs
> 
> Added some corecmd_executable_file for prelink to work correctly
> 
> sshd wants to read routing table
> 
> Only want dhcp to transition to hostname everyone else should just 
> execute it.
> 
> More fixes for textrel_shlib_t. will they ever end
> 
> Separation of the auditadm from secadm and sysadm changes for auditd files.
> 
> semanage is now translated.
> 
> semodule needs to be able to read home dir and /tmp dir since this is 
> where people are creating modules.
> 
> ifconfig wants to read urand for ipsec setup
> 
> unconfined domtrans to prelink and inn

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
