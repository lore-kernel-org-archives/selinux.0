Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DI0Fmd013084
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 14:00:15 -0400
Received: by mail-wm0-f51.google.com with SMTP id u206so91419004wme.1
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 11:00:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 13 Apr 2016 19:00:10 +0100
Message-ID: <CADs1-60DRNHOU2-k93oOTRRmYk4YtXP=af6cRhsK=Kwd+_t_3A@mail.gmail.com>
Subject: Failure in sel_netport_sid_slow()
From: Greg <gkubok@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e01227f4276462a0530618c54
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e01227f4276462a0530618c54
Content-Type: text/plain; charset=UTF-8

Hi SELinux developers,

I'm seeing "kernel: SELinux: failure in sel_netport_sid_slow(), unable to
determine network port label" under certain conditions.

OS -

Linux test33 3.10.0-327.13.1.el7.x86_64 #1 SMP Thu Mar 31 16:04:38 UTC 2016
x86_64 x86_64 x86_64 GNU/Linux
CentOS Linux release 7.2.1511 (Core)

Versions -

libselinux-2.2.2-6.el7.x86_64
libselinux-devel-2.2.2-6.el7.x86_64
libselinux-python-2.2.2-6.el7.x86_64
libselinux-utils-2.2.2-6.el7.x86_64
libsemanage-2.1.10-18.el7.x86_64
libsemanage-python-2.1.10-18.el7.x86_64
libsepol-2.1.9-3.el7.x86_64
libsepol-devel-2.1.9-3.el7.x86_64
selinux-policy-3.13.1-60.el7_2.3.noarch
selinux-policy-targeted-3.13.1-60.el7_2.3.noarch

SE Status -

SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      28

Scenario -

I run two Ansible roles, one deploys JupyterHub (a simple python+node app)
which binds to some ports, and another immediately after (same Ansible
playbook) that deploys Apache HTTPd (acting as reverse proxy for
JupyterHub).

The JupyterHub role starts the JupyterHub app (a systemd unit) as its
_last_ task, and the reverse proxy role adjusts 2 SE booleans as its
_first_ task.

What happens is the 2 SE booleans get adjusted while JupyterHub is still
starting and trying to bind to its ports, which causes the SELinux error
shown above (and below in logs).

My current workaround is simply to wait at the end of my JupyterHub role
until it has fully bound to its ports and listening (just 2-3 seconds),
then continue with the reverse proxy role, but I wonder if there's a
potential problem / race condition in SELinux?


Here's the log:

-- Last task of Ansible JupyterHub role - which is to start its service
(ignore the 'Stopped', that's due to Ansible's state=restarted, but the app
is not running at this time, and has never run on this host) --

Apr 12 15:39:53 test33 ansible-<stdin>[14326]: Invoked with name=jupyterhub
pattern=None enabled=True state=restarted sleep=None arguments=
runlevel=default
Apr 12 15:39:53 test33 systemd[1]: Reloading.
Apr 12 15:39:53 test33 systemd[1]: Configuration file
/usr/lib/systemd/system/auditd.service is marked world-inaccessible. This
has no effect as configuration data is accessible via APIs without
restrictions. Proceeding anyway.
Apr 12 15:39:53 test33 systemd[1]: Stopped JupyterHub Service.
Apr 12 15:39:53 test33 systemd[1]: Started JupyterHub Service.
Apr 12 15:39:53 test33 systemd[1]: Starting JupyterHub Service...

-- Reverse proxy role comes in, setting 'httpd_can_network_connect' and
'httpd_can_network_relay' bools, but JupyterHub startup isn't done yet --

Apr 12 15:39:53 test33 ansible-<stdin>[14367]: Invoked with warn=True
executable=None chdir=None _raw_params=setsebool -P
httpd_can_network_connect 1 && setsebool -P httpd_can_network_relay 1
removes=None creates=None _uses_shell=True
Apr 12 15:39:54 test33 dbus[537]: avc:  received policyload notice (seqno=4)
Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: avc:  received
policyload notice (seqno=4)
Apr 12 15:39:54 test33 dbus[537]: [system] Reloaded configuration
Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
configuration
Apr 12 15:39:54 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
Apr 12 15:39:54 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
Apr 12 15:39:54 test33 kernel: SELinux:  8 users, 105 roles, 4965 types,
304 bools, 1 sens, 1024 cats
Apr 12 15:39:54 test33 kernel: SELinux:  83 classes, 105676 rules

