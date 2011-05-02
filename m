Date: Mon, 2 May 2011 16:19:47 -0700
From: Greg KH <greg@kroah.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <mzerqung@0pointer.de>,
        linux-security-module@vger.kernel.org,
        systemd-devel@lists.freedesktop.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: add /sys/fs/selinux mount point to put selinuxfs
Message-ID: <20110502231947.GB9295@kroah.com>
References: <20110430011950.GA11566@kroah.com>
 <1304342680.16563.35.camel@moss-pluto>
 <20110502220242.GA30712@kroah.com>
 <1304376860.10692.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304376860.10692.0.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 02, 2011 at 06:54:18PM -0400, Eric Paris wrote:
> On Mon, 2011-05-02 at 15:02 -0700, Greg KH wrote:
> > On Mon, May 02, 2011 at 09:24:40AM -0400, Stephen Smalley wrote:
> > > On Fri, 2011-04-29 at 18:19 -0700, Greg KH wrote:
> > > > From: Greg Kroah-Hartman <gregkh@suse.de>
> > > > 
> > > > In the interest of keeping userspace from having to create new root
> > > > filesystems all the time, let's follow the lead of the other in-kernel
> > > > filesystems and provide a proper mount point for it in sysfs.
> > > > 
> > > > For selinuxfs, this mount point should be in /sys/fs/selinux/
> > > > 
> > > > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: Eric Paris <eparis@parisplace.org>
> > > > Cc: Lennart Poettering <mzerqung@0pointer.de>
> > > > Cc: Daniel J Walsh <dwalsh@redhat.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > > 
> > > > ---
> > > > 
> > > > Note, patch is untested, I don't have any selinux-based machines here,
> > > > sorry.
> > > 
> > > If I understand correctly, the patch won't change any userspace-visible
> > > behavior until one has a new libselinux that actually mounts selinuxfs
> > > on /sys/fs/selinux instead of /selinux, right?
> > 
> > Correct.
> > 
> > > At that point, we have to ensure that all userspace that directly
> > > references /selinux rather than using libselinux is changed to use
> > > libselinux.  You might argue that all such userspace is broken already,
> > > but given that selinuxfs has been mounted on /selinux ever since SELinux
> > > went into mainline in 2003 and , it is difficult to blame them.  Using
> > > codesearch.google.com on
> > > e.g. /selinux/enforce, /selinux/load, /selinux/booleans, /selinux/mls,
> > > etc turns up a number of examples, including glibc (a test case),
> > > puppet, dracut, anaconda, etc.
> > > 
> > > Policy implication:  Any program that needs to access selinuxfs will
> > > need to be able to search sysfs too.
> > > 
> > > Added dependency:  Any system that uses SELinux will need to enable and
> > > mount sysfs (or alternatively create at least a fake /sys/fs directory).
> > > I assume that sysfs is fairly universal at this point though, like proc?
> > 
> > Yes it is.
> > 
> > Care to forward this on to James for the next kernel merge window?
> 
> I'll pick it up in the selinux tree when my machine finished
> reinstalling.

Wonderful, thanks for doing this.

greg k-h

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
