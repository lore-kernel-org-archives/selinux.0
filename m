Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBEEgnIi011839
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 09:42:49 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBEEgrfN004892
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 14:42:53 GMT
Subject: Re: [patch] selinux_capget()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 14 Dec 2004 09:37:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-14 at 01:09, James Morris wrote:
> How does the application determine the real effective set?  
> (confusing enough terms ? :-)
> 
> Surely it is a reasonable thing to expect to be able to do.  I'm not sure
> that your example is valid here as euid==0 doesn't mean anything in
> SELinux (if it did, the application could check that first and infer that
> it has all capabilities).

An application (with appropriate permissions) could invoke the
libselinux avc_has_perm() or security_compute_av() interfaces to
determine what capabilities are allowed by SELinux.  On the downside,
that requires the application to perform an extra call and to be
SELinux-aware.  On the upside, it means that an application either
requires appropriate permissions to call security_compute_av() or must
engage in testing activity to discover what capabilitites are allowed by
SELinux as opposed to being able to trivially determine via capget.

If we were going to make this change, it would seem that you would also
need to either change fs/proc/array.c:task_cap() or change SELinux to
mask out the capabilities early (e.g. in selinux_bprm_apply_creds and
selinux_capset_set) so that the capability bitmaps in the task structure
always reflect the combined decision (at which point you'd need to move
the SELinux check prior to the secondary_ops check in selinux_capable or
you'd never see the SELinux audit message at all).  But I'm not certain
we want to make this change.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
