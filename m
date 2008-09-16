Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GJJWuG020553
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 15:19:32 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GJJVls023576
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 19:19:32 GMT
Received: by rv-out-0708.google.com with SMTP id f25so2966859rvb.54
        for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:19:30 -0700 (PDT)
Message-ID: <f00ed96d0809161219p786e7cc3w3905c9f1dd8d8f8d@mail.gmail.com>
Date: Tue, 16 Sep 2008 15:19:29 -0400
From: Hong <kindloaf@gmail.com>
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: [refpolicy] ssh issue with latest policy
Cc: "=?ISO-8859-1?Q?V=E1clav_Ovs=EDk?=" <vaclav.ovsik@i.cz>,
        "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30809161138j5602356buc687c015891c960f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3835_35686.1221592769888"
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
	 <20080911125025.GA5448@bobek.pm.i.cz>
	 <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
	 <f00ed96d0809161119o6c726384h2a9fb19dc0364ebc@mail.gmail.com>
	 <dd18b0c30809161138j5602356buc687c015891c960f@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3835_35686.1221592769888
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Do you mean "make enableaudit" under the refpolicy source directory?  I did
this and the output is as follows:
.../refpolicy-0.0.20071214$ sudo make enableaudit
cat: /selinux/policyvers: No such file or directory
Removing dontaudit rules from policy.conf
egrep -v dontaudit policy.conf > tmp/policy.audit
mv tmp/policy.audit policy.conf

And I "sudo make relabel" under the refpolicy source directory to relabel
the file system.  (I already relabel the file system before).

And after reboot, the machine still cannot boot.  I found following entries
in /var/log/syslog after another reboot with kernel option enforcing=3D0:

Sep 16 15:07:27 hostname init: tty4 main process (4000) killed by TERM
signal
Sep 16 15:07:27 hostname init: tty5 main process (4001) killed by TERM
signal
Sep 16 15:07:27 hostname init: tty2 main process (4006) killed by TERM
signal
Sep 16 15:07:27 hostname init: tty3 main process (4008) killed by TERM
signal
Sep 16 15:07:27 hostname init: tty6 main process (4012) killed by TERM
signal
Sep 16 15:07:27 hostname init: tty1 main process (4314) killed by TERM
signal
Sep 16 15:07:27 hostname restorecond: terminated
Sep 16 15:07:29 hostname postfix/master[4214]: terminating on signal 15
Sep 16 15:07:31 hostname kernel: [ 3579.730352] ip6_tables: (C) 2000-2006
Netfilter Core
Sep 16 15:07:31 hostname exiting on signal 15

There is no entry in /var/log/messages for the unsuccessful reboot.

Does it show any clue of the problem?

Hong

On Tue, Sep 16, 2008 at 2:38 PM, Justin Mattock <justinmattock@gmail.com>wr=
ote:

