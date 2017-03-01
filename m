Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21NSBSw018817
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 18:28:12 -0500
Received: by mail-oi0-f67.google.com with SMTP id 2so4199964oif.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 15:28:10 -0800 (PST)
Subject: Re: SELinux type transition rule not working
To: cgzones <cgzones@googlemail.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>,
 selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <4ed435ac-9344-02a5-23be-4312500e2085@gmail.com>
Date: Wed, 1 Mar 2017 17:28:07 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/01/2017 04:28 PM, cgzones wrote:
> Can you try a transition from initrc_t or the interface

I've added a rule for initrc_t (although I'm 99% sure that is no longer
used under systemd):

   type_transition init_t var_run_t : dir squoxy_var_run_t "squoxy";
   type_transition initrc_t var_run_t : dir squoxy_var_run_t "squoxy";

No change in behavior.  The directory still ends up as var_run_t.

> init_daemon_pid_file()

I can't find any documentation of this interface, and it doesn't appear
to exist on Fedora 25 or CentOS 7.  Attempting to use it just gives me a
syntax error:

squoxy.te:17:ERROR 'syntax error' at token 'init_daemon_pid_file' on 
line 3513:
# PID file 

init_daemon_pid_file(squoxy_var_run_t, dir, "squoxy")

Here is the entire file:

policy_module(squoxy, 0.0.1)

require {
	type kernel_t;
	type devlog_t;
	type node_t;
};

type squoxy_t;
type squoxy_exec_t;
type squoxy_var_run_t;

init_daemon_domain(squoxy_t, squoxy_exec_t)
files_type(squoxy_var_run_t)

# PID file
init_daemon_pid_file(squoxy_var_run_t, dir, "squoxy")
allow squoxy_t squoxy_var_run_t:dir { search write add_name };
allow squoxy_t squoxy_var_run_t:file { create write open };

# Sockets
allow squoxy_t self:rawip_socket { create bind setopt ioctl read write };
allow squoxy_t node_t:rawip_socket { node_bind };
allow squoxy_t self:capability { net_raw };

# syslog
allow squoxy_t self:unix_dgram_socket { create connect write };
allow squoxy_t kernel_t:unix_dgram_socket { sendto };
allow squoxy_t devlog_t:sock_file { write };

Per Lennart's response, systemd *should* be honoring the file context
rules when creating the directory.  It's almost as if the directory is
being created with the proper context, but something is changing it
after the fact.  I have absolutely no idea what that might be, though.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
