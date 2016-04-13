Subject: Re: Failure in sel_netport_sid_slow()
To: Greg <gkubok@gmail.com>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
References: <CADs1-60DRNHOU2-k93oOTRRmYk4YtXP=af6cRhsK=Kwd+_t_3A@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <570E99A8.5000101@tycho.nsa.gov>
Date: Wed, 13 Apr 2016 15:10:32 -0400
MIME-Version: 1.0
In-Reply-To: <CADs1-60DRNHOU2-k93oOTRRmYk4YtXP=af6cRhsK=Kwd+_t_3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/13/2016 02:00 PM, Greg wrote:
> Hi SELinux developers,
> 
> I'm seeing "kernel: SELinux: failure in sel_netport_sid_slow(), unable
> to determine network port label" under certain conditions.
> 
> OS -
> 
> Linux test33 3.10.0-327.13.1.el7.x86_64 #1 SMP Thu Mar 31 16:04:38 UTC
> 2016 x86_64 x86_64 x86_64 GNU/Linux
> CentOS Linux release 7.2.1511 (Core)
> 
> Versions -
> 
> libselinux-2.2.2-6.el7.x86_64
> libselinux-devel-2.2.2-6.el7.x86_64
> libselinux-python-2.2.2-6.el7.x86_64
> libselinux-utils-2.2.2-6.el7.x86_64
> libsemanage-2.1.10-18.el7.x86_64
> libsemanage-python-2.1.10-18.el7.x86_64
> libsepol-2.1.9-3.el7.x86_64
> libsepol-devel-2.1.9-3.el7.x86_64
> selinux-policy-3.13.1-60.el7_2.3.noarch
> selinux-policy-targeted-3.13.1-60.el7_2.3.noarch
> 
> SE Status -
> 
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy MLS status:              enabled
> Policy deny_unknown status:     allowed
> Max kernel policy version:      28
> 
> Scenario -
> 
> I run two Ansible roles, one deploys JupyterHub (a simple python+node
> app) which binds to some ports, and another immediately after (same
> Ansible playbook) that deploys Apache HTTPd (acting as reverse proxy for
> JupyterHub).
> 
> The JupyterHub role starts the JupyterHub app (a systemd unit) as its
> _last_ task, and the reverse proxy role adjusts 2 SE booleans as its
> _first_ task.
> 
> What happens is the 2 SE booleans get adjusted while JupyterHub is still
> starting and trying to bind to its ports, which causes the SELinux error
> shown above (and below in logs).
> 
> My current workaround is simply to wait at the end of my JupyterHub role
> until it has fully bound to its ports and listening (just 2-3 seconds),
> then continue with the reverse proxy role, but I wonder if there's a
> potential problem / race condition in SELinux?
> 
> 
> Here's the log:
> 
> -- Last task of Ansible JupyterHub role - which is to start its service
> (ignore the 'Stopped', that's due to Ansible's state=restarted, but the
> app is not running at this time, and has never run on this host) --
> 
> Apr 12 15:39:53 test33 ansible-<stdin>[14326]: Invoked with
> name=jupyterhub pattern=None enabled=True state=restarted sleep=None
> arguments= runlevel=default
> Apr 12 15:39:53 test33 systemd[1]: Reloading.
> Apr 12 15:39:53 test33 systemd[1]: Configuration file
> /usr/lib/systemd/system/auditd.service is marked world-inaccessible.
> This has no effect as configuration data is accessible via APIs without
> restrictions. Proceeding anyway.
> Apr 12 15:39:53 test33 systemd[1]: Stopped JupyterHub Service.
> Apr 12 15:39:53 test33 systemd[1]: Started JupyterHub Service.
> Apr 12 15:39:53 test33 systemd[1]: Starting JupyterHub Service...
> 
> -- Reverse proxy role comes in, setting 'httpd_can_network_connect' and
> 'httpd_can_network_relay' bools, but JupyterHub startup isn't done yet --
> 
> Apr 12 15:39:53 test33 ansible-<stdin>[14367]: Invoked with warn=True
> executable=None chdir=None _raw_params=setsebool -P
> httpd_can_network_connect 1 && setsebool -P httpd_can_network_relay 1
> removes=None creates=None _uses_shell=True
> Apr 12 15:39:54 test33 dbus[537]: avc:  received policyload notice (seqno=4)
> Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: avc:  received
> policyload notice (seqno=4)
> Apr 12 15:39:54 test33 dbus[537]: [system] Reloaded configuration
> Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
> configuration
> Apr 12 15:39:54 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
> Apr 12 15:39:54 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
> Apr 12 15:39:54 test33 kernel: SELinux:  8 users, 105 roles, 4965 types,
> 304 bools, 1 sens, 1024 cats
> Apr 12 15:39:54 test33 kernel: SELinux:  83 classes, 105676 rules
> 
> -- JupyterHub continues with its startup, but cannot bind with an odd
> memory error, and kernel reports SELinux network port label issue, which
> I'm assuming is the cause of JupyterHub failing to bind --
> 
> Apr 12 15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.340
> JupyterHub app:572] Writing cookie_secret to
> /etc/jupyterhub/jupyterhub_cookie_secret
> Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.426
> JupyterHub app:292]
> Apr 12 15:39:54 test33 jupyterhub[14352]: Generating
> CONFIGPROXY_AUTH_TOKEN. Restarting the Hub will require restarting the
> proxy.
> Apr 12 15:39:54 test33 jupyterhub[14352]: Set CONFIGPROXY_AUTH_TOKEN env
> or JupyterHub.proxy_auth_token config to avoid this message.
> Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438
> JupyterHub app:685] No admin users, admin interface will be unavailable.
> Apr 12 15:39:54 test33 jupyterhub[14352]: [W 2016-04-12 15:39:54.438
> JupyterHub app:686] Add any administrative users to
> `c.Authenticator.admin_users` in config.
> Apr 12 15:39:54 test33 jupyterhub[14352]: [I 2016-04-12 15:39:54.438
> JupyterHub app:712] Not using whitelist. Any authenticated user will be
> allowed.
> Apr 12 15:39:54 test33 kernel: SELinux: failure in
> sel_netport_sid_slow(), unable to determine network port label
> Apr 12 15:39:54 test33 jupyterhub[14352]: [E 2016-04-12 15:39:54.452
> JupyterHub app:1110] Failed to bind hub to http://127.0.0.1:8081/hub/
> Apr 12 15:39:54 test33 jupyterhub[14352]: [E 2016-04-12 15:39:54.452
> JupyterHub app:1178]
> Apr 12 15:39:54 test33 jupyterhub[14352]: Traceback (most recent call last):
> Apr 12 15:39:54 test33 jupyterhub[14352]: File
> "/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.py",
> line 1176, in launch_instance_async
> Apr 12 15:39:54 test33 jupyterhub[14352]: yield self.start()
> Apr 12 15:39:54 test33 jupyterhub[14352]: File
> "/usr/local/anaconda3/lib/python3.5/site-packages/jupyterhub/app.py",
> line 1108, in start
> Apr 12 15:39:54 test33 jupyterhub[14352]:
> self.http_server.listen(self.hub_port, address=self.hub_ip)
> Apr 12 15:39:54 test33 jupyterhub[14352]: File
> "/usr/local/anaconda3/lib/python3.5/site-packages/tornado/tcpserver.py",
> line 126, in listen
> Apr 12 15:39:54 test33 jupyterhub[14352]: sockets = bind_sockets(port,
> address=address)
> Apr 12 15:39:54 test33 jupyterhub[14352]: File
> "/usr/local/anaconda3/lib/python3.5/site-packages/tornado/netutil.py",
> line 196, in bind_sockets
> Apr 12 15:39:54 test33 jupyterhub[14352]: sock.bind(sockaddr)
> Apr 12 15:39:54 test33 jupyterhub[14352]: OSError: [Errno 12] Cannot
> allocate memory
> Apr 12 15:39:54 test33 systemd[1]: jupyterhub.service: main process
> exited, code=exited, status=1/FAILURE
> Apr 12 15:39:54 test33 systemd[1]: Unit jupyterhub.service entered
> failed state.
> Apr 12 15:39:54 test33 systemd[1]: jupyterhub.service failed.
> 
> -- The 2 SE bools are set, not sure why there appears to be a reload
> every time and whether that's standard --
> 
> Apr 12 15:39:54 test33 dbus[537]: avc:  received policyload notice (seqno=5)
> Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: avc:  received
> policyload notice (seqno=5)
> Apr 12 15:39:54 test33 dbus[537]: [system] Reloaded configuration
> Apr 12 15:39:54 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
> configuration
> Apr 12 15:39:55 test33 setsebool[14369]: The httpd_can_network_connect
> policy boolean was changed to 1 by root
> Apr 12 15:39:55 test33 dbus[537]: avc:  received policyload notice (seqno=6)
> Apr 12 15:39:55 test33 dbus-daemon[537]: dbus[537]: avc:  received
> policyload notice (seqno=6)
> Apr 12 15:39:55 test33 dbus[537]: [system] Reloaded configuration
> Apr 12 15:39:55 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
> configuration
> Apr 12 15:39:55 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
> Apr 12 15:39:55 test33 kernel: SELinux: 2048 avtab hash slots, 105676 rules.
> Apr 12 15:39:55 test33 kernel: SELinux:  8 users, 105 roles, 4965 types,
> 304 bools, 1 sens, 1024 cats
> Apr 12 15:39:55 test33 kernel: SELinux:  83 classes, 105676 rules
> Apr 12 15:39:56 test33 dbus[537]: avc:  received policyload notice (seqno=7)
> Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[537]: avc:  received
> policyload notice (seqno=7)
> Apr 12 15:39:56 test33 dbus[537]: [system] Reloaded configuration
> Apr 12 15:39:56 test33 dbus-daemon[537]: dbus[537]: [system] Reloaded
> configuration
> Apr 12 15:39:56 test33 setsebool[14379]: The httpd_can_network_relay
> policy boolean was changed to 1 by root
> 
> 
> As mentioned above, if I let JupyterHub fully bind to its ports before
> 'setsebool' is issued in the follow-up Ansible role, everything works
> absolutely fine, including restarting JupyterHub, and it works after
> rebooting etc, all healthy and normal and no SELinux errors.
> 
> Also, there are no policy violations of any kind when JupyterHub fails
> to bind, all looks clean except the kernel message in the log an
> ultimate failure to run:
> 
> # ausearch -m avc
> <no matches>

Thanks for the report.  Is your system under memory pressure?
That's the only situation where I could see sel_netport_sid_slow()
failing with ENOMEM.  The policyload notice is normal; on a boolean
change, the kernel triggers the same userspace notification as for a
policy reload so that userspace will flush its AVC.
