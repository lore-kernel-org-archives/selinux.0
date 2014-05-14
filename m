Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4EGGYeP021191
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 12:16:34 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so2700095veb.11
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 09:16:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140514155807.32072.32113.stgit@localhost>
References: <20140514155807.32072.32113.stgit@localhost>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 May 2014 09:16:15 -0700
Message-ID: <CALCETrW7eED6sXcGOreRdTowSPWFAw3X2i0yz+uCkqoMH_rk3g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent setting a security label on
 MNT_NOSUID applications
To: Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 14, 2014 at 8:58 AM, Paul Moore <pmoore@redhat.com> wrote:
> We presently prevent processes from explicitly setting an arbitrary
> security label on new processes when NO_NEW_PRIVS is enabled; in an
> attempt for more consistency, this patch extends this to prevent
> setting an arbitrary label when the new application lives on a
> filesystem mounted with MNT_NOSUID.
>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Stephen Smalley <sds@tycho.nsa.gov>
> ---

Acked-by: Andy Lutomirski <luto@amacapital.net>

However: would it pay to move the check above this:

                /* Reset exec SID on execve. */
                new_tsec->exec_sid = 0;

I suppose that this shouldn't matter: any correct application already
needs to redo setexeccon if it gets an error from execve.  Fixing this
for real would probably involve moving that line of code into
selinux_bprm_committed_creds.

--Andy
