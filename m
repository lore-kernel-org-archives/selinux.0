To: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
References: <1556412.5WZ4KfFcyq@liv>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0b9a5099-c0e1-773f-e31c-a0baf81a8d78@tycho.nsa.gov>
Date: Mon, 4 Jun 2018 08:44:29 -0400
MIME-Version: 1.0
In-Reply-To: <1556412.5WZ4KfFcyq@liv>
Content-Type: text/plain; charset=utf-8
Subject: Re: BTRFS losing SE Linux labels on power failure or "reboot -nffd".
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/01/2018 09:03 AM, Russell Coker via Selinux wrote:
> The command "reboot -nffd" (kernel reboot without flushing kernel buffers or writing status) when run on a BTRFS system will often result in /var/log/audit/audit.log being unlabeled. It also results in some systemd-journald files like /var/log/journal/c195779d29154ed8bcb4e8444c4a1728/system.journal being unlabeled but that is rarer. I think that the same problem afflicts both systemd-journald and auditd but it's a race condition that on my systems (both production and test) is more likely to affect auditd.
> 
>  
> 
> If this issue just affected "reboot -nffd" then a solution might be to just not run that command. However this affects systems after a power outage.
> 
>  
> 
> I have reproduced this bug with kernel 4.9.0-6-amd64 (the latest security update for Debian/Stretch which is the latest supported release of Debian). I have also reported it in an identical manner with kernel 4.16.0-1-amd64 (the latest from Debian/Unstable). For testing I reproduced this with a 4G filesystem in a VM, but in production it has happened on BTRFS RAID-1 arrays, both SSD and HDD.
> 
>  
> 
> #!/bin/bash
> set -e
> COUNT=$(ps aux|grep [s]bin/auditd|wc -l)
> date
> if [ "$COUNT" = "1" ]; then
>  echo "all good"
> else
>  echo "failed"
>  exit 1
> fi
> 
> Firstly the above is the script /usr/local/sbin/testit, I test for auditd running because it aborts if the context on it's log file is wrong.
> 
>  
> 
> root@stretch:~# ls -liZ /var/log/audit/audit.log
> 37952 -rw-------. 1 root root system_u:object_r:auditd_log_t:s0 4385230 Jun  1 12:23 /var/log/audit/audit.log
> 
> Above is before I do the tests.
> 
>  
> 
> while ssh stretch /usr/local/sbin/testit ; do
>  ssh btrfs-local "reboot -nffd" > /dev/null 2>&1 &
>  sleep 20
> done
> 
> Above is the shell code I run to do the tests. Note that the VM in question runs on SSD storage which is why it can consistently boot in less than 20 seconds.
> 
>  
> 
> Fri  1 Jun 12:26:13 UTC 2018
> all good
> Fri  1 Jun 12:26:33 UTC 2018
> failed
> 
> Above is the output from the shell code in question. After the first reboot it fails. The probability of failure on my test system is greater than 50%.
> 
>  
> 
> root@stretch:~# ls -liZ /var/log/audit/audit.log  
> 37952 -rw-------. 1 root root system_u:object_r:unlabeled_t:s0 4396803 Jun  1 12:26 /var/log/audit/audit.log
> 
> Now the result. Note that the Inode has not changed. I could understand a newly created file missing an xattr, but this is an existing file which shouldn't have had it's xattr changed. But somehow it gets corrupted.
> 
>  
> 
> Could this be the fault of SE Linux code? I don't think it's likely but this is what the BTRFS developers will ask so it's best to discuss this here before sending it to them.

No, that's definitely a filesystem bug.  It is the filesystem's responsibility to ensure that new inodes are assigned a security.* xattr in the same transaction as the file creation (ext[234] does this, for example, e.g. via ext4_init_security()), and that they don't lose them.  SELinux just provides the xattr suffix ("selinux") and the value/value_len pair.

> 
>  
> 
> Does anyone have any ideas of other tests I should run? Anyone want me to try a different kernel? I can give root on a VM to anyone who wants to poke at it. Anything else I should add when sending this to the BTRFS developers?
