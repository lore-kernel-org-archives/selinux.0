Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GIJ8UA008942
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 14:19:08 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GIJ7ls006445
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 18:19:08 GMT
Received: by wf-out-1314.google.com with SMTP id 28so2810177wff.30
        for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 11:19:07 -0700 (PDT)
Message-ID: <f00ed96d0809161119o6c726384h2a9fb19dc0364ebc@mail.gmail.com>
Date: Tue, 16 Sep 2008 14:19:07 -0400
From: Hong <kindloaf@gmail.com>
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: [refpolicy] ssh issue with latest policy
Cc: "=?ISO-8859-1?Q?V=E1clav_Ovs=EDk?=" <vaclav.ovsik@i.cz>,
        "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3331_31840703.1221589147205"
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
	 <20080911125025.GA5448@bobek.pm.i.cz>
	 <dd18b0c30809111401h4575b1dcub226f6c4ab40a5bc@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3331_31840703.1221589147205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I shutdown the sshd and restart it, now I can connect without problem.
(permissive mode).

Thanks for the information!

And I reboot the machine and switched to enforcing mode, the machine cannot
boot normally.  Looks like rcS doesn't work:
exec: 7: /etc/init.d/rcS: Permission denied
init: rcS main process (2335) terminated with status 2
init: rc-default main process (2337) terminated with status 1

And then the machine just hung there.  I could not log in.

ps: sorry for the delay.  I had some deadline last week...

Hong

On Thu, Sep 11, 2008 at 5:01 PM, Justin Mattock <justinmattock@gmail.com>wr=
ote:

> On Thu, Sep 11, 2008 at 5:50 AM, V=E1clav Ovs=EDk <vaclav.ovsik@i.cz> wro=
te:
> > On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:
> >> Hong,
> >> I cant seem to locate the post you sent a few days ago
> >> about logging into ssh. anyways I finally got around to logging into
> >> my machines with both the latest kernel and refpolicy;
> >> there was difficulty due to having /etc/host and /etc/sysctl.conf
> >> variables in these files preventing me from logging in.
> >> So with that in mind check and make sure those files
> >> are cleared of anything that might cause an error.
> >> As for the policy itself they were both in permissive mode
> >> via boot param, so having /etc/selinux/config in enforcing
> >> didnt cause an ubstruction for me.
> >> hope this helps.
> >
> > May be. And Hong not replied yet if he did relabel the file system. :)
> >
> > I have tried to restart sshd with nonsense context to show the problem
> > even with PERMISSIVE mode of SE Linux!
> >
> > sid:~# sestatus
> > SELinux status:                 enabled
> > SELinuxfs mount:                /selinux
> > Current mode:                   permissive
> > Mode from config file:          enforcing
> > Policy version:                 23
> > Policy from config file:        default
> >
> > sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart
> >
> > sid:~# ps -H -Z -C sshd
> > LABEL                             PID TTY          TIME CMD
> > sysadm_u:sysadm_r:sysadm_t:s0    1944 ?        00:00:00 sshd
> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd
> > system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00   sshd
> >
> > That is the new parent process sshd running with
> sysadm_u:sysadm_r:sysadm_t:s0.
> >
> > zito@bobek:~$ ssh sid
> > Read from remote host sid: Connection reset by peer
> > Connection to sid closed.
> >
> > sid:~# tail -2 /var/log/syslog
> > Sep 11 14:32:18 sid kernel: [  649.880210] sshd[1954]: segfault at 2 ip
> b7ad5cea sp bfc2b04c error 4 in libc-2.7.so[b7a60000+155000]
> > Sep 11 14:32:18 sid kernel: [  649.883080] type=3D1701
> audit(1221136338.451:27): auid=3D4294967295 uid=3D1000 gid=3D1000 ses=3D4=
294967295
> subj=3Dsysadm_u:sysadm_r:sysadm_t:s0 pid=3D1954 comm=3D"sshd" sig=3D11
> >
> >
> > This is mature for bug report on openssh.
> > Conclusion: Running SE Linux in permissive mode can't prevent you from
> > all SE Linux problems every time! (in most cases yes of course :)
> >
> > --
> > Zito
> >
>
> appologize for the latency with getting back to you;
> you might have the ssh version from sid, if so
> do /etc/init.d/ssh stop and start if you notice [fail] then thats the
> issue,
> esspecially if people are booting up and not even manually starting the
> daemon.
> As for the policy and ssh I'm in the process of
> having two machines in full enforcing mode, having the ability
> to do a ssh transaction(need to configure some things); As well
> as vncviewer, and shoutcast; all with ipsec. (AH and ESP)
> right now I've been able to run all three applications on the machine
> that is in full enforcement, but it seems im having issues with ipsec
> and shoutcast.
> on the server side.
> I'll get back to you on this.
>
> --
> Justin P. Mattock
>

------=_Part_3331_31840703.1221589147205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">I shutdown the sshd and restart it, now I can connect with=
out problem. (permissive mode).<br><br>Thanks for the information!<br><br>A=
nd I reboot the machine and switched to enforcing mode, the machine cannot =
boot normally.&nbsp; Looks like rcS doesn&#39;t work:<br>
exec: 7: /etc/init.d/rcS: Permission denied<br>init: rcS main process (2335=
) terminated with status 2<br>init: rc-default main process (2337) terminat=
ed with status 1<br><br>And then the machine just hung there.&nbsp; I could=
 not log in.<br>