> On Tue, Sep 16, 2008 at 11:19 AM, Hong <kindloaf@gmail.com> wrote:
> > I shutdown the sshd and restart it, now I can connect without problem.
> > (permissive mode).
> >
> > Thanks for the information!
> >
> > And I reboot the machine and switched to enforcing mode, the machine
> cannot
> > boot normally.  Looks like rcS doesn't work:
> > exec: 7: /etc/init.d/rcS: Permission denied
> > init: rcS main process (2335) terminated with status 2
> > init: rc-default main process (2337) terminated with status 1
> >
> > And then the machine just hung there.  I could not log in.
> >
> > ps: sorry for the delay.  I had some deadline last week...
> >
> > Hong
> >
> > On Thu, Sep 11, 2008 at 5:01 PM, Justin Mattock <justinmattock@gmail.co=
m
> >
> > wrote:
> >>
> >> On Thu, Sep 11, 2008 at 5:50 AM, V=E1clav Ovs=EDk <vaclav.ovsik@i.cz>
> wrote:
> >> > On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:
> >> >> Hong,
> >> >> I cant seem to locate the post you sent a few days ago
> >> >> about logging into ssh. anyways I finally got around to logging int=
o
> >> >> my machines with both the latest kernel and refpolicy;
> >> >> there was difficulty due to having /etc/host and /etc/sysctl.conf
> >> >> variables in these files preventing me from logging in.
> >> >> So with that in mind check and make sure those files
> >> >> are cleared of anything that might cause an error.
> >> >> As for the policy itself they were both in permissive mode
> >> >> via boot param, so having /etc/selinux/config in enforcing
> >> >> didnt cause an ubstruction for me.
> >> >> hope this helps.
> >> >
> >> > May be. And Hong not replied yet if he did relabel the file system. =
:)
> >> >
> >> > I have tried to restart sshd with nonsense context to show the probl=
em
> >> > even with PERMISSIVE mode of SE Linux!
> >> >
> >> > sid:~# sestatus
> >> > SELinux status:                 enabled
> >> > SELinuxfs mount:                /selinux
> >> > Current mode:                   permissive
> >> > Mode from config file:          enforcing
> >> > Policy version:                 23
> >> > Policy from config file:        default
> >> >
> >> > sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart
> >> >
> >> > sid:~# ps -H -Z -C sshd
> >> > LABEL                             PID TTY          TIME CMD
> >> > sysadm_u:sysadm_r:sysadm_t:s0    1944 ?        00:00:00 sshd
> >> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd
> >> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00   sshd
> >> >
> >> > That is the new parent process sshd running with
> >> > sysadm_u:sysadm_r:sysadm_t:s0.
> >> >
> >> > zito@bobek:~$ ssh sid
> >> > Read from remote host sid: Connection reset by peer
> >> > Connection to sid closed.
> >> >
> >> > sid:~# tail -2 /var/log/syslog
> >> > Sep 11 14:32:18 sid kernel: [  649.880210] sshd[1954]: segfault at 2
> ip
> >> > b7ad5cea sp bfc2b04c error 4 in libc-2.7.so[b7a60000+155000]
> >> > Sep 11 14:32:18 sid kernel: [  649.883080] type=3D1701
> >> > audit(1221136338.451:27): auid=3D4294967295 uid=3D1000 gid=3D1000
> ses=3D4294967295
> >> > subj=3Dsysadm_u:sysadm_r:sysadm_t:s0 pid=3D1954 comm=3D"sshd" sig=3D=
11
> >> >
> >> >
> >> > This is mature for bug report on openssh.
> >> > Conclusion: Running SE Linux in permissive mode can't prevent you fr=
om
> >> > all SE Linux problems every time! (in most cases yes of course :)
> >> >
> >> > --
> >> > Zito
> >> >
> >>
> >> appologize for the latency with getting back to you;
> >> you might have the ssh version from sid, if so
> >> do /etc/init.d/ssh stop and start if you notice [fail] then thats the
> >> issue,
> >> esspecially if people are booting up and not even manually starting th=
e
> >> daemon.
> >> As for the policy and ssh I'm in the process of
> >> having two machines in full enforcing mode, having the ability
> >> to do a ssh transaction(need to configure some things); As well
> >> as vncviewer, and shoutcast; all with ipsec. (AH and ESP)
> >> right now I've been able to run all three applications on the machine
> >> that is in full enforcement, but it seems im having issues with ipsec
> >> and shoutcast.
> >> on the server side.
> >> I'll get back to you on this.
> >>
> >> --
> >> Justin P. Mattock
> >
> >
>
> Cool ssh works for you now. As for rc.d
> you can try and do: make enableaudit
> to see if there is some missing avc's, and also relabel
> the filesystem in case rc.d was labeled wrong
>
> --
> Justin P. Mattock
>

------=_Part_3835_35686.1221592769888
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Do you mean &quot;make enableaudit&quot; under the refpoli=
cy source directory?&nbsp; I did this and the output is as follows:<br>.../=
refpolicy-0.0.20071214$ sudo make enableaudit<br>cat: /selinux/policyvers: =
No such file or directory<br>
Removing dontaudit rules from policy.conf<br>egrep -v dontaudit policy.conf=
 &gt; tmp/policy.audit<br>mv tmp/policy.audit policy.conf<br><br>And I &quo=
