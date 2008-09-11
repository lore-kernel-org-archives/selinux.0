Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8BL19vx015968
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 17:01:09 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8BL198L018189
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 21:01:09 GMT
Received: by yw-out-1718.google.com with SMTP id 6so207901ywa.84
        for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 14:01:08 -0700 (PDT)
Message-ID: <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
Date: Thu, 11 Sep 2008 14:01:08 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "=?ISO-8859-1?Q?V=E1clav_Ovs=EDk?=" <vaclav.ovsik@i.cz>
Subject: Re: [refpolicy] ssh issue with latest policy
Cc: "SE Linux" <selinux@tycho.nsa.gov>, Hong <kindloaf@gmail.com>,
        tresys <refpolicy@oss.tresys.com>
In-Reply-To: <20080911125025.GA5448@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
	 <20080911125025.GA5448@bobek.pm.i.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2008 at 5:50 AM, Václav Ovsík <vaclav.ovsik@i.cz> wrote:
> On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:
>> Hong,
>> I cant seem to locate the post you sent a few days ago
>> about logging into ssh. anyways I finally got around to logging into
>> my machines with both the latest kernel and refpolicy;
>> there was difficulty due to having /etc/host and /etc/sysctl.conf
>> variables in these files preventing me from logging in.
>> So with that in mind check and make sure those files
>> are cleared of anything that might cause an error.
>> As for the policy itself they were both in permissive mode
>> via boot param, so having /etc/selinux/config in enforcing
>> didnt cause an ubstruction for me.
>> hope this helps.
>
> May be. And Hong not replied yet if he did relabel the file system. :)
>
> I have tried to restart sshd with nonsense context to show the problem
> even with PERMISSIVE mode of SE Linux!
>
> sid:~# sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          enforcing
> Policy version:                 23
> Policy from config file:        default
>
> sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart
>
> sid:~# ps -H -Z -C sshd
> LABEL                             PID TTY          TIME CMD
> sysadm_u:sysadm_r:sysadm_t:s0    1944 ?        00:00:00 sshd
> system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd
> system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00   sshd
>
> That is the new parent process sshd running with sysadm_u:sysadm_r:sysadm_t:s0.
>
> zito@bobek:~$ ssh sid
> Read from remote host sid: Connection reset by peer
> Connection to sid closed.
>
> sid:~# tail -2 /var/log/syslog
> Sep 11 14:32:18 sid kernel: [  649.880210] sshd[1954]: segfault at 2 ip b7ad5cea sp bfc2b04c error 4 in libc-2.7.so[b7a60000+155000]
> Sep 11 14:32:18 sid kernel: [  649.883080] type=1701 audit(1221136338.451:27): auid=4294967295 uid=1000 gid=1000 ses=4294967295 subj=sysadm_u:sysadm_r:sysadm_t:s0 pid=1954 comm="sshd" sig=11
>
>
> This is mature for bug report on openssh.
> Conclusion: Running SE Linux in permissive mode can't prevent you from
> all SE Linux problems every time! (in most cases yes of course :)
>
> --
> Zito
>

appologize for the latency with getting back to you;
you might have the ssh version from sid, if so
do /etc/init.d/ssh stop and start if you notice [fail] then thats the issue,
esspecially if people are booting up and not even manually starting the daemon.
As for the policy and ssh I'm in the process of
having two machines in full enforcing mode, having the ability
to do a ssh transaction(need to configure some things); As well
as vncviewer, and shoutcast; all with ipsec. (AH and ESP)
right now I've been able to run all three applications on the machine
that is in full enforcement, but it seems im having issues with ipsec
and shoutcast.
on the server side.
I'll get back to you on this.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
