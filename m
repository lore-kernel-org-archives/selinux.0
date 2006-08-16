Subject: Re: Invalid context in targeted SELinux policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Musgrave <dmusgrave@abodiosoftware.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <W7685912732296271155678629@webmail16>
References: <W7685912732296271155678629@webmail16>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 09:24:07 -0400
Message-Id: <1155734647.18911.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-15 at 21:50 +0000, Daniel Musgrave wrote:
> I am in the process of writing an application and associated policy in
> Centos 4.3, running a targeted SELinux environment at version
> 1.17.30-2.126.  After succesfully creating the necessary rules in
> my .te file, and the associated file contexts in the .fc file, I am
> attempting to resolve one last problem.  After compiling my policy and
> running the application, I get the following error:
> 
> audit(...): security_compute_sid: invalid context
> root:system_r:upgrade_t for scontext=root:system_r:unconfined_t
> tcontext=system_u:object_r:upgrade_exec_t tclass=process

This typically means that the new domain 'upgrade_t' hasn't been
authorized for the role 'system_r', e.g. role system_r types upgrade_t;

> The domain for this executable is 'upgrade' and the file context of
> the binary is 'upgrade_exec_t' (there are some associated *_log_t and
> *_tmp_t files as well).  The .te file defines upgrade using the
> application_domain macro.

Hmm...application_domain() includes a role statement for sysadm_r by
default, and also includes a role statement for system_r if
targeted_policy is defined, i.e. building targeted policy.  At least in
the last release of the example policy.  But possibly that wasn't in the
CentOS/RHEL policies as shipped.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
