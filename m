Message-ID: <1496334154.27759.9.camel@tycho.nsa.gov>
Subject: Re: selabel_lookup_raw() doesn't find correct context for path with
 double slashes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Cc: 863854-forwarded@bugs.debian.org
Date: Thu, 01 Jun 2017 12:22:34 -0400
In-Reply-To: <a06c7239-39a9-b2c1-e045-52e138f2fcde@debian.org>
References: <070cda6f-fcdf-1cd0-9989-9cc97eaaf49d@debian.org>
 <1496323462.27759.2.camel@tycho.nsa.gov>
 <a06c7239-39a9-b2c1-e045-52e138f2fcde@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-06-01 at 15:37 +0200, Laurent Bigonville wrote:
> Le 01/06/17 à 15:24, Stephen Smalley a écrit :
> > On Thu, 2017-06-01 at 11:29 +0200, Laurent Bigonville wrote:
> > > Hello,
> > > 
> > > While investigating a bug about systemd/udev not setting the
> > > proper
> > > context on the hwdb.bin file, Michael Biebl discovered that
> > > apparently
> > > the selabel_lookup_raw() function is not coping properly with
> > > paths
> > > with
> > > double slashes (like "//lib/udev/hwdb.bin")
> > > 
> > > Shouldn't the selabel_lookup*() functions be more resilient to
> > > this
> > > case? Or should application canonicalize (with realpath()?) the
> > > path
> > > before calling these functions?
> > > 
> > > Regards,
> > > 
> > > Laurent Bigonville
> > > 
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863854
> > 
> > AFAICS, it already does this, and has done so for a long time.
> > 
> > $ selabel_lookup -r -b file -k //lib/udev/hwdb.bin
> > Default context: system_u:object_r:bin_t:s0
> > 
> > $ selabel_lookup -r -b file -k /lib/udev/hwdb.bin
> > Default context: system_u:object_r:bin_t:s0
> > 
> > (The output may differ on your system due to policy differences -
> > mine
> > was on Fedora - but the point is that the resulting context is the
> > same
> > with and without the double slashes.)
> 
> Thanks for the reply.
> 
> Interesting, this doesn't seem to be the case in debian unstable 
> (SELinux userspace 2.6) and I'm using the refpolicy here on my test
> machine:
> 
> $ /usr/sbin/selabel_lookup -r -b file -k //lib/udev/hwdb.bin
> Default context: system_u:object_r:default_t:s0
> 
> $ /usr/sbin/selabel_lookup -r -b file -k /lib/udev/hwdb.bin
> Default context: system_u:object_r:bin_t:s0

Ok, I reproduced it with refpolicy.  It seems to be due to the way file
contexts substitutions are implemented; the substitution occurs in the
common selabel code (selabel.c:selabel_lookup_common) and evidently
requires exact prefix match, but the duplicated slash removal occurs
later in the file backend code (selabel_file.c:lookup_common). Both
Fedora policy and upstream refpolicy have the substitution for /lib
/usr/lib, but Fedora policy still has duplicated entries for /lib in
its file_contexts and therefore matches regardless.

So, yes, this seems to be a bug.

> 
> 
> > The relevant code is:
> > https://github.com/SELinuxProject/selinux/blob/master/libselinux/sr
> > c/label_file.c#L716
> > 
> > The commit was:
> > https://github.com/SELinuxProject/selinux/commit/8f007923dd4ff89652
> > 479587d96e22bc63dbf822
> > 
> > That said, if further canonicalization beyond duplicate slash
> > removal
> > is needed (ala realpath), that is on the caller.  That is done for
> > example by selinux_restorecon(3), if SELINUX_RESTORECON_REALPATH is
> > passed to it.
