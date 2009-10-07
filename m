Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: CoreutilsBugs <bug-coreutils@gnu.org>,
        =?UTF-8?Q?Ond=C5=99ej_Va=C5=A1=C3=ADk?= <ovasik@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, yaneti@declera.com
In-Reply-To: <87r5th7xd0.fsf@meyering.net>
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	 <87zl85bs0e.fsf@meyering.net>
	 <1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil>
	 <87d451boea.fsf@meyering.net>  <87r5th7xd0.fsf@meyering.net>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 08:37:52 -0400
Message-Id: <1254919072.2251.186.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-06 at 10:14 +0200, Jim Meyering wrote:
> Jim Meyering wrote:
> > Stephen Smalley wrote:
> > ...
> >> Must have previously booted an ancient kernel with SELinux permissive
> >> and no policy loaded.  Kernel was fixed by the commit below in 2006.
> >> I'd recommend that he run the following to clean up the droppings in his
> >> filesystem:
> >> find / \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 \) -exec setfattr -x security.selinux {} \;
> >>
> >> commit 8aad38752e81d1d4de67e3d8e2524618ce7c9276
> >> Author: Stephen Smalley <sds@tycho.nsa.gov>
> >> Date:   Wed Mar 22 00:09:13 2006 -0800
> >>
> >>     [PATCH] selinux: Disable automatic labeling of new inodes when no policy is loaded
> >
> > Thanks for the quick explanation!
> 
> I've revised the commit not to say anything in NEWS
> and to expand the log message.  While the exit-early
> change doesn't solve the problem in all cases, it is useful
> and does make chcon consistent with runcon in that respect.

FWIW, there is a subtle difference here:
- chcon can in fact work on a SELinux-disabled kernel, as you can still
set the security.* extended attributes as long as the filesystem
provides handlers for the security.* namespace.
- runcon cannot work without a SELinux-enabled kernel, as only a
SELinux-enabled kernel allows you to set the security context of a
running process.

So by preventing chcon from running in the SELinux-disabled case, you
are imposing a restriction above and beyond what is strictly required.
The user can of course still use setfattr -n security.selinux -v
<context> <path> to set a SELinux security context on a file when
SELinux is disabled, or can run the setfiles program to set SELinux
security contexts on an entire file tree even when SELinux is disabled.

> 
> >From 3a97d664b9f639fddb5a245775f47d27bfbb56c9 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Ond=C5=99ej=20Va=C5=A1=C3=ADk?= <ovasik@redhat.com>
> Date: Mon, 5 Oct 2009 09:20:48 +0200
> Subject: [PATCH] chcon: exit immediately if SELinux is disabled
> 
> This change happens to avoid an abort in chcon when SELinux is
> disabled while operating on a file with an "unlabeled" context from
> back in 2006.  However, that same abort can still be triggered by the
> same file when running chcon with SELinux enabled.  This bug in chcon
> will be fixed in a subsequent commit via a getfilecon wrapper.  See
> http://thread.gmane.org/gmane.comp.gnu.coreutils.bugs/18378/focus=18384
> for how to correct your disk attributes to avoid triggering this bug.
> * src/chcon.c (main): Exit immediately if SELinux is disabled.
> Reported in http://bugzilla.redhat.com/527142 by Yanko Kaneti.
> * src/runcon.c (main): Do not hardcode program name in error message.
> * THANKS: Update.
> ---
>  THANKS       |    1 +
>  src/chcon.c  |    4 ++++
>  src/runcon.c |    2 +-
>  3 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/THANKS b/THANKS
> index e0e14e5..65ac1bb 100644
> --- a/THANKS
> +++ b/THANKS
> @@ -612,6 +612,7 @@ Wis Macomson                        wis.macomson@intel.com
>  Wojciech Purczynski                 cliph@isec.pl
>  Wolfram Kleff                       kleff@cs.uni-bonn.de
>  Won-kyu Park                        wkpark@chem.skku.ac.kr
> +Yanko Kaneti                        yaneti@declera.com
>  Yann Dirson                         dirson@debian.org
>  Zvi Har'El                          rl@math.technion.ac.il
> 
> diff --git a/src/chcon.c b/src/chcon.c
> index fbfdb4d..c0da694 100644
> --- a/src/chcon.c
> +++ b/src/chcon.c
> @@ -519,6 +519,10 @@ main (int argc, char **argv)
>        usage (EXIT_FAILURE);
>      }
> 
> +  if (is_selinux_enabled () != 1)
> +    error (EXIT_FAILURE, 0,
> +           _("%s may be used only on a SELinux kernel"), program_name);
> +
>    if (reference_file)
>      {
>        if (getfilecon (reference_file, &ref_context) < 0)
> diff --git a/src/runcon.c b/src/runcon.c
> index e0019da..f87eada 100644
> --- a/src/runcon.c
> +++ b/src/runcon.c
> @@ -195,7 +195,7 @@ main (int argc, char **argv)
> 
>    if (is_selinux_enabled () != 1)
>      error (EXIT_FAILURE, 0,
> -           _("runcon may be used only on a SELinux kernel"));
> +           _("%s may be used only on a SELinux kernel"), program_name);
> 
>    if (context)
>      {
> --
> 1.6.5.rc2.204.g8ea19
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
