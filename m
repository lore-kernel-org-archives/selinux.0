From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [PATCH -v3] SELinux: Convert avc_audit to use lsm_audit.h
Date: Fri, 14 Aug 2009 10:57:32 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Thomas Liu <tliu@redhat.com>,
        eparis@parisplace.org, jmorris@namei.org, selinux@tycho.nsa.gov
References: <1247588049.2164.22.camel@Ares> <1250261501.3629.5.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1250261501.3629.5.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200908141057.33626.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 August 2009 10:51:41 am Stephen Smalley wrote:
> BTW, it looks to my untrained eye as if dump_common_audit_data() allows
> one to pass a separate target task in the union, in which case we'll get
> two sets of pid= and comm=  data in the same record, one for the subject
> and one for the target/object.  It appears that Smack is already using
> that facility for things like ptrace, kill, etc, whereas SELinux is not.

They should not be doing that. When another process is the object, we have 
specific auxiliary audit records to record this. We have to do this for CAPP so 
MAC systems should not have to do this. See AUDIT_OBJ_PID.

> Two questions:
> 1) Will the multiple pid= comm= entries get handled correctly by auditd
> and the audit tools? Do we need separate names for the target vs source
> pid/comm values?

Yes, we need to record the object information. But we have a record type for 
that already AUDIT_OBJ_PID.

> 2) Should we start using ad.u.tsk in SELinux as well to capture the
> target of a ptrace, kill, wait, ... in the avc audit record?

It should be captured. I thought it was for the LSPP work we did. If for some 
reason its not recorded, then audit_log_pid_context() should be called.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
