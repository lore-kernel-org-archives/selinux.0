Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. mattock" <justinmattock@gmail.com>
Cc: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4B7F06F1.4070305@gmail.com>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7F06F1.4070305@gmail.com>
Content-Type: text/plain
Date: Mon, 22 Feb 2010 09:00:50 -0500
Message-Id: <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-19 at 13:47 -0800, Justin P. mattock wrote:
> On 02/19/2010 01:25 PM, Stephen Smalley wrote:
> > On Fri, 2010-02-19 at 16:08 -0500, Alan Rouse wrote:
> >> setsebool -P init_upstart=on
> >> setsebool -P xdm_sysadm_login=on
> >> setsebool -P xserver_object_manager=on
> >
> > I think you only need the first boolean setting.
> > And we should likely introduce an ifdef for suse in refpolicy that
> > always disables that transition so that you don't have to artificially
> > turn on that boolean.
> >
> 
> as a test I built the policy with init_upstart=off
> system crashes and burns with gdm/xserver(dbus error).
> then changing to init_upstart=on xserver/gdm started right up.
> 
> my question is why? especially if this is sysvinit.

The refpolicy defines a domain transition from init_t to sysadm_t upon
executing a shell so that the single-user mode shell is automatically
run in sysadm_t, and it defines a domain transition from init_t to
initrc_t upon executing an rc script (initrc_exec_t) so that rc scripts
are automatically run in initrc_t.  This worked with sysvinit in Fedora
and Debian.  However, upstart launches all services via shell command
and thus all services would be run in sysadm_t if we kept that
transition, so the refpolicy has the following logic (in
system/init.te):

tunable_policy(`init_upstart',`
        corecmd_shell_domtrans(init_t, initrc_t)
',`
        # Run the shell in the sysadm role for single-user mode.
        # causes problems with upstart
        sysadm_shell_domtrans(init_t)
')

This snippet means:  if init_upstart=on, then transition from init_t to
initrc_t upon executing a shell, else transition from init_t to sysadm_t
upon executing a shell.

I had suggested trying init_upstart=on in OpenSUSE because the sestatus
and pstree output showed that most processes launched by init were
running in sysadm_t, similar to what would happen on a system using
upstart if that boolean were not enabled.

This suggests that something is different about the sysvinit setup in
OpenSUSE.  It might be useful to see your /etc/inittab file contents.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
