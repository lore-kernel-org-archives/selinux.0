Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3P6UGXx029882
 for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2017 02:30:16 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsemanage: remove lock files
Date: Tue, 25 Apr 2017 16:30:03 +1000
References: <58517705.198270.1492699110308@pim.register.it>
 <100DD2AB-228E-47B5-8058-C9F030AEA665@trentalancia.net>
 <C6C00E69-C6B1-4408-B27A-C05D7B6B9D00@trentalancia.net>
In-Reply-To: <C6C00E69-C6B1-4408-B27A-C05D7B6B9D00@trentalancia.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201704251630.03844.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 25 Apr 2017 04:38:40 AM Guido Trentalancia wrote:
> Also, another major benefit of not using flock() comes when using NFS
> (probably a very rare circumstance, but not entirely impossibile).
> 
> It is possible to use the presence of a file (with the same name) to
> indicate an "active" lock: such file should store the PID of the process
> that is requiring the lock.
> 
> If a lock is found with a PID that does not exist, then such lock is
> considered invalid and it is removed.  That is it really...

Pidfile locking doesn't work well as pids are not unique, you can have a 
process die and be replaced by another process with the same pid.  Also a 
reboot is expected to have pid conflicts as pids are allocated sequentially and 
most daemons end up with low numbers.  Using a tmpfs for /run solves some of 
these problems as it's reliably cleared out at boot.

Things get even more exciting if you use systemd-nspawn and have multiple pid 
namespaces on the same system with bind mounts of directories that have 
pidfiles.

Pidfile locking also never works across network filesystems as pids are local to 
a system.  You could have some combination of pid and hostname (as done by 
some web browsers) but that gets ugly.

Really pidfiles are so horrible that one of the noteworthy features of systemd 
is removing the need for them.

Having multiple systems operate with NFS root and a shared /etc/selinux is 
never going to work well.  Even if everything works well (and it probably 
won't) you will end up with systems that have the policy in /etc/selinux not 
matching what is running.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