-- JupyterHub continues with its startup, but cannot bind with an odd
memory error, and kernel reports SELinux network port label issue, which
I'm assuming is the cause of JupyterHub failing to bind --

Apr 12 15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.340
JupyterHub app:572] Writing cookie_secret to
/etc/jupyterhub/jupyterhub_cookie_secret
Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.426
JupyterHub app:292]
Apr 12 15:39:54 test33 jupyterhub[14352]: Generating
CONFIGPROXY_AUTH_TOKEN. Restarting the Hub will require restarting the
proxy.
Apr 12 15:39:54 test33 jupyterhub[14352]: Set CONFIGPROXY_AUTH_TOKEN env or
JupyterHub.proxy_auth_token config to avoid this message.
Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438
JupyterHub app:685] No admin users, admin interface will be unavailable.
Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438
JupyterHub app:686] Add any administrative users to
`c.Authenticator.admin_users` in config.
Apr 12 15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.438
JupyterHub app:712] Not using whitelist. Any authenticated user will be
allowed.
Apr 12 15:39:54 test33 kernel: SELinux: failure in sel_netport_sid_slow(),
unable to determine network port label
Apr 12 15:39:54 test33 jupyterhub[14352]: [E 2016-04-12 15:39:54.452
JupyterHub app:1110] Failed to bind hub to http://127.0.0.1:8081/hub/
Apr 12 15:39:54 test33 jupyterhub[14352]: [E 2016-04-12 15:39:54.452
JupyterHub app:1178]
Apr 12 15:39:54 test33 jupyterhub[14352]: Traceback (most recent call last):
Apr 12 15:39:54 test33 jupyterhub[14352]: File
"/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.py", line
1176, in launch_instance_async
Apr 12 15:39:54 test33 jupyterhub[14352]: yield self.start()
Apr 12 15:39:54 test33 jupyterhub[14352]: File
"/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.py", line
1108, in start
Apr 12 15:39:54 test33 jupyterhub[14352]:
self.http_server.listen(self.hub_port, address=self.hub_ip)
Apr 12 15:39:54 test33 jupyterhub[14352]: File
"/usr/local/anaconda3/lib/python3.5/site-packages/tornado/tcpserver.py",
line 126, in listen
Apr 12 15:39:54 test33 jupyterhub[14352]: sockets = bind_sockets(port,
address=address)
Apr 12 15:39:54 test33 jupyterhub[14352]: File
"/usr/local/anaconda3/lib/python3.5/site-packages/tornado/netutil.py", line
196, in bind_sockets
Apr 12 15:39:54 test33 jupyterhub[14352]: sock.bind(sockaddr)
Apr 12 15:39:54 test33 jupyterhub[14352]: OSError: [Errno 12] Cannot
allocate memory
Apr 12 15:39:54 test33 systemd[1]: jupyterhub.service: main process exited,
code=exited, status=1/FAILURE
Apr 12 15:39:54 test33 systemd[1]: Unit jupyterhub.service entered failed
state.
Apr 12 15:39:54 test33 systemd[1]: jupyterhub.service failed.

-- The 2 SE bools are set, not sure why there appears to be a reload every
time and whether that's standard --

Apr 12 15:39:54 test33 dbus[537]: avc:  received policyload notice (seqno=5)
Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: avc:  received
policyload notice (seqno=5)
Apr 12 15:39:54 test33 dbus[537]: [system] Reloaded configuration
Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
configuration
Apr 12 15:39:55 test33 setsebool[14369]: The httpd_can_network_connect
policy boolean was changed to 1 by root
Apr 12 15:39:55 test33 dbus[537]: avc:  received policyload notice (seqno=6)
Apr 12 15:39:55 test33 dbus-daemon[537]: dbus[537]: avc:  received
policyload notice (seqno=6)
Apr 12 15:39:55 test33 dbus[537]: [system] Reloaded configuration
Apr 12 15:39:55 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
configuration
Apr 12 15:39:55 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
Apr 12 15:39:55 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
Apr 12 15:39:55 test33 kernel: SELinux:  8 users, 105 roles, 4965 types,
304 bools, 1 sens, 1024 cats
Apr 12 15:39:55 test33 kernel: SELinux:  83 classes, 105676 rules
Apr 12 15:39:56 test33 dbus[537]: avc:  received policyload notice (seqno=7)
Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[537]: avc:  received
policyload notice (seqno=7)
Apr 12 15:39:56 test33 dbus[537]: [system] Reloaded configuration
Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
configuration
Apr 12 15:39:56 test33 setsebool[14379]: The httpd_can_network_relay policy
boolean was changed to 1 by root