t;sudo make relabel&quot; under the refpolicy source directory to relabel t=
he file system.&nbsp; (I already relabel the file system before).<br>
<br>And after reboot, the machine still cannot boot.&nbsp; I found followin=
g entries in /var/log/syslog after another reboot with kernel option enforc=
ing=3D0:<br><br>Sep 16 15:07:27 hostname init: tty4 main process (4000) kil=
led by TERM signal<br>
Sep 16 15:07:27 hostname init: tty5 main process (4001) killed by TERM sign=
al<br>Sep 16 15:07:27 hostname init: tty2 main process (4006) killed by TER=
M signal<br>Sep 16 15:07:27 hostname init: tty3 main process (4008) killed =
by TERM signal<br>
Sep 16 15:07:27 hostname init: tty6 main process (4012) killed by TERM sign=
al<br>Sep 16 15:07:27 hostname init: tty1 main process (4314) killed by TER=
M signal<br>Sep 16 15:07:27 hostname restorecond: terminated<br>Sep 16 15:0=
7:29 hostname postfix/master[4214]: terminating on signal 15<br>
Sep 16 15:07:31 hostname kernel: [ 3579.730352] ip6_tables: (C) 2000-2006 N=
etfilter Core<br>Sep 16 15:07:31 hostname exiting on signal 15<br><br>There=
 is no entry in /var/log/messages for the unsuccessful reboot.<br><br>Does =
it show any clue of the problem?<br>
<br>Hong<br><br><div class=3D"gmail_quote">On Tue, Sep 16, 2008 at 2:38 PM,=
 Justin Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinmattock@gmail=
