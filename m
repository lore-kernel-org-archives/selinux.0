Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBEFqtIi012298
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 10:52:56 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBEFpDq9000986
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 15:51:14 GMT
Message-ID: <41BF0C63.30403@trustedcs.com>
Date: Tue, 14 Dec 2004 09:53:07 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: James Morris <jmorris@redhat.com>,
   Casey Schaufler <casey@schaufler-ca.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [patch] selinux_capget()
References: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com> <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> An application (with appropriate permissions) could invoke the
> libselinux avc_has_perm() or security_compute_av() interfaces to
> determine what capabilities are allowed by SELinux.  On the downside,
> that requires the application to perform an extra call and to be
> SELinux-aware.  On the upside, it means that an application either
> requires appropriate permissions to call security_compute_av() or must
> engage in testing activity to discover what capabilitites are allowed by
> SELinux as opposed to being able to trivially determine via capget.
> 
> If we were going to make this change, it would seem that you would also
> need to either change fs/proc/array.c:task_cap() or change SELinux to
> mask out the capabilities early (e.g. in selinux_bprm_apply_creds and
> selinux_capset_set) so that the capability bitmaps in the task structure
> always reflect the combined decision (at which point you'd need to move
> the SELinux check prior to the secondary_ops check in selinux_capable or
> you'd never see the SELinux audit message at all).  But I'm not certain
> we want to make this change.
> 

I agree that the change may not be what we want - this is an idea that came out 
of some experimenting that I am doing.  I was actually expecting an explanation 
about the capget interface along the lines of what Casey pointed out.

We could leave the current /proc/<TGID>/status interface alone to provide a view 
to the "actual" capability set of the process.  Modifying the actual capability 
sets on the process would not work in the case where a process changes its 
domain via setcon to a domain which has greater access to capabilities - we 
would not know whether or not to raise the capabilities in the task struct.

The whole reason I noticed this is because I have been playing with a secondary 
module that makes SELinux the authoritative decision maker for capable 
decisions.  It always returns 0 in its capable hook.  It also uses the 
capability module versions of the syslog and vm_enough_memory hooks because the 
dummy versions actually do uid checks for some reason (I think that these should 
probably be changed, leaving the only uid checks in the actual capable hook for 
dummy), and a modified version of the netlink_send hook.  I just figured it 
would be nice if the module would return full sets from the capget hook, and 
then SELinux would doctor them up to reflect the actual effective capabilities. 
  This idea is still a work in progress, but the effective set modification 
seemed applicable now.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
