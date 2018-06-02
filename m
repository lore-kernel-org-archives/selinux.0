Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w52IIVCg009176
 for <selinux@tycho.nsa.gov>; Sat, 2 Jun 2018 14:18:31 -0400
Received: by mail-ua0-f196.google.com with SMTP id e8-v6so19472178uam.13
 for <selinux@tycho.nsa.gov>; Sat, 02 Jun 2018 11:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556412.5WZ4KfFcyq@liv>
In-Reply-To: <1556412.5WZ4KfFcyq@liv>
From: Nick Kralevich <nnk@google.com>
Date: Sat, 2 Jun 2018 11:18:09 -0700
Message-ID: <CAFJ0LnHum9-xHsAOXgtiL16p2eCfPsUXo=P2hN+C55U5yLdGdw@mail.gmail.com>
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: BTRFS losing SE Linux labels on power failure or "reboot -nffd".
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Does BTRFS have the equivalent of an fsck command which is run on
boot? I've seen similar problems before where fsck tries fixing up the
filesystem after an unclean shutdown, and the SELinux labels aren't
properly handled by the fsck program.

I have no idea if this is related to your problem or not. Just more
food for thought.

-- Nick
On Sat, Jun 2, 2018 at 12:20 AM Russell Coker via Selinux
<selinux@tycho.nsa.gov> wrote:
>
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
>  echo "all good"
> else
>  echo "failed"
>  exit 1
> fi
>
> Firstly the above is the script /usr/local/sbin/testit, I test for auditd running because it aborts if the context on it's log file is wrong.
>
>
>
> root@stretch:~# ls -liZ /var/log/audit/audit.log
> 37952 -rw-------. 1 root root system_u:object_r:auditd_log_t:s0 4385230 Jun  1 12:23 /var/log/audit/audit.log
>
> Above is before I do the tests.
>
>
>
> while ssh stretch /usr/local/sbin/testit ; do
>  ssh btrfs-local "reboot -nffd" > /dev/null 2>&1 &
>  sleep 20
> done
>
> Above is the shell code I run to do the tests. Note that the VM in question runs on SSD storage which is why it can consistently boot in less than 20 seconds.
>
>
>
> Fri  1 Jun 12:26:13 UTC 2018
> all good
> Fri  1 Jun 12:26:33 UTC 2018
> failed
>
> Above is the output from the shell code in question. After the first reboot it fails. The probability of failure on my test system is greater than 50%.
>
>
>
> root@stretch:~# ls -liZ /var/log/audit/audit.log
> 37952 -rw-------. 1 root root system_u:object_r:unlabeled_t:s0 4396803 Jun  1 12:26 /var/log/audit/audit.log
>
> Now the result. Note that the Inode has not changed. I could understand a newly created file missing an xattr, but this is an existing file which shouldn't have had it's xattr changed. But somehow it gets corrupted.
>
>
>
> Could this be the fault of SE Linux code? I don't think it's likely but this is what the BTRFS developers will ask so it's best to discuss this here before sending it to them.
>
>
>
> Does anyone have any ideas of other tests I should run? Anyone want me to try a different kernel? I can give root on a VM to anyone who wants to poke at it. Anything else I should add when sending this to the BTRFS developers?
>
>
>
> --
>
> My Main Blog http://etbe.coker.com.au/
>
> My Documents Blog http://doc.coker.com.au/
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Nick Kralevich | Fuchsia Security | nnk@google.com | 650.214.4037
