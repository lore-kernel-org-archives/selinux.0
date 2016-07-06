Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u66BTqDZ026977
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 07:29:52 -0400
Received: by mail-pa0-f68.google.com with SMTP id us13so20839724pab.1
 for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2016 04:29:50 -0700 (PDT)
Date: Wed, 6 Jul 2016 19:29:42 +0800
From: Jason Zaman <jason@perfinion.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
Message-ID: <20160706112942.GA21226@meriadoc.perfinion.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467798202-6412-1-git-send-email-rjones@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Wed, Jul 06, 2016 at 10:43:21AM +0100, Richard W.M. Jones wrote:
> The autorelabel feature has been broken in Fedora for a while.
> virt-builder relies on this feature to enable SELinux in guests since
> we are unable to set filesystem labels when generating the image.  So
> it comes down to me to try to fix this.  There was a discussion on the
> Fedora development list which explains the background and the reasons
> why autorelabel is broken:
> 
> http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
> 
> The plan to fix autorelabel (also formulated in the above thread) is
> in two parts:
> 
> (1) [This patch] If the autorelabel condition is detected when loading
> policy very early during boot, we set SELinux to permissive mode
> (overriding the contents of /etc/selinux/config and the command line).

Can't you just set enforcing=0 on the kernel commandline for the first
boot?

This patch sounds a bit dangerous. If anyone can touch /.autorelabel
later on the machine will be in permissive mode on next reboot. Also we
dont use /.autorelabel in gentoo (not sure about arch or debian) so
something like this would just make the machine always in permissive
mode since there is no service to delete the file.

There are also many times other than first install when you would want
to relabel, if /home is moved to another HDD then you might want to
relabel but the machine would be completely fine in enforcing mode.

This sounds like you want permissive for *only* the very first boot and
never again but the way of doing it leaves that open. At the very least
I'd make it check for (/.autorelabel && (security.selinux xattr is
completely missing on /)) so it will probably not happen after the first
boot, but that still makes me a little uneasy. Having too many ways to
put the machine into permissive means it's easy to miss one later.

In gentoo the default install has /etc/selinux/config set to permissive
so the user sets enforcing later once they have relabelled, that might
be another option, but kernel commandline for first boot might still be
safer.

> (2) We install a systemd "generator".  If the autorelabel condition is
> detected, then the generator redirects the default target to a new,
> very minimal selinux-autorelabel.target.  This will relabel the
> filesystem, remove /.autorelabel and reboot.  After the reboot the
> system will boot normally, with correct filesystem labels and of
> course with SELinux enabled.
> 
> During relabelling (unlike currently) only a very minimal set of
> services are enabled, just enough to be able to mount the filesystem.
> This should ensure there is no danger from having SELinux permissive
> while relabelling.

This sounds good. if the labels are wrong all the daemons that start
will be wrong anyway so rebooting is basically always required.

-- Jason

> This patch is actually against the fedora-selinux.git tree, although
> it probably applies upstream too.
> 
> Rich.
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
