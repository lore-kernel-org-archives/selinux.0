Date: Thu, 20 Feb 2014 19:36:43 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
Message-ID: <20140220183643.GB24876@tango.0pointer.de>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 20.02.14 18:17, Colin Walters (walters@verbum.org) wrote:

Hmm, maybe a simple check access("/etc/selinux/", F_OK) would be enough?
There's no point in trying to initialized SELinux if that dir does not
exist, right? Then we could simply bypass the whole thing...

> On Thu, Feb 20, 2014 at 1:06 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> >Wouldn't it be better (and more correct) to probe both the
> >initramfs and
> >the real root, and if neither one can load policy successfully and
> >enforcing=1, then halt?
> >
> So you're saying we should handle -ENOENT specially in the
> initramfs?  Something like being sure we preserve errno and
> returning it to the caller of selinux_init_load_policy()?  That
> would introduce a subtle version dependency.
> 
> Or alternatively, just try in the initramfs, ignore any errors, and
> only abort if we also fail to load in the real root?
> 
> I think both of these (particularly the second) are worse than my
> patch - we don't (to my knowledge) support putting policy in the
> initramfs now with Fedora or Red Hat Enterprise Linux, so attempting
> to find it there by default on every bootup is wrong.
> 
> To turn it around, what is the possible value in also probing the
> initramfs?  Does anyone out there load policy from it with systemd?
> 

> _______________________________________________
> systemd-devel mailing list
> systemd-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/systemd-devel



Lennart

-- 
Lennart Poettering, Red Hat
