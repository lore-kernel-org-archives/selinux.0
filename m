Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w56B0CQ0027116
 for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2018 07:00:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 4115L23Y50z3GDBN
 for <selinux@tycho.nsa.gov>; Wed,  6 Jun 2018 11:00:10 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 4115L145Tnz3GDB2
 for <selinux@tycho.nsa.gov>; Wed,  6 Jun 2018 11:00:09 +0000 (UTC)
Received: from liv.localnet (localhost [127.0.0.1])
 by smtp.sws.net.au (Postfix) with ESMTP id 043C6ED5C
 for <selinux@tycho.nsa.gov>; Wed,  6 Jun 2018 20:59:21 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Date: Wed, 06 Jun 2018 20:59:17 +1000
Message-ID: <1633170.KAVgCv33VX@liv>
In-Reply-To: <1598911.AOxyaR8aoy@liv>
References: <1598911.AOxyaR8aoy@liv>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: BTRFS losing SE Linux labels on power failure or "reboot -nffd"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://www.spinics.net/lists/linux-btrfs/msg77927.html

Thanks to Hans van Kranenburg and Holger Hoffstätte, the above has the link to 
a message with the patch for this which was already included in kernel 4.16.11 
which was uploaded to Debian on the 27th of May and got into testing about the 
time that my message got to the SE Linux list.

The kernel from Debian/Stable still has the issue.  So using a testing kernel 
might be a good option to deal with this problem at the moment.

On Monday, 4 June 2018 11:14:52 PM AEST Russell Coker wrote:
> The command "reboot -nffd" (kernel reboot without flushing kernel buffers or
> writing status) when run on a BTRFS system with SE Linux will often result
> in /var/log/audit/audit.log being unlabeled.  It also results in some
> systemd- journald files like
> /var/log/journal/c195779d29154ed8bcb4e8444c4a1728/ system.journal being
> unlabeled but that is rarer.  I think that the same problem afflicts both
> systemd-journald and auditd but it's a race condition that on my systems
> (both production and test) is more likely to affect auditd.
> 
> root@stretch:/# xattr -l /var/log/audit/audit.log
> security.selinux:
> 0000   73 79 73 74 65 6D 5F 75 3A 6F 62 6A 65 63 74 5F    system_u:object_
> 0010   72 3A 61 75 64 69 74 64 5F 6C 6F 67 5F 74 3A 73    r:auditd_log_t:s
> 0020   30 00                                              0.
> 
> SE Linux uses the xattr "security.selinux", you can see what it's doing with
> xattr(1) but generally using "ls -Z" is easiest.
> 
> If this issue just affected "reboot -nffd" then a solution might be to just
> not run that command.  However this affects systems after a power outage.
> 
> I have reproduced this bug with kernel 4.9.0-6-amd64 (the latest security
> update for Debian/Stretch which is the latest supported release of Debian). 
> I have also reproduced it in an identical manner with kernel 4.16.0-1-amd64
> (the latest from Debian/Unstable).  For testing I reproduced this with a 4G
> filesystem in a VM, but in production it has happened on BTRFS RAID-1
> arrays, both SSD and HDD.
> 
> #!/bin/bash
> set -e
> COUNT=$(ps aux|grep [s]bin/auditd|wc -l)
> date
> if [ "$COUNT" = "1" ]; then
>  echo "all good"
> else
>  echo "failed"
>  exit 1
> fi
> 
> Firstly the above is the script /usr/local/sbin/testit, I test for auditd
> running because it aborts if the context on it's log file is wrong.  When SE
> Linux is in enforcing mode an incorrect/missing label on the audit.log file
> causes auditd to abort.
> 
> root@stretch:~# ls -liZ /var/log/audit/audit.log
> 37952 -rw-------. 1 root root system_u:object_r:auditd_log_t:s0 4385230 Jun 
> 1 12:23 /var/log/audit/audit.log
> Above is before I do the tests.
> 
> while ssh stretch /usr/local/sbin/testit ; do
>  ssh btrfs-local "reboot -nffd" > /dev/null 2>&1 &
>  sleep 20
> done
> Above is the shell code I run to do the tests.  Note that the VM in question
> runs on SSD storage which is why it can consistently boot in less than 20
> seconds.
> 
> Fri  1 Jun 12:26:13 UTC 2018
> all good
> Fri  1 Jun 12:26:33 UTC 2018
> failed
> Above is the output from the shell code in question.  After the first reboot
> it fails.  The probability of failure on my test system is greater than
> 50%.
> 
> root@stretch:~# ls -liZ /var/log/audit/audit.log
> 37952 -rw-------. 1 root root system_u:object_r:unlabeled_t:s0 4396803 Jun 
> 1 12:26 /var/log/audit/audit.log
> Now the result.  Note that the Inode has not changed.  I could understand a
> newly created file missing an xattr, but this is an existing file which
> shouldn't have had it's xattr changed.  But somehow it gets corrupted.
> 
> The first possibility I considered was that SE Linux code might be at fault.
> I asked on the SE Linux mailing list (I haven't been involved in SE Linux
> kernel code for about 15 years) and was informed that this isn't likely at
> all.  There have been no problems like this reported with other
> filesystems.
> 
> Does anyone have any ideas of other tests I should run?  Anyone want me to
> try a different kernel?  I can give root on a VM to anyone who wants to
> poke at it.


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