As mentioned above, if I let JupyterHub fully bind to its ports before
'setsebool' is issued in the follow-up Ansible role, everything works
absolutely fine, including restarting JupyterHub, and it works after
rebooting etc, all healthy and normal and no SELinux errors.

Also, there are no policy violations of any kind when JupyterHub fails to
bind, all looks clean except the kernel message in the log an ultimate
failure to run:

# ausearch -m avc
<no matches>

Thanks,

Greg Kubok.

--089e01227f4276462a0530618c54
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"monospace, monospace">Hi SELinux developers,=
<br><br>I&#39;m seeing &quot;kernel: SELinux: failure in sel_netport_sid_sl=
ow(), unable to determine network port label&quot; under certain conditions=
.<br><br>OS -</font><div><font face=3D"monospace, monospace"><br>Linux test=
33 3.10.0-327.13.1.el7.x86_64 #1 SMP Thu Mar 31 16:04:38 UTC 2016 x86_64 x8=
6_64 x86_64 GNU/Linux<br>CentOS Linux release 7.2.1511 (Core)<br><br>Versio=
ns -</font></div><div><font face=3D"monospace, monospace"><br>libselinux-2.=
2.2-6.el7.x86_64<br>libselinux-devel-2.2.2-6.el7.x86_64<br>libselinux-pytho=
n-2.2.2-6.el7.x86_64<br>libselinux-utils-2.2.2-6.el7.x86_64<br>libsemanage-=
2.1.10-18.el7.x86_64<br>libsemanage-python-2.1.10-18.el7.x86_64<br>libsepol=
-2.1.9-3.el7.x86_64<br>libsepol-devel-2.1.9-3.el7.x86_64<br>selinux-policy-=
3.13.1-60.el7_2.3.noarch<br>selinux-policy-targeted-3.13.1-60.el7_2.3.noarc=
h</font></div><div><font face=3D"monospace, monospace"><br></font></div><di=
v><font face=3D"monospace, monospace">SE Status -</font></div><div><font fa=
ce=3D"monospace, monospace"><br></font></div><div><font face=3D"monospace, =
monospace"><div>SELinux status: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 enabled</div><div>SELinuxfs mount: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/fs/selinux</div><div>SELinux root direc=
tory: =C2=A0 =C2=A0 =C2=A0 =C2=A0 /etc/selinux</div><div>Loaded policy name=
: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targeted</div><div>Current mode=
: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enforcing<=
/div><div>Mode from config file: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enforcin=
g</div><div>Policy MLS status: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0enabled</div><div>Policy deny_unknown status: =C2=A0 =C2=A0 allowed</=
div><div>Max kernel policy version: =C2=A0 =C2=A0 =C2=A028</div><br>Scenari=
o -<br><br>I run two Ansible roles, one deploys JupyterHub (a simple python=
+node app) which binds to some ports, and another immediately after (same A=
nsible playbook) that deploys Apache HTTPd (acting as reverse proxy for Jup=
yterHub).<br><br>The JupyterHub role starts the JupyterHub app (a systemd u=
nit) as its _last_ task, and the reverse proxy role adjusts 2 SE booleans a=
s its _first_ task.<br><br>What happens is the 2 SE booleans get adjusted w=
hile JupyterHub is still starting and trying to bind to its ports, which ca=
uses the SELinux error shown above (and below in logs).<br><br>My current w=
orkaround is simply to wait at the end of my JupyterHub role until it has f=
ully bound to its ports and listening (just 2-3 seconds), then continue wit=
h the reverse proxy role, but I wonder if there&#39;s a potential problem /=
 race condition in SELinux?<br><br><br>Here&#39;s the log:<br><br>-- Last t=
ask of Ansible JupyterHub role - which is to start its service (ignore the =
&#39;Stopped&#39;, that&#39;s due to Ansible&#39;s state=3Drestarted, but t=
he app is not running at this time, and has never run on this host) --<br><=
br>Apr 12 15:39:53 test33 ansible-&lt;stdin&gt;[14326]: Invoked with name=
=3Djupyterhub pattern=3DNone enabled=3DTrue state=3Drestarted sleep=3DNone =
arguments=3D runlevel=3Ddefault<br>Apr 12 15:39:53 test33 systemd[1]: Reloa=
ding.<br>Apr 12 15:39:53 test33 systemd[1]: Configuration file /usr/lib/sys=
temd/system/auditd.service is marked world-inaccessible. This has no effect=
 as configuration data is accessible via APIs without restrictions. Proceed=
