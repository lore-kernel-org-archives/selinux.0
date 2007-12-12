Subject: Re: [PATCH] [STABLE] Makefile change to disable restorecond
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <475F264F.1000803@manicmethod.com>
References: <475EED72.3090607@manicmethod.com>
	 <475EEF4D.4000807@manicmethod.com>
	 <1197404396.28006.111.camel@moss-spartans.epoch.ncsc.mil>
	 <475F264F.1000803@manicmethod.com>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 10:40:52 -0500
Message-Id: <1197474052.1125.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-11 at 19:07 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2007-12-11 at 15:13 -0500, Joshua Brindle wrote:
> >   
> >> Joshua Brindle wrote:
> >>     
> >>> This patch is necessary to build stable on RHEL4. CLIP uses the 
> >>> current stable toolchain and supports RHEL4 as a target so we are 
> >>> trying to upstream any magic that is necessary to build on that platform.
> >>>
> >>>       
> >> Ignore last patch, this one is actually against stable :)
> >>     
> >
> > What about just checking for the presence of /usr/include/sys/inotify.h
> > and disabling restorecond in its absence, similar to handling of PAMH
> > and AUDITH in newrole's Makefile?  Then that could go into trunk too.
> >   
> So... like this?
> 
> --- policycoreutils/Makefile    (revision 2696)
> +++ policycoreutils/Makefile    (working copy)
> @@ -1,5 +1,11 @@
> -SUBDIRS=setfiles semanage load_policy newrole run_init restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
> +SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
>  
> +INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
> +
> +ifeq (${INOTIFYH}, /usr/include/sys/inotify.h)
> +       SUBDIRS += restorecond
> +endif
> +
>  all install relabel clean indent:
>         @for subdir in $(SUBDIRS); do \
>                 (cd $$subdir && $(MAKE) $@) || exit 1; \

Yes.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
