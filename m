Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAUGm8Tb028911
 for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2016 11:48:08 -0500
Received: by mail-qt0-f176.google.com with SMTP id w33so193269954qtc.3
 for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2016 08:48:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f1c73866-31dc-86ad-5650-9be050770b4e@tycho.nsa.gov>
References: <1480520874-22034-1-git-send-email-kwalker@redhat.com>
 <f1c73866-31dc-86ad-5650-9be050770b4e@tycho.nsa.gov>
From: Kyle Walker <kwalker@redhat.com>
Date: Wed, 30 Nov 2016 11:48:06 -0500
Message-ID: <CAEPKNTLKdamwns+ZeJkgitOWuKfB=QQuuqYcMahA5NvOKyRh-w@mail.gmail.com>
Subject: Re: [PATCH] seobject: Handle python error returns correctly
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 30, 2016 at 11:05 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Hmm...even after this patch, we still get the error message from
> dbase_llist_query.  Wondering if we should drop that or if that would
> hide anything useful for other errors.  Doesn't seem overly useful at
> present.

It does still emit that warning, it stems from the dbase_llist_query_local
not returning any entries and falling back to the dbase_llist_query. It is
chatty, and not necessarily helpful. I can't really think of a use-case for
it myself. Outside of being able to verify that a fcontext is not in the
file_contexts.local, but in the underlying file_contexts database on
modification.

I.E. If you see that message, you are modifying from the defaults. If you
don't, you are modifying a fcontext that has already been modified on the
system previously.
