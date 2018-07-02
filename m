Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w62DvVsN014146
 for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2018 09:57:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 41K82c5sxKzg473
 for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2018 13:57:28 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 41K82c1yhlzg47J
 for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2018 13:57:28 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so4120575ois.1
 for <selinux@tycho.nsa.gov>; Mon, 02 Jul 2018 06:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com>
 <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com>
 <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
In-Reply-To: <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 2 Jul 2018 15:57:14 +0200
Message-ID: <CAG48ez0GDpuFO1-uMv0GGoPjo08QSCv0sL5du2b7_mi0QFcE8Q@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 security@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of
 locked regions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 29, 2018 at 2:38 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jun 28, 2018 at 8:23 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 06/25/2018 12:34 PM, Jann Horn wrote:
> > > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > > stall indefinitely, which can block fsi->mutex if it is held.
> > > >
> > > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > > to access anything that requires locking.
> > > >
> > > > For sel_read_bool(), move the user access below the locked region.
> > > >
> > > > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > > > up above the locked region.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > >
> > > Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> > > do we need it to be back-ported any further than the commit which introduced it.
> >
> > Considering we are talking about v2.6.12 I have to wonder if anyone is
> > bothering with backports for kernels that old.  Even the RHEL-5.x
> > based systems are at least on v2.6.18.
> >
> > Regardless, I think this is fine to merge as-is; thanks everyone.
>
> FYI, I did have to remove the "fsi" variable from sel_read_policy() to
> keep the compiler happy.  Please double check to make sure your code
> compiles cleanly in the future.

Oof, don't know how I missed that. Sorry, I'll be more careful.
