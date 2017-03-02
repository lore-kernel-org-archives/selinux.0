Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v22FEOnU008354
 for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2017 10:14:24 -0500
Date: Thu, 2 Mar 2017 10:13:48 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: Ian Pilcher <arequipeno@gmail.com>,
 Systemd <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov
Message-ID: <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170301222511.GA29059@gardel-login>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <20170301222511.GA29059@gardel-login>
Subject: Re: [systemd-devel] SELinux type transition rule not working
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Lennart Poettering" <lennart@poettering.net>
> To: "Ian Pilcher" <arequipeno@gmail.com>
> Cc: "Systemd" <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov
> Sent: Wednesday, March 1, 2017 5:25:11 PM
> Subject: Re: [systemd-devel] SELinux type transition rule not working
> 
> On Wed, 01.03.17 15:40, Ian Pilcher (arequipeno@gmail.com) wrote:
> 
> > I am using systemd's RuntimeDirectory to create a directory for a
> > service.
> > 
> >    RuntimeDirectory=squoxy
> > 
> > This causes systemd to create /run/squoxy before starting my service,
> > but I haven't been able to get the SELinux context set correctly on the
> > directory.
> > 
> > I've set file context rules for both /run/squoxy and /var/run/squoxy:
> > 
> > ^/var/run/squoxy(/.*)?  all files  system_u:object_r:squoxy_var_run_t:s0
> > ^/run/squoxy(/.*)?      all files  system_u:object_r:squoxy_var_run_t:s0
> > 
> > And, indeed, restorecon will set the context of the directory to
> > squoxy_var_run_t.
> > 
> > I've also added a type transition rule, attempting to get the correct
> > context applied automatically when systemd creates the directory:
> > 
> > type_transition init_t var_run_t : dir squoxy_var_run_t "squoxy";
> > 
> > But the directory is still being created as var_run_t:
> > 
> > drwxr-xr-x. nobody nobody system_u:object_r:var_run_t:s0   /run/squoxy
> > 
> > What am I doing wrong?
> 

Ian, 

I assume this would be a pid file?

If so then what you are probably looking for is a filename_trans rule and will require a new interface in squid.if for this. 

Try something like

interface(`squid_filetrans_named_content',`
        gen_require(`
		     type_squid_var_run_t; 
	')

        files_pid_filetrans($1, squid_var_run_t, dir, "squozy")
')

> Hmm, so the relevant code in systemd actually labels the dir after
> creating it after an selinux database lookup, so from our side all
> should be good:
> 
> https://github.com/systemd/systemd/blob/master/src/core/execute.c#L1857
> 
> (specifically, we all mkdir_p_label() instead of plain mkdir_p() there)
> 
> My own understanding of SELinux is finite however. I'd recommend
> pinging the SELinux folks for help on this,
> 

We got you covered! 

> Lennart
> 
> --
> Lennart Poettering, Red Hat
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> 

-- 
Simon Sekidde * Red Hat, Inc. * Tyson's Corner, VA
Solution Architect, NA Public Sector
ssekidde@redhat.com | (w) 978-392-1074 | (m) 571-551-9366 | @ssekidde
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
