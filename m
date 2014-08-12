Message-ID: <53EA578A.3090907@tycho.nsa.gov>
Date: Tue, 12 Aug 2014 14:06:02 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <CALCETrWOb-Fg85GB=FtNhbKc=BidWehTO94imCMOURjBnEmVCQ@mail.gmail.com>
In-Reply-To: <CALCETrWOb-Fg85GB=FtNhbKc=BidWehTO94imCMOURjBnEmVCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2014 02:01 PM, Andy Lutomirski wrote:
> On Mon, Aug 4, 2014 at 10:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> If the callee SID is bounded by the caller SID, then allowing
>> the transition to occur poses no risk of privilege escalation and we can
>> therefore safely allow the transition to occur.  Add this exemption
>> for both the case where a transition was explicitly requested by the
>> application and the case where an automatic transition is defined in
>> policy.
> 
> This still wants something like security_bounded_transition_noaudit,
> right?  (Or just a parameter about whether to audit -- there will only
> be two callers, I think.)

I think generating an audit record is correct in this case; the
operation would have succeeded if the type were bounded, so it is
correct and helpful to report this to the audit log for diagnosing
failures.  I think Paul's prior objection was that you could end up with
an audit record even when the operation succeeded when we allowed the
transitions on either a bounded transition or dyntransition permission,
but that is no longer the case.

> 
> --Andy
> 
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  security/selinux/hooks.c | 59 ++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 47 insertions(+), 12 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 83d06db..d96c91a 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2086,6 +2086,41 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
>>
>>  /* binprm security operations */
>>
>> +static int check_nnp_nosuid(const struct linux_binprm *bprm,
>> +                           const struct task_security_struct *old_tsec,
>> +                           const struct task_security_struct *new_tsec)
>> +{
>> +       int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
>> +       int nosuid = (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID);
>> +       int rc;
>> +
>> +       if (!nnp && !nosuid)
>> +               return 0; /* neither NNP nor nosuid */
>> +
>> +       if (new_tsec->sid == old_tsec->sid)
>> +               return 0; /* No change in credentials */
>> +
>> +       /*
>> +        * The only transitions we permit under NNP or nosuid
>> +        * are transitions to bounded SIDs, i.e. SIDs that are
>> +        * guaranteed to only be allowed a subset of the permissions
>> +        * of the current SID.
>> +        */
>> +       rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
>> +       if (rc) {
>> +               /*
>> +                * On failure, preserve the errno values for NNP vs nosuid.
>> +                * NNP:  Operation not permitted for caller.
>> +                * nosuid:  Permission denied to file.
>> +                */
>> +               if (nnp)
>> +                       return -EPERM;
>> +               else
>> +                       return -EACCES;
>> +       }
>> +       return 0;
>> +}
>> +
>>  static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>>  {
>>         const struct task_security_struct *old_tsec;
>> @@ -2122,14 +2157,10 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>>                 /* Reset exec SID on execve. */
>>                 new_tsec->exec_sid = 0;
>>
>> -               /*
>> -                * Minimize confusion: if no_new_privs or nosuid and a
>> -                * transition is explicitly requested, then fail the exec.
>> -                */
>> -               if (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)
>> -                       return -EPERM;
>> -               if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
>> -                       return -EACCES;
>> +               /* Fail on NNP or nosuid if not an allowed transition. */
>> +               rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
>> +               if (rc)
>> +                       return rc;
>>         } else {
>>                 /* Check for a default transition on this program. */
>>                 rc = security_transition_sid(old_tsec->sid, isec->sid,
>> @@ -2137,15 +2168,19 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>>                                              &new_tsec->sid);
>>                 if (rc)
>>                         return rc;
>> +
>> +               /*
>> +                * Fallback to old SID on NNP or nosuid if not an allowed
>> +                * transition.
>> +                */
>> +               rc = check_nnp_nosuid(bprm, old_tsec, new_tsec);
>> +               if (rc)
>> +                       new_tsec->sid = old_tsec->sid;
>>         }
>>
>>         ad.type = LSM_AUDIT_DATA_PATH;
>>         ad.u.path = bprm->file->f_path;
>>
>> -       if ((bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID) ||
>> -           (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))
>> -               new_tsec->sid = old_tsec->sid;
>> -
>>         if (new_tsec->sid == old_tsec->sid) {
>>                 rc = avc_has_perm(old_tsec->sid, isec->sid,
>>                                   SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
>> --
>> 1.8.3.1
>>
> 
> 
> 
