Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u67KuIlr027099
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 16:56:18 -0400
Date: Thu, 7 Jul 2016 21:56:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Jason Zaman <jason@perfinion.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
Message-ID: <20160707205614.GA26165@redhat.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
 <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
 <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
 <20160707135017.GA23053@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707135017.GA23053@meriadoc.perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Thu, Jul 07, 2016 at 09:50:17PM +0800, Jason Zaman wrote:
> Doesn't Android set the labels on the /system disk image during build?
> Maybe virt-builder can copy that? This would also speed up initial
> deployment of new images.

Well this is the real problem.  Because the guest policy is a binary
blob, and because the binary blobs are not (necessarily) compatible
across kernel versions, we cannot just load the policy blob of the
guest into our kernel, so we cannot label guests properly.  Sure be
nice if policy wasn't stored in this way.

> What steps are required during a default install in RHEL? does an
> install from a livecd without virt-builder also have this relabelling
> problem?

During a live CD install the live CD runs its own kernel.  That's just
not the way virt-builder works.  Also virt-builder customizes a
template, it doesn't build a whole VM from scratch (because that would
be orders of magnitude slower), so we start with whatever labels are
in the base template.

> One way I can think of is have a transition from kernel_t (or whatever
> the context would be on a completely unlabelled system) to a domain with
> perms to relabel everything. Since the labels would be missing pid1
> would have to runcon -t autorelabel_t ... but it seems the safer road
> than making absolutely everything permissive.

Note that /.autorelabel can be used at any time.  The system is not
necessarily unlabelled, it is wrongly labelled.

> Alternatively, is there a reason /etc/selinux/config shouldn't be set to
> permissive by default in the image? What do we gain with this extra way?
> If the user is going to autorelabel after install, they are already
> probably setting permissive in the config before they reboot too.

As documented, the user can simply touch /.autorelabel and reboot to
autorelabel the system.  They don't have to edit /etc/selinux/config
(and if they did, what would set it back to enforcing, and how would
that thing know what to set it back to?)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
