Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u66CD2mO032650
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 08:13:02 -0400
Date: Wed, 6 Jul 2016 13:12:57 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
Message-ID: <20160706121257.GS16797@redhat.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160706112942.GA21226@meriadoc.perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Wed, Jul 06, 2016 at 07:29:42PM +0800, Jason Zaman wrote:
> On Wed, Jul 06, 2016 at 10:43:21AM +0100, Richard W.M. Jones wrote:
> > The autorelabel feature has been broken in Fedora for a while.
> > virt-builder relies on this feature to enable SELinux in guests since
> > we are unable to set filesystem labels when generating the image.  So
> > it comes down to me to try to fix this.  There was a discussion on the
> > Fedora development list which explains the background and the reasons
> > why autorelabel is broken:
> > 
> > http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
> > 
> > The plan to fix autorelabel (also formulated in the above thread) is
> > in two parts:
> > 
> > (1) [This patch] If the autorelabel condition is detected when loading
> > policy very early during boot, we set SELinux to permissive mode
> > (overriding the contents of /etc/selinux/config and the command line).
> 
> Can't you just set enforcing=0 on the kernel commandline for the first
> boot?

For virt-builder, no.  We create automated images that must
boot themselves without manual intervention.

However even ignoring my use case, I don't think it's a good idea
anyway.  If /.autorelabel is set, then the labels on the filesystem
are known to be wrong.  You shouldn't be making enforcement decisions
based on labels which you know are wrong.

> This patch sounds a bit dangerous. If anyone can touch /.autorelabel
> later on the machine will be in permissive mode on next reboot.

If someone can create files in / then I suspect you've got other
problems.  In any case it will then immediately jump to the generator
and relabel in a (very) minimal environment and reboot.  After this
second boot it'll be back to enforcing (or whatever is requested by
/etc/selinux/config).

> Also we dont use /.autorelabel in gentoo (not sure about arch or
> debian) so something like this would just make the machine always in
> permissive mode since there is no service to delete the file.

As I noted, I made this patch against the downstream fedora-selinux
git.  That repository says to send patches here.

> There are also many times other than first install when you would want
> to relabel, if /home is moved to another HDD then you might want to
> relabel but the machine would be completely fine in enforcing mode.
> 
> This sounds like you want permissive for *only* the very first boot and
> never again but the way of doing it leaves that open. At the very least
> I'd make it check for (/.autorelabel && (security.selinux xattr is
> completely missing on /))

The way autorelabel is documented to work, users can set it any time,
not just on first boot.  The labels can be wrong, not unset.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
