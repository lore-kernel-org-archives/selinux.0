Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBEGGbIi012442
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 11:16:37 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBEGEtq9002985
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 16:14:55 GMT
Subject: Re: [patch] selinux_capget()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>,
   Casey Schaufler <casey@schaufler-ca.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <41BF0C63.30403@trustedcs.com>
References: 
	 <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
	 <1103035060.30808.40.camel@moss-spartans.epoch.ncsc.mil>
	 <41BF0C63.30403@trustedcs.com>
Content-Type: text/plain
Message-Id: <1103040686.30808.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 14 Dec 2004 11:11:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-14 at 10:53, Darrel Goeddel wrote:
> The whole reason I noticed this is because I have been playing with a secondary 
> module that makes SELinux the authoritative decision maker for capable 
> decisions.

This is something we would eventually like to do (i.e. use RBAC/TE as
the sole basis for granting privileges), but to do it safely, you need
to perform:
a) a thorough audit and tightening of the policy, going beyond what is
in the strict policy today to provide separate domains for every setuid
root program and to only allow capabilities to those specific domains,
b) a thorough audit of userspace, going beyond what has been done in
Fedora Core to ensure that no assumptions are made about uid 0 and that
SELinux is consulted on access decisions via libselinux avc_has_perm or
security_compute_av.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
