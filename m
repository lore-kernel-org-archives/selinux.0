Subject: Re: capability audit_write, audit_control
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510211932.j9LJWT3Y022912@mms-r00.iijmio.jp>
References: <1129918159.27663.117.camel@moss-spartans.epoch.ncsc.mil>
	 <200510211932.j9LJWT3Y022912@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 11:33:44 -0400
Message-Id: <1130168024.17609.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 15:31 -0400, Yuichi Nakamura wrote:
> My strict policy was old, so I've updated to 1.27.1-2.6 now, 
> checkpolicy and libsepol is the same as yours.
> 
> 1)
> I commented out following from global_macros.te
> #allow $1 self:capability { audit_write audit_control };
> #allow $1 self:capability { audit_write audit_control };
> 
> It is just for test.
> 
> 2)
> add following.
> auditallow sshd_t self:capability { audit_control };
> neverallow sshd_t self:capability audit_control;
> 
> 3) 
> #make reload
> It was success.
> 
> 4) Login to ssh
> 5) I saw following log.
> audit(1129922556.917:12): avc:  granted  { audit_control } for  pid=2315 comm="sshd" capability=30 scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t tclass=capability
> 
> Isn't it strange?

Hi,

After trying the policy file that you sent (via private email), I
observed the following:
1) Querying the binary policy via checkpolicy -d -b (or via apol) showed
that sshd_t was not being allowed audit_control by your modified policy,
as you stated.  Thus, there is no problem in the checkpolicy assertion
checking.
2) In enforcing mode with this policy loaded, login via ssh failed with
no audit messages.  Thus, the kernel is enforcing the correct policy,
but we presently lack auditing of the netlink receive-side capability
checks as I explained earlier in this thread.
3) In permissive mode with this policy loaded, login via ssh succeeded
with a "granted" audit message for the capability.  This is the point of
confusion (but I don't recall you mentioning that you were in permissive
mode when seeing this audit message).

The explanation for #3 is as follows.  When in permissive mode, the AVC
adds any denied permissions to the allowed set in the cache entry on the
first access so that only the first access triggers a log message (to
avoid repeated denials of the same permission, as this can easily lead
to flooding when in permissive mode and we only care about collecting
distinct denials in that mode).  At netlink send time, the entire
capability vector is computed since we do not know in advance what
capabilities (if any) will be required by the receive side code; when in
permissive mode, this causes the entire capability vector in the cache
entry to be filled.  Normally, we would get a denied audit message at
that point, but we specifically do not audit that computation because we
aren't actually checking a particular permission, just precomputing the
entire vector to be stored in the eff_cap field.  At netlink receive
time, the eff_cap field is checked but this also does not generate an
audit message as it is a direct check and we lack the context of the
sender at that point.  Later, sshd attempts to set its loginuid
via /proc/self/loginuid, thereby triggering another audit_control check,
but by then, the permission is already cached in the AVC due to the
earlier computation while in permissive mode.  Therefore, we end up
seeing only a granted audit message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