ing anyway.<br>Apr 12 15:39:53 test33 systemd[1]: Stopped JupyterHub Servic=
e.<br>Apr 12 15:39:53 test33 systemd[1]: Started JupyterHub Service.<br>Apr=
 12 15:39:53 test33 systemd[1]: Starting JupyterHub Service...<br><br>-- Re=
verse proxy role comes in, setting &#39;httpd_can_network_connect&#39; and =
&#39;httpd_can_network_relay&#39; bools, but JupyterHub startup isn&#39;t d=
one yet --<br><br>Apr 12 15:39:53 test33 ansible-&lt;stdin&gt;[14367]: Invo=
ked with warn=3DTrue executable=3DNone chdir=3DNone _raw_params=3Dsetsebool=
 -P httpd_can_network_connect 1 &amp;&amp; setsebool -P httpd_can_network_r=
elay 1 removes=3DNone creates=3DNone _uses_shell=3DTrue<br>Apr 12 15:39:54 =
test33 dbus[537]: avc: =C2=A0received policyload notice (seqno=3D4)<br>Apr =
12 15:39:54 test33 dbus-daemon[537]: dbus[537]: avc: =C2=A0received policyl=
oad notice (seqno=3D4)<br>Apr 12 15:39:54 test33 dbus[537]: [system] Reload=
ed configuration<br>Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [sy=
stem] Reloaded configuration<br>Apr 12 15:39:54 test33 kernel: SELinux: 204=
8 avtab hash slots, 105676 rules.<br>Apr 12 15:39:54 test33 kernel: SELinux=
: 2048 avtab hash slots, 105676 rules.<br>Apr 12 15:39:54 test33 kernel: SE=
Linux: =C2=A08 users, 105 roles, 4965 types, 304 bools, 1 sens, 1024 cats<b=
r>Apr 12 15:39:54 test33 kernel: SELinux: =C2=A083 classes, 105676 rules<br=
><br>-- JupyterHub continues with its startup, but cannot bind with an odd =
memory error, and kernel reports SELinux network port label issue, which I&=
#39;m assuming is the cause of JupyterHub failing to bind --<br><br>Apr 12 =
15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.340 JupyterHub ap=
p:572] Writing cookie_secret to /etc/jupyterhub/jupyterhub_cookie_secret<br=
>Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.426 Jupyt=
erHub app:292]<br>Apr 12 15:39:54 test33 jupyterhub[14352]: Generating CONF=
IGPROXY_AUTH_TOKEN. Restarting the Hub will require restarting the proxy.<b=
r>Apr 12 15:39:54 test33 jupyterhub[14352]: Set CONFIGPROXY_AUTH_TOKEN env =
or JupyterHub.proxy_auth_token config to avoid this message.<br>Apr 12 15:3=
9:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438 JupyterHub app:68=
5] No admin users, admin interface will be unavailable.<br>Apr 12 15:39:54 =
test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438 JupyterHub app:686] Ad=
d any administrative users to `c.Authenticator.admin_users` in config.<br>A=
pr 12 15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.438 Jupyter=
Hub app:712] Not using whitelist. Any authenticated user will be allowed.<b=
r>Apr 12 15:39:54 test33 kernel: SELinux: failure in sel_netport_sid_slow()=
, unable to determine network port label<br>Apr 12 15:39:54 test33 jupyterh=
ub[14352]: [E 2016-04-12 15:39:54.452 JupyterHub app:1110] Failed to bind h=
ub to <a href=3D"http://127.0.0.1:8081/hub/">http://127.0.0.1:8081/hub/</a>=
<br>Apr 12 15:39:54 test33 jupyterhub[14352]: [E 2016-04-12 15:39:54.452 Ju=
pyterHub app:1178]<br>Apr 12 15:39:54 test33 jupyterhub[14352]: Traceback (=
most recent call last):<br>Apr 12 15:39:54 test33 jupyterhub[14352]: File &=
quot;/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.py&quo=
t;, line 1176, in launch_instance_async<br>Apr 12 15:39:54 test33 jupyterhu=
b[14352]: yield self.start()<br>Apr 12 15:39:54 test33 jupyterhub[14352]: F=
ile &quot;/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.p=
y&quot;, line 1108, in start<br>Apr 12 15:39:54 test33 jupyterhub[14352]: s=
elf.http_server.listen(self.hub_port, address=3Dself.hub_ip)<br>Apr 12 15:3=
9:54 test33 jupyterhub[14352]: File &quot;/usr/local/anaconda3/lib/python3.=
5/site-packages/tornado/tcpserver.py&quot;, line 126, in listen<br>Apr 12 1=
5:39:54 test33 jupyterhub[14352]: sockets =3D bind_sockets(port, address=3D=
address)<br>Apr 12 15:39:54 test33 jupyterhub[14352]: File &quot;/usr/local=
/anaconda3/lib/python3.5/site-packages/tornado/netutil.py&quot;, line 196, =
in bind_sockets<br>Apr 12 15:39:54 test33 jupyterhub[14352]: sock.bind(sock=
addr)<br>Apr 12 15:39:54 test33 jupyterhub[14352]: OSError: [Errno 12] Cann=
ot allocate memory<br>Apr 12 15:39:54 test33 systemd[1]: jupyterhub.service=
: main process exited, code=3Dexited, status=3D1/FAILURE<br>Apr 12 15:39:54=
 test33 systemd[1]: Unit jupyterhub.service entered failed state.<br>Apr 12=
 15:39:54 test33 systemd[1]: jupyterhub.service failed.<br><br>-- The 2 SE =
