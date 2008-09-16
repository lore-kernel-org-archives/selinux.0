Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GJqdEd026963
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 15:52:39 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GJqdls002699
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 19:52:39 GMT
Received: by wx-out-0506.google.com with SMTP id s19so1338907wxc.30
        for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:52:39 -0700 (PDT)
Message-ID: <dd18b0c30809161252u21dbe2ecpe3449ad3fc0da653@mail.gmail.com>
Date: Tue, 16 Sep 2008 12:52:38 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: Hong <kindloaf@gmail.com>
Subject: Re: [refpolicy] ssh issue with latest policy
Cc: "=?ISO-8859-1?Q?V=E1clav_Ovs=EDk?=" <vaclav.ovsik@i.cz>,
        "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <f00ed96d0809161219p786e7cc3w3905c9f1dd8d8f8d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
	 <20080911125025.GA5448@bobek.pm.i.cz>
	 <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
	 <f00ed96d0809161119o6c726384h2a9fb19dc0364ebc@mail.gmail.com>
	 <dd18b0c30809161138j5602356buc687c015891c960f@mail.gmail.com>
	 <f00ed96d0809161219p786e7cc3w3905c9f1dd8d8f8d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 16, 2008 at 12:19 PM, Hong <kindloaf@gmail.com> wrote:
