Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v23GjHS3027631
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 11:45:17 -0500
Date: Fri, 3 Mar 2017 11:45:08 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>, lennart@poettering.net,
 selinux@tycho.nsa.gov
Message-ID: <44544158.27690099.1488559508818.JavaMail.zimbra@redhat.com>
In-Reply-To: <333322329.27680470.1488556919299.JavaMail.zimbra@redhat.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <20170301222511.GA29059@gardel-login>
 <944362898.27340550.1488467628547.JavaMail.zimbra@redhat.com>
 <3cf89bd9-7f2b-81d0-c531-db6890cc2fee@gmail.com>
 <333322329.27680470.1488556919299.JavaMail.zimbra@redhat.com>
Subject: Re: [systemd-devel] SELinux type transition rule not working
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ian do you have a copy of this custom policy somewhere?

----- Original Message -----
> From: "Simon Sekidde" <ssekidde@redhat.com>
> To: "Ian Pilcher" <arequipeno@gmail.com>
> Cc: "Systemd" <systemd-devel@lists.freedesktop.org>, lennart@poettering.net, selinux@tycho.nsa.gov
> Sent: Friday, March 3, 2017 11:01:59 AM
> Subject: Re: [systemd-devel] SELinux type transition rule not working
> 
> 
> 
> ----- Original Message -----
> > From: "Ian Pilcher" <arequipeno@gmail.com>
> > To: "Simon Sekidde" <ssekidde@redhat.com>
> > Cc: "Systemd" <systemd-devel@lists.freedesktop.org>, selinux@tycho.nsa.gov,
> > lennart@poettering.net
> > Sent: Friday, March 3, 2017 10:44:18 AM
> > Subject: Re: [systemd-devel] SELinux type transition rule not working
> > 
> > On 03/02/2017 09:13 AM, Simon Sekidde wrote:
> > > I assume this would be a pid file?
> > 
> > You assume correctly.
> > 
> > > If so then what you are probably looking for is a filename_trans rule
> > > and will require a new interface in squid.if for this.
> > >
> > > Try something like
> > >
> > > interface(`squid_filetrans_named_content',` gen_require(`
> > > type_squid_var_run_t; ')
> > >
> > > files_pid_filetrans($1, squid_var_run_t, dir, "squozy") ')
> > 
> > Not sure where squid came from.  The service is one of my own making
> > called "squoxy" (short for "Squeezebox proxy").  Its purpose is to
> > forward Squeezebox discovery broadcast packets from one network to
> > another.
> > 
> 
> Sorry I must have been doing something in the squid policy while I was
> responding to this...
> 
> > So I assume that I would need to add something like this to my policy
> > module:
> > 
> >    files_pid_filetrans(var_run_t, squoxy_var_run_t, dir, "squoxy")
> > 
> > (I'm guessing at what to put in for $1.)
> > 
> 
> files_pid_filetrans(squoxy_t, squoxy_var_run_t, dir, "squoxy")
> 
> Files created by the squoxy_t processes in the var_run_t directory will be
> created with the squoxy_var_run_t label
> 
> > >> Hmm, so the relevant code in systemd actually labels the dir after
> > >> creating it after an selinux database lookup, so from our side all
> > >> should be good:
> > >>
> > >> https://github.com/systemd/systemd/blob/master/src/core/execute.c#L1857
> > >>
> > >>
> > >>(specifically, we all mkdir_p_label() instead of plain mkdir_p()
> >  >> there)
> > 
> > And this is working now, presumably after a reboot?  I do so love
> > non-deterministic computers.  :-/
> > 
> > --
> > ========================================================================
> > Ian Pilcher                                         arequipeno@gmail.com
> > -------- "I grew up before Mark Zuckerberg invented friendship" --------
> > ========================================================================
> > 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> 