<br>ps: sorry for the delay.&nbsp; I had some deadline last week...<br><br>=
Hong<br><br><div class=3D"gmail_quote">On Thu, Sep 11, 2008 at 5:01 PM, Jus=
tin Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinmattock@gmail.com=
">justinmattock@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"Wj3C7c">On Thu, Sep 11, 2008 at 5:50 AM, V=E1clav Ovs=EDk &lt;=
<a href=3D"mailto:vaclav.ovsik@i.cz">vaclav.ovsik@i.cz</a>&gt; wrote:<br>

&gt; On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:<br>
&gt;&gt; Hong,<br>
&gt;&gt; I cant seem to locate the post you sent a few days ago<br>
&gt;&gt; about logging into ssh. anyways I finally got around to logging in=
to<br>
&gt;&gt; my machines with both the latest kernel and refpolicy;<br>
&gt;&gt; there was difficulty due to having /etc/host and /etc/sysctl.conf<=
br>
&gt;&gt; variables in these files preventing me from logging in.<br>
&gt;&gt; So with that in mind check and make sure those files<br>
&gt;&gt; are cleared of anything that might cause an error.<br>
&gt;&gt; As for the policy itself they were both in permissive mode<br>
&gt;&gt; via boot param, so having /etc/selinux/config in enforcing<br>
&gt;&gt; didnt cause an ubstruction for me.<br>
&gt;&gt; hope this helps.<br>
&gt;<br>
&gt; May be. And Hong not replied yet if he did relabel the file system. :)=
<br>
&gt;<br>
&gt; I have tried to restart sshd with nonsense context to show the problem=
<br>
&gt; even with PERMISSIVE mode of SE Linux!<br>
&gt;<br>
&gt; sid:~# sestatus<br>
&gt; SELinux status: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; enabled<br>
&gt; SELinuxfs mount: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;/selinux<br>
&gt; Current mode: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; permissive<br>
&gt; Mode from config file: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enforcing<br>
&gt; Policy version: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; 23<br>
&gt; Policy from config file: &nbsp; &nbsp; &nbsp; &nbsp;default<br>
&gt;<br>
&gt; sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart<br=
>
&gt;<br>
&gt; sid:~# ps -H -Z -C sshd<br>
&gt; LABEL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PID TTY &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;TIME CMD<br>
&gt; sysadm_u:sysadm_r:sysadm_t:s0 &nbsp; &nbsp;1944 ? &nbsp; &nbsp; &nbsp;=
 &nbsp;00:00:00 sshd<br>
&gt; system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd<br>
&gt; system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00 &nbsp; sshd<br=
>
&gt;<br>
&gt; That is the new parent process sshd running with sysadm_u:sysadm_r:sys=
adm_t:s0.<br>
&gt;<br>
&gt; zito@bobek:~$ ssh sid<br>
&gt; Read from remote host sid: Connection reset by peer<br>
&gt; Connection to sid closed.<br>
&gt;<br>
&gt; sid:~# tail -2 /var/log/syslog<br>
&gt; Sep 11 14:32:18 sid kernel: [ &nbsp;649.880210] sshd[1954]: segfault a=
t 2 ip b7ad5cea sp bfc2b04c error 4 in <a href=3D"http://libc-2.7.so" targe=
t=3D"_blank">libc-2.7.so</a>[b7a60000+155000]<br>
&gt; Sep 11 14:32:18 sid kernel: [ &nbsp;649.883080] type=3D1701 audit(1221=
136338.451:27): auid=3D4294967295 uid=3D1000 gid=3D1000 ses=3D4294967295 su=
bj=3Dsysadm_u:sysadm_r:sysadm_t:s0 pid=3D1954 comm=3D&quot;sshd&quot; sig=
=3D11<br>
&gt;<br>
&gt;<br>
&gt; This is mature for bug report on openssh.<br>
&gt; Conclusion: Running SE Linux in permissive mode can&#39;t prevent you =
from<br>
&gt; all SE Linux problems every time! (in most cases yes of course :)<br>
&gt;<br>
&gt; --<br>
&gt; Zito<br>
&gt;<br>
<br>
</div></div>appologize for the latency with getting back to you;<br>
you might have the ssh version from sid, if so<br>
do /etc/init.d/ssh stop and start if you notice [fail] then thats the issue=
,<br>
esspecially if people are booting up and not even manually starting the dae=
mon.<br>
As for the policy and ssh I&#39;m in the process of<br>
having two machines in full enforcing mode, having the ability<br>
to do a ssh transaction(need to configure some things); As well<br>
as vncviewer, and shoutcast; all with ipsec. (AH and ESP)<br>
right now I&#39;ve been able to run all three applications on the machine<b=
r>
that is in full enforcement, but it seems im having issues with ipsec<br>
and shoutcast.<br>
on the server side.<br>
I&#39;ll get back to you on this.<br>
<font color=3D"#888888"><br>
--<br>
Justin P. Mattock<br>
</font></blockquote></div><br></div>

------=_Part_3331_31840703.1221589147205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
