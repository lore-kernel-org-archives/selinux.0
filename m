Subject: Re: [PATCH 3/4] newrole suid functionality (take 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <454A568C.3060201@us.ibm.com>
References: <45351FC9.2080204@us.ibm.com>  <45352427.20705@us.ibm.com>
	 <1161630359.3316.127.camel@moss-spartans.epoch.ncsc.mil>
	 <454A2966.5050702@us.ibm.com>
	 <1162492463.5519.23.camel@moss-spartans.epoch.ncsc.mil>
	 <454A568C.3060201@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 15:54:20 -0500
Message-Id: <1162500860.5519.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 14:35 -0600, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > On Thu, 2006-11-02 at 11:22 -0600, Michael C Thompson wrote:
> >> Stephen Smalley wrote:
> >>> On Tue, 2006-10-17 at 13:42 -0500, Michael C Thompson wrote:
> >>>> Michael C Thompson wrote:
> >>>>> This is the intro to a set of four patches.
> >>>>>
> >>>>> These patches are an attempt to make newrole be an acceptably secure 
> >>>>> suid root program, to provide it with the capabilities to generate audit 
> >>>>> records (existing) and handle polyinstatiation (new).
> >>>>>
> >>>>> The 4 patches are as follows:
> >>>>> 1) New functions introduced to newrole.c, new and existing functionality
> >>>>> 2) Changes to existing functions in newrole.c
> >>>>> 3) Updates to main in newrole.c to use the aforementioned changes
> >>>> This is the 3rd of 4 patches.
> >>>> This patch applies against policycoreutils-1.30.30-1.
> >>>>
> >>>> Changes:
> >>>>   * main is changed in the following ways:
> >>>>     - remove the duplicated functionality from patch 1/4
> >>>>     - set to call the new functions from patch 1/4
> >>>>     - set to use changes to functions in patch 2/4
> >>>>     - introduces better error handling and cleanup paths
> >>>>
> >>>> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>
> >>> diff -Naur policycoreutils-1.30.30.orig/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> >>> --- policycoreutils-1.30.30.orig/newrole/newrole.c	2006-10-17 13:15:20.000000000 -0500
> >>> +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-17 13:15:03.000000000 -0500
> >>> @@ -897,47 +898,43 @@
> >>>  
> >>>  int main(int argc, char *argv[])
> >>> <snip>
> >>> +	/*
> >>> +	 * Step 0: Setup
> >>> +	 *
> >>> +	 * Do some intial setup, including dropping capabilities, checking
> >>> +	 * if it makes sense to continue to run newrole, and setting up
> >>> +	 * a scrubbed environment.
> >>> +	 */
> >>> +	if (set_signal_handles())
> >>> +		return -1;
> >>> +	if (drop_capabilities())
> >>> +		return -1;
> >>>
> >>> I'd keep drop_capabilities() first, as it was before this patch.
> >>> It would also make sense to move up sanitize_environment() as soon as
> >>> possible, even if that means splitting it into two phases (in particular
> >>> considering the locale support).
> >> Would this order be acceptable?
> >>
> >> drop_cap
> >> set_signal_handlers
> >> setlocale
> >> sanitize_env
> >>
> >> ...
> >>
> >> I'm not familiar with locale enough to understand your point above, but 
> >> I imagine doing environ = NULL will mess up the locale, but I am not 
> >> sure. If that is right, we need to do it before we sanitize the 
> >> environment, right?
> > 
> > Completely purging the environment could break that functionality, yes.
> > On the other hand, blindly accepting the locale-related environment
> > settings can be a risk.  See:
> > http://www.dwheeler.com/secure-programs/Secure-Programs-HOWTO/locale.html
> 
> So, based on reading this, and reviewing code from su and login, what 
> seems to be the reasonable approach is the following:
> 
> drop_capabilities();
> set_signal_handles();
> setlocale(LC_ALL, "");
> bindtextdomain(PACKAGE, LOCALEDIR);
> textdomain(PACKAGE);
> sanitize_environment();
> 
> Obviously, this isn't a patch, but this is the guts of the change. I'm 
> not really sure if bindtextdomain relies on NLSPATH still like "Secure 
> Programs HOWTO" states, but apparently when newrole is SUID, it will 
> ignore NLSPATH so we need not worry about that.
> 
> There is no use of any of the locale-related information before the 
> setlocale call, which re-initializes the values (as is my understanding 
> from reading the code... I can't stand glibc's formatting).

The man page for setlocale() says:
	If locale is "", each part of the locale that should be modified is set
according to the environment variables.

Which doesn't sound like it is sanitizing them.  Possibly it has
different behavior in the libc_enable_secure case, which would be 1 for
newrole (even the non-suid newrole, due to the domain transition), but I
don't know offhand.  NLSPATH is on the unsecvars list, so it would be
ignored.

> There isn't any propsed change in this code, just a better understanding 
> from the coder. If this is suggested code flow looks OK, I will clean up 
> the rest of my code and send out the next round of patches.

I take it that su and friends don't do anything special here prior to
calling the localization functions?
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
