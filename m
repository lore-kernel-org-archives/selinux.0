Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21MPFHO001963
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 17:25:15 -0500
Date: Wed, 1 Mar 2017 23:25:11 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: selinux@tycho.nsa.gov, Systemd <systemd-devel@lists.freedesktop.org>
Subject: Re: [systemd-devel] SELinux type transition rule not working
Message-ID: <20170301222511.GA29059@gardel-login>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 01.03.17 15:40, Ian Pilcher (arequipeno@gmail.com) wrote:

> I am using systemd's RuntimeDirectory to create a directory for a
> service.
> 
>    RuntimeDirectory=squoxy
> 
> This causes systemd to create /run/squoxy before starting my service,
> but I haven't been able to get the SELinux context set correctly on the
> directory.
> 
> I've set file context rules for both /run/squoxy and /var/run/squoxy:
> 
> ^/var/run/squoxy(/.*)?  all files  system_u:object_r:squoxy_var_run_t:s0
> ^/run/squoxy(/.*)?      all files  system_u:object_r:squoxy_var_run_t:s0
> 
> And, indeed, restorecon will set the context of the directory to
> squoxy_var_run_t.
> 
> I've also added a type transition rule, attempting to get the correct
> context applied automatically when systemd creates the directory:
> 
> type_transition init_t var_run_t : dir squoxy_var_run_t "squoxy";
> 
> But the directory is still being created as var_run_t:
> 
> drwxr-xr-x. nobody nobody system_u:object_r:var_run_t:s0   /run/squoxy
> 
> What am I doing wrong?

Hmm, so the relevant code in systemd actually labels the dir after
creating it after an selinux database lookup, so from our side all
should be good:

https://github.com/systemd/systemd/blob/master/src/core/execute.c#L1857

(specifically, we all mkdir_p_label() instead of plain mkdir_p() there)

My own understanding of SELinux is finite however. I'd recommend
pinging the SELinux folks for help on this, 

Lennart

-- 
Lennart Poettering, Red Hat
