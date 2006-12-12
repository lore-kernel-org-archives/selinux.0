Subject: Re: Patch to load_policy to enforce quiet option
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4576FAFC.90809@mentalrootkit.com>
References: <456E06BE.1030007@redhat.com> <456F0580.7070003@tresys.com>
	 <456F0D94.2030407@redhat.com>  <4576FAFC.90809@mentalrootkit.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:01:59 -0500
Message-Id: <1165946519.998.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-06 at 12:16 -0500, Karl MacMillan wrote:
> Daniel J Walsh wrote:
> > Joshua Brindle wrote:
> >> Daniel J Walsh wrote:
> >>>
> >>>
> >>> ------------------------------------------------------------------------
> >>>
> >>> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
> >>> --exclude='*.pot' -N -u -r 
> >>> nsapolicycoreutils/load_policy/load_policy.c 
> >>> policycoreutils-1.33.5/load_policy/load_policy.c
> >>> --- nsapolicycoreutils/load_policy/load_policy.c    2006-11-16 
> >>> 17:14:31.000000000 -0500
> >>> +++ policycoreutils-1.33.5/load_policy/load_policy.c    2006-11-28 
> >>> 10:44:25.000000000 -0500
> >>> @@ -50,12 +50,12 @@
> >>>      nargs = argc - optind;
> >>>      if (nargs > 2)
> >>>          usage(argv[0]);
> >>> -    if (nargs >= 1) {
> >>> -        fprintf(stderr,
> >>> -            "%s:  Warning!  Policy file argument (%s) is no longer 
> >>> supported, installed policy is always loaded.  Continuing...\n",
> >>> -            argv[0], argv[optind++]);
> >>> +    if (nargs >= 1 && !quiet) {
> >>> +            fprintf(stderr,
> >>> +                "%s:  Warning!  Policy file argument (%s) is no 
> >>> longer supported, installed policy is always loaded.  Continuing...\n",
> >>> +                argv[0], argv[optind++]);
> >>>      }
> >>> -    if (nargs == 2) {
> >>> +    if (nargs == 2 && ! quiet) {
> >>>          fprintf(stderr,
> >>>              "%s:  Warning!  Boolean file argument (%s) is no longer 
> >>> supported, installed booleans file is always used.  Continuing...\n",
> >>>              argv[0], argv[optind++]);
> >>
> >>
> >> Hrm. Should quiet really squelch warnings? Also, it looks like 
> >> load_policy is using a deprecated interface to squelch other output 
> >> from libsepol, this should probably be fixed.
> >>
> > man load_policy
> > ...
> >      -q     suppress warning messages.
> > ...
> > 
> > 
> > I think this was originally added to stop things like boolean is no 
> > longer in this package.  It might not be necessary any longer,  but if 
> > we have it we should be consistant.
> > 
> 
> What is the status of this? I'm fine with the patch, but I didn't see it 
> get merged or any resolution.

The patch is ok.  Separate patch to remove or replace the sepol_debug()
call would be appropriate, but likely requires a bit of examination of
the impact - even with the modern policy loading logic, load policy will
end up triggering a sepol_genbools_array() call to preserve active
boolean settings, and that will emit warnings about removed booleans
unless some action is taken to suppress them (modern interface for doing
that would be sepol_msg_set_callback()).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
