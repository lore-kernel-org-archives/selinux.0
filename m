Message-ID: <53739880.6070006@tycho.nsa.gov>
Date: Wed, 14 May 2014 12:23:28 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>, Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC PATCH] selinux: prevent setting a security label on
 MNT_NOSUID applications
References: <20140514155807.32072.32113.stgit@localhost>
 <CALCETrW7eED6sXcGOreRdTowSPWFAw3X2i0yz+uCkqoMH_rk3g@mail.gmail.com>
In-Reply-To: <CALCETrW7eED6sXcGOreRdTowSPWFAw3X2i0yz+uCkqoMH_rk3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2014 12:16 PM, Andy Lutomirski wrote:
> On Wed, May 14, 2014 at 8:58 AM, Paul Moore <pmoore@redhat.com> wrote:
>> We presently prevent processes from explicitly setting an arbitrary
>> security label on new processes when NO_NEW_PRIVS is enabled; in an
>> attempt for more consistency, this patch extends this to prevent
>> setting an arbitrary label when the new application lives on a
>> filesystem mounted with MNT_NOSUID.
>>
>> Signed-off-by: Paul Moore <pmoore@redhat.com>
>> CC: Andy Lutomirski <luto@amacapital.net>
>> CC: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
> 
> Acked-by: Andy Lutomirski <luto@amacapital.net>
> 
> However: would it pay to move the check above this:
> 
>                 /* Reset exec SID on execve. */
>                 new_tsec->exec_sid = 0;
> 
> I suppose that this shouldn't matter: any correct application already
> needs to redo setexeccon if it gets an error from execve.  Fixing this
> for real would probably involve moving that line of code into
> selinux_bprm_committed_creds.

Shouldn't matter as that is a change to new_tsec (i.e.
bprm->cred->security), which will only be applied to the process if we
reach install_exec_creds(); otherwise it will just be discarded.
