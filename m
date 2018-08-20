Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7KFVQB0005229
 for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2018 11:31:26 -0400
From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: Jann Horn <jannh@google.com>
CC: Kernel Hardening <kernel-hardening@lists.openwall.com>, kernel list
 <linux-kernel@vger.kernel.org>, linux-security-module
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "Hansen, Dave" <dave.hansen@intel.com>, "Dock,
 Deneen T" <deneen.t.dock@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>
Date: Mon, 20 Aug 2018 15:31:22 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732143F7A4@ORSMSX107.amr.corp.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-4-casey.schaufler@intel.com>
 <CAG48ez3aB5X9=hqepovG6L4vQYZjzHZ6fWqdd4Vtzh92u2J5fQ@mail.gmail.com>
In-Reply-To: <CAG48ez3aB5X9=hqepovG6L4vQYZjzHZ6fWqdd4Vtzh92u2J5fQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: [PATCH RFC v2 3/5] LSM: Security module checking for
 side-channel dangers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Jann Horn [mailto:jannh@google.com]
> Sent: Friday, August 17, 2018 4:53 PM
> To: Schaufler, Casey <casey.schaufler@intel.com>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> Subject: Re: [PATCH RFC v2 3/5] LSM: Security module checking for side-
> channel dangers
> 
> On Sat, Aug 18, 2018 at 12:17 AM Casey Schaufler
> <casey.schaufler@intel.com> wrote:
> >
> > From: Casey Schaufler <cschaufler@localhost.localdomain>
> >
> > The sidechannel LSM checks for cases where a side-channel
> > attack may be dangerous based on security attributes of tasks.
> > This includes:
> >         Effective UID of the tasks is different
> >         Capablity sets are different
> >         Tasks are in different namespaces
> > An option is also provided to assert that task are never
> > to be considered safe. This is high paranoia, and expensive
> > as well.
> >
> > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> [...]
> > +#ifdef CONFIG_SECURITY_SIDECHANNEL_UIDS
> > +static int safe_by_uid(struct task_struct *p)
> > +{
> > +       const struct cred *ccred = current_real_cred();
> > +       const struct cred *pcred = get_task_cred(p);
> > +
> > +       /*
> > +        * Credential checks. Considered safe if:
> > +        *      UIDs are the same
> > +        */
> > +       if (ccred != pcred && ccred->euid.val != pcred->euid.val)
> > +               return -EACCES;
> > +       return 0;
> > +}
> 
> This function looks bogus. get_task_cred() bumps the refcount on the
> returned cred struct pointer, but you don't drop it. You probably want
> to use something that doesn't fiddle with the refcount at all here to
> avoid cacheline bouncing - possibly a raw rcu_dereference_protected()
> if there are no better helpers.
> 
> Same thing for the other get_task_cred() calls further down in the patch.

Thanks. Looks like I whacked out v2 a bit hastily.
