Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v222GkaP030458
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 21:16:46 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux type transition rule not working
Date: Thu, 2 Mar 2017 13:16:39 +1100
Cc: Ian Pilcher <arequipeno@gmail.com>,
 Systemd <systemd-devel@lists.freedesktop.org>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
In-Reply-To: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201703021316.39263.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2 Mar 2017 08:40:49 AM Ian Pilcher wrote:
> I am using systemd's RuntimeDirectory to create a directory for a
> service.
> 
>     RuntimeDirectory=squoxy
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

If restorecon gives the correct context and systemd-tmpfiles does too 
(according to one of your later messages) then this is a bug in systemd.

It's probably best to raise it in the systemd bug tracker.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