.com">justinmattock@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">On Tue, Sep 16, 2008 at 11:19 AM, Hon=
g &lt;<a href=3D"mailto:kindloaf@gmail.com">kindloaf@gmail.com</a>&gt; wrot=
e:<br>
&gt; I shutdown the sshd and restart it, now I can connect without problem.=
<br>
&gt; (permissive mode).<br>
&gt;<br>
&gt; Thanks for the information!<br>
&gt;<br>
&gt; And I reboot the machine and switched to enforcing mode, the machine c=
annot<br>
&gt; boot normally. &nbsp;Looks like rcS doesn&#39;t work:<br>
&gt; exec: 7: /etc/init.d/rcS: Permission denied<br>
&gt; init: rcS main process (2335) terminated with status 2<br>
&gt; init: rc-default main process (2337) terminated with status 1<br>
&gt;<br>
&gt; And then the machine just hung there. &nbsp;I could not log in.<br>
&gt;<br>
&gt; ps: sorry for the delay. &nbsp;I had some deadline last week...<br>
&gt;<br>
&gt; Hong<br>
&gt;<br>
&gt; On Thu, Sep 11, 2008 at 5:01 PM, Justin Mattock &lt;<a href=3D"mailto:=
justinmattock@gmail.com">justinmattock@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Sep 11, 2008 at 5:50 AM, V=E1clav Ovs=EDk &lt;<a href=3D"m=
ailto:vaclav.ovsik@i.cz">vaclav.ovsik@i.cz</a>&gt; wrote:<br>
&gt;&gt; &gt; On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrot=
e:<br>
&gt;&gt; &gt;&gt; Hong,<br>
&gt;&gt; &gt;&gt; I cant seem to locate the post you sent a few days ago<br=
>
&gt;&gt; &gt;&gt; about logging into ssh. anyways I finally got around to l=
ogging into<br>
&gt;&gt; &gt;&gt; my machines with both the latest kernel and refpolicy;<br=
>
&gt;&gt; &gt;&gt; there was difficulty due to having /etc/host and /etc/sys=
ctl.conf<br>
&gt;&gt; &gt;&gt; variables in these files preventing me from logging in.<b=
r>
&gt;&gt; &gt;&gt; So with that in mind check and make sure those files<br>
&gt;&gt; &gt;&gt; are cleared of anything that might cause an error.<br>
&gt;&gt; &gt;&gt; As for the policy itself they were both in permissive mod=
e<br>
&gt;&gt; &gt;&gt; via boot param, so having /etc/selinux/config in enforcin=
g<br>
&gt;&gt; &gt;&gt; didnt cause an ubstruction for me.<br>
&gt;&gt; &gt;&gt; hope this helps.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; May be. And Hong not replied yet if he did relabel the file s=
ystem. :)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have tried to restart sshd with nonsense context to show th=
e problem<br>
&gt;&gt; &gt; even with PERMISSIVE mode of SE Linux!<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; sid:~# sestatus<br>
&gt;&gt; &gt; SELinux status: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; enabled<br>
&gt;&gt; &gt; SELinuxfs mount: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;/selinux<br>
&gt;&gt; &gt; Current mode: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; permissive<br>
&gt;&gt; &gt; Mode from config file: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enfo=
rcing<br>
&gt;&gt; &gt; Policy version: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; 23<br>
&gt;&gt; &gt; Policy from config file: &nbsp; &nbsp; &nbsp; &nbsp;default<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh r=
estart<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; sid:~# ps -H -Z -C sshd<br>
&gt;&gt; &gt; LABEL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PID TTY &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;TIME CMD<br>
&gt;&gt; &gt; sysadm_u:sysadm_r:sysadm_t:s0 &nbsp; &nbsp;1944 ? &nbsp; &nbs=
p; &nbsp; &nbsp;00:00:00 sshd<br>
&gt;&gt; &gt; system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd<=
br>
&gt;&gt; &gt; system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00 &nbsp=
; sshd<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; That is the new parent process sshd running with<br>
&gt;&gt; &gt; sysadm_u:sysadm_r:sysadm_t:s0.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; zito@bobek:~$ ssh sid<br>
&gt;&gt; &gt; Read from remote host sid: Connection reset by peer<br>
&gt;&gt; &gt; Connection to sid closed.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; sid:~# tail -2 /var/log/syslog<br>
&gt;&gt; &gt; Sep 11 14:32:18 sid kernel: [ &nbsp;649.880210] sshd[1954]: s=
egfault at 2 ip<br>
&gt;&gt; &gt; b7ad5cea sp bfc2b04c error 4 in <a href=3D"http://libc-2.7.so=
" target=3D"_blank">libc-2.7.so</a>[b7a60000+155000]<br>
&gt;&gt; &gt; Sep 11 14:32:18 sid kernel: [ &nbsp;649.883080] type=3D1701<b=
r>
&gt;&gt; &gt; audit(1221136338.451:27): auid=3D4294967295 uid=3D1000 gid=3D=
1000 ses=3D4294967295<br>
&gt;&gt; &gt; subj=3Dsysadm_u:sysadm_r:sysadm_t:s0 pid=3D1954 comm=3D&quot;=
sshd&quot; sig=3D11<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is mature for bug report on openssh.<br>
&gt;&gt; &gt; Conclusion: Running SE Linux in permissive mode can&#39;t pre=
vent you from<br>
&gt;&gt; &gt; all SE Linux problems every time! (in most cases yes of cours=
e :)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Zito<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; appologize for the latency with getting back to you;<br>
&gt;&gt; you might have the ssh version from sid, if so<br>
&gt;&gt; do /etc/init.d/ssh stop and start if you notice [fail] then thats =
the<br>
&gt;&gt; issue,<br>
&gt;&gt; esspecially if people are booting up and not even manually startin=
g the<br>
&gt;&gt; daemon.<br>
&gt;&gt; As for the policy and ssh I&#39;m in the process of<br>
&gt;&gt; having two machines in full enforcing mode, having the ability<br>
&gt;&gt; to do a ssh transaction(need to configure some things); As well<br=
>
&gt;&gt; as vncviewer, and shoutcast; all with ipsec. (AH and ESP)<br>
&gt;&gt; right now I&#39;ve been able to run all three applications on the =
machine<br>
&gt;&gt; that is in full enforcement, but it seems im having issues with ip=
sec<br>
&gt;&gt; and shoutcast.<br>
&gt;&gt; on the server side.<br>
&gt;&gt; I&#39;ll get back to you on this.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Justin P. Mattock<br>
&gt;<br>
&gt;<br>
<br>
</div></div>Cool ssh works for you now. As for rc.d<br>
you can try and do: make enableaudit<br>
to see if there is some missing avc&#39;s, and also relabel<br>
the filesystem in case rc.d was labeled wrong<br>
<font color=3D"#888888"><br>
--<br>
Justin P. Mattock<br>
</font></blockquote></div><br></div>

------=_Part_3835_35686.1221592769888--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