> Do you mean "make enableaudit" under the refpolicy source directory?  I did
> this and the output is as follows:
> .../refpolicy-0.0.20071214$ sudo make enableaudit
> cat: /selinux/policyvers: No such file or directory
> Removing dontaudit rules from policy.conf
> egrep -v dontaudit policy.conf > tmp/policy.audit
> mv tmp/policy.audit policy.conf
>
> And I "sudo make relabel" under the refpolicy source directory to relabel
> the file system.  (I already relabel the file system before).
>
> And after reboot, the machine still cannot boot.  I found following entries
> in /var/log/syslog after another reboot with kernel option enforcing=0:
>
> Sep 16 15:07:27 hostname init: tty4 main process (4000) killed by TERM
> signal
> Sep 16 15:07:27 hostname init: tty5 main process (4001) killed by TERM
> signal
> Sep 16 15:07:27 hostname init: tty2 main process (4006) killed by TERM
> signal
> Sep 16 15:07:27 hostname init: tty3 main process (4008) killed by TERM
> signal
> Sep 16 15:07:27 hostname init: tty6 main process (4012) killed by TERM
> signal
> Sep 16 15:07:27 hostname init: tty1 main process (4314) killed by TERM
> signal
> Sep 16 15:07:27 hostname restorecond: terminated
> Sep 16 15:07:29 hostname postfix/master[4214]: terminating on signal 15
> Sep 16 15:07:31 hostname kernel: [ 3579.730352] ip6_tables: (C) 2000-2006
> Netfilter Core
> Sep 16 15:07:31 hostname exiting on signal 15
>
> There is no entry in /var/log/messages for the unsuccessful reboot.
>
> Does it show any clue of the problem?
>
> Hong
>
> On Tue, Sep 16, 2008 at 2:38 PM, Justin Mattock <justinmattock@gmail.com>
> wrote:
>>
>> On Tue, Sep 16, 2008 at 11:19 AM, Hong <kindloaf@gmail.com> wrote:
>> > I shutdown the sshd and restart it, now I can connect without problem.
>> > (permissive mode).
>> >
>> > Thanks for the information!
>> >
>> > And I reboot the machine and switched to enforcing mode, the machine
>> > cannot
>> > boot normally.  Looks like rcS doesn't work:
>> > exec: 7: /etc/init.d/rcS: Permission denied
>> > init: rcS main process (2335) terminated with status 2
>> > init: rc-default main process (2337) terminated with status 1
>> >
>> > And then the machine just hung there.  I could not log in.
>> >
>> > ps: sorry for the delay.  I had some deadline last week...
>> >
>> > Hong
>> >
>> > On Thu, Sep 11, 2008 at 5:01 PM, Justin Mattock
>> > <justinmattock@gmail.com>
>> > wrote:
>> >>
>> >> On Thu, Sep 11, 2008 at 5:50 AM, Václav Ovsík <vaclav.ovsik@i.cz>
>> >> wrote:
>> >> > On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:
>> >> >> Hong,
>> >> >> I cant seem to locate the post you sent a few days ago
>> >> >> about logging into ssh. anyways I finally got around to logging into
>> >> >> my machines with both the latest kernel and refpolicy;
>> >> >> there was difficulty due to having /etc/host and /etc/sysctl.conf
>> >> >> variables in these files preventing me from logging in.
>> >> >> So with that in mind check and make sure those files
>> >> >> are cleared of anything that might cause an error.
>> >> >> As for the policy itself they were both in permissive mode
>> >> >> via boot param, so having /etc/selinux/config in enforcing
>> >> >> didnt cause an ubstruction for me.
>> >> >> hope this helps.
>> >> >
>> >> > May be. And Hong not replied yet if he did relabel the file system.
>> >> > :)
>> >> >
>> >> > I have tried to restart sshd with nonsense context to show the
>> >> > problem
>> >> > even with PERMISSIVE mode of SE Linux!
>> >> >
>> >> > sid:~# sestatus
>> >> > SELinux status:                 enabled
>> >> > SELinuxfs mount:                /selinux
>> >> > Current mode:                   permissive
>> >> > Mode from config file:          enforcing
>> >> > Policy version:                 23
>> >> > Policy from config file:        default
>> >> >
>> >> > sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart
>> >> >
>> >> > sid:~# ps -H -Z -C sshd
>> >> > LABEL                             PID TTY          TIME CMD
>> >> > sysadm_u:sysadm_r:sysadm_t:s0    1944 ?        00:00:00 sshd
>> >> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd
>> >> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00   sshd
>> >> >
>> >> > That is the new parent process sshd running with
>> >> > sysadm_u:sysadm_r:sysadm_t:s0.
>> >> >
>> >> > zito@bobek:~$ ssh sid
>> >> > Read from remote host sid: Connection reset by peer
>> >> > Connection to sid closed.
>> >> >
>> >> > sid:~# tail -2 /var/log/syslog
>> >> > Sep 11 14:32:18 sid kernel: [  649.880210] sshd[1954]: segfault at 2
>> >> > ip
>> >> > b7ad5cea sp bfc2b04c error 4 in libc-2.7.so[b7a60000+155000]
>> >> > Sep 11 14:32:18 sid kernel: [  649.883080] type=1701
>> >> > audit(1221136338.451:27): auid=4294967295 uid=1000 gid=1000
>> >> > ses=4294967295
>> >> > subj=sysadm_u:sysadm_r:sysadm_t:s0 pid=1954 comm="sshd" sig=11
>> >> >
>> >> >
>> >> > This is mature for bug report on openssh.
>> >> > Conclusion: Running SE Linux in permissive mode can't prevent you
>> >> > from
>> >> > all SE Linux problems every time! (in most cases yes of course :)
>> >> >
>> >> > --
>> >> > Zito
>> >> >
>> >>
>> >> appologize for the latency with getting back to you;
>> >> you might have the ssh version from sid, if so
>> >> do /etc/init.d/ssh stop and start if you notice [fail] then thats the
>> >> issue,
>> >> esspecially if people are booting up and not even manually starting the
>> >> daemon.
>> >> As for the policy and ssh I'm in the process of
>> >> having two machines in full enforcing mode, having the ability
>> >> to do a ssh transaction(need to configure some things); As well
>> >> as vncviewer, and shoutcast; all with ipsec. (AH and ESP)
>> >> right now I've been able to run all three applications on the machine
>> >> that is in full enforcement, but it seems im having issues with ipsec
>> >> and shoutcast.
>> >> on the server side.
>> >> I'll get back to you on this.
>> >>
>> >> --
>> >> Justin P. Mattock
>> >
>> >
>>
>> Cool ssh works for you now. As for rc.d
>> you can try and do: make enableaudit
>> to see if there is some missing avc's, and also relabel
>> the filesystem in case rc.d was labeled wrong
>>
>> --
>> Justin P. Mattock
>
>

Hmm, this is interesting, depending on what system you're using, you might
be facing somthing similar to what I was facing a few months ago with
powersaved i.g.
after allowing this daemon to move freely withing the policy,
I still was unable to set the power levels, or change from ondemand
module to the
powersave module with cpufrequencies(no avc's at all).
a simple downgrade resolvedthe issue(the main issue I think was
liblazy or one of the libraries);
Something similar to what you are experiencingwere the policy and the
daemon some how can't
communicate, to create an avc's, so you can go about you're way. If
you can depending on what
daemon is denied, try setting up you're network very early in the boot process
either in /etc/init.d/alsa-tools or acpid(somwhere before you receive
the permissions
denied message), then onceyou receive the freeze or whatever, use
another machine to ssh
into the frozen machine to grab dmesg and other
logs, so you have a better idea with what is happening.
I have this in my /etc/rc.local (for instances like this);
(change router to no WEP or WPA);
iwconfig ath0 essid "***"
ifconfig ath0 up
dhclient
/etc/init.d/ssh start
then use another machine to gather info on the freeze.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