bools are set, not sure why there appears to be a reload every time and whe=
ther that&#39;s standard --<br><br>Apr 12 15:39:54 test33 dbus[537]: avc: =
=C2=A0received policyload notice (seqno=3D5)<br>Apr 12 15:39:54 test33 dbus=
-daemon[537]: dbus[537]: avc: =C2=A0received policyload notice (seqno=3D5)<=
br>Apr 12 15:39:54 test33 dbus[537]: [system] Reloaded configuration<br>Apr=
 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded configur=
ation<br>Apr 12 15:39:55 test33 setsebool[14369]: The httpd_can_network_con=
nect policy boolean was changed to 1 by root<br>Apr 12 15:39:55 test33 dbus=
[537]: avc: =C2=A0received policyload notice (seqno=3D6)<br>Apr 12 15:39:55=
 test33 dbus-daemon[537]: dbus[537]: avc: =C2=A0received policyload notice =
(seqno=3D6)<br>Apr 12 15:39:55 test33 dbus[537]: [system] Reloaded configur=
ation<br>Apr 12 15:39:55 test33 dbus-daemon[537]: dbus[537]: [system] Reloa=
ded configuration<br>Apr 12 15:39:55 test33 kernel: SELinux: 2048 avtab has=
h slots, 105676 rules.<br>Apr 12 15:39:55 test33 kernel: SELinux: 2048 avta=
b hash slots, 105676 rules.<br>Apr 12 15:39:55 test33 kernel: SELinux: =C2=
=A08 users, 105 roles, 4965 types, 304 bools, 1 sens, 1024 cats<br>Apr 12 1=
5:39:55 test33 kernel: SELinux: =C2=A083 classes, 105676 rules<br>Apr 12 15=
:39:56 test33 dbus[537]: avc: =C2=A0received policyload notice (seqno=3D7)<=
br>Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[537]: avc: =C2=A0received =
policyload notice (seqno=3D7)<br>Apr 12 15:39:56 test33 dbus[537]: [system]=
 Reloaded configuration<br>Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[53=
7]: [system] Reloaded configuration<br>Apr 12 15:39:56 test33 setsebool[143=
79]: The httpd_can_network_relay policy boolean was changed to 1 by root<br=
><br><br>As mentioned above, if I let JupyterHub fully bind to its ports be=
fore &#39;setsebool&#39; is issued in the follow-up Ansible role, everythin=
g works absolutely fine, including restarting JupyterHub, and it works afte=
r rebooting etc, all healthy and normal and no SELinux errors.</font></div>=
<div><font face=3D"monospace, monospace"><br></font></div><div><font face=
=3D"monospace, monospace">Also, there are no policy violations of any kind =
when JupyterHub fails to bind, all looks clean except the kernel message in=
 the log an ultimate failure to run:</font></div><div><font face=3D"monospa=
ce, monospace"><br></font></div><div><span style=3D"font-family:monospace,m=
onospace"># ausearch -m avc</span><br></div><div><font face=3D"monospace, m=
onospace"><div>&lt;no matches&gt;</div><br>Thanks,<br><br>Greg Kubok.</font=
><br></div></div>

--089e01227f4276462a0530618c54--
