Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5T0cxik022355
 for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2018 20:38:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 41GySc6yd8z4KRKb
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 00:38:56 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 41GySb3g0Tz4KRKR
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 00:38:55 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so4970608lfc.10
 for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2018 17:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com>
 <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Jun 2018 20:38:21 -0400
Message-ID: <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
To: jannh@google.com
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 security@kernel.org, linux-kernel@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of
 locked regions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 28, 2018 at 8:23 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 06/25/2018 12:34 PM, Jann Horn wrote:
> > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > stall indefinitely, which can block fsi->mutex if it is held.
> > >
> > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > to access anything that requires locking.
> > >
> > > For sel_read_bool(), move the user access below the locked region.
> > >
> > > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > > up above the locked region.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> >
> > Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> > do we need it to be back-ported any further than the commit which introduced it.
>
> Considering we are talking about v2.6.12 I have to wonder if anyone is
> bothering with backports for kernels that old.  Even the RHEL-5.x
> based systems are at least on v2.6.18.
>
> Regardless, I think this is fine to merge as-is; thanks everyone.

FYI, I did have to remove the "fsi" variable from sel_read_policy() to
keep the compiler happy.  Please double check to make sure your code
compiles cleanly in the future.

-- 
paul moore
www.paul-moore.com
