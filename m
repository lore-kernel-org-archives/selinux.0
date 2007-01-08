Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08HlnCC030703
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 12:47:49 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l08Hmbc5016239
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:48:37 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070103214837.GB21450@w-m-p.com>
References: <459BDFD4.7080903@redhat.com> <20070103214837.GB21450@w-m-p.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 12:48:36 -0500
Message-Id: <1168278516.12883.24.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-03 at 15:48 -0600, Klaus Weidner wrote:
> On Wed, Jan 03, 2007 at 11:54:44AM -0500, Daniel J Walsh wrote:
> > sudo reads netlink_route_socket,  wants to look at the kernel key ring, 
> > stores a token in the pam_pid directory, and needs to getattr on all 
> > "user" executables.
> > 
> > Some changes to su in order to handle key rings,  Needs 
> > mls_file_write_down.  Need to be able to su from different domains, and 
> > pam_rootok causes some selinux_compute_access checks.
> [...]
> > sshd wants to look at kernel key ring
> [...]
> > fixes for authlogin handling of keyrings and mls, as well as pcscd
> 
> I'm confused about what kernel keyring features are currently available
> in the current policy, and who gets to use them.

I haven't had a chance to look at the patch, but what is currently
upstream does not allow users to do anything with keys.  Here's the
current rules across the entire upstream repo (which includes modules
not enabled in the lspp policy):

allow crond_t kernel_t:key search;
allow crond_t local_login_t:key link;
allow crond_t local_login_t:key search;
allow crond_t self:key { search write link };
allow initrc_su_t kernel_t:key search;
allow initrc_su_t self:key { search write };
allow local_login_t kernel_t:key link;
allow local_login_t kernel_t:key search;
allow local_login_t self:key { search write link };
allow local_login_t userdomain:key create;
allow remote_login_t self:key write;
allow sshd_t kernel_t:key link;
allow sshd_t self:key { search link write };
allow unconfined_domain_type domain:key *;
allow xdm_t self:key { search link write };
allow xdm_t userdomain:key create;


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
