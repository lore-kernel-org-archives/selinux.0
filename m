Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6NKwpB8005781
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2012 16:58:51 -0400
Message-ID: <1343077125.2539.27.camel@vortex>
Subject: Re: [PATCH]: allow setfiles to continue on errors (new option)
From: Guido Trentalancia <guido@trentalancia.com>
To: Pat McClory <pmcclory@tresys.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 23 Jul 2012 22:58:45 +0200
In-Reply-To: <500D6E14.4030907@tresys.com>
References: <1342876779.7185.0.camel@vortex> <500D6E14.4030907@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Pat.

Thanks for your comments.

On Mon, 2012-07-23 at 11:30 -0400, Pat McClory wrote:
> On 07/21/2012 09:19 AM, Guido Trentalancia wrote:
> > Add a command-line option to setfiles to disable program abortion
> > after 10 errors (e.g. invalid contexts).
> >
> > Signed-off-by: Guido Trentalancia<guido@trentalancia.com>
> >
> > ---
> >   policycoreutils/setfiles/restore.o  |binary
> >   policycoreutils/setfiles/restorecon |binary
> >   policycoreutils/setfiles/setfiles   |binary
> >   policycoreutils/setfiles/setfiles.8 |    3 +++
> >   policycoreutils/setfiles/setfiles.c |   11 +++++++----
> >   policycoreutils/setfiles/setfiles.o |binary
> >   6 files changed, 10 insertions(+), 4 deletions(-)

Oops. I am sorry, please just ignore them.

> probably don't want object files and executables appearing in the diff.
> 
> > diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.8 selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8
> > --- selinux-20072012/policycoreutils/setfiles/setfiles.8	2012-06-18 18:54:45.764500252 +0200
> > +++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8	2012-07-21 12:43:04.108000002 +0200
> > @@ -43,6 +43,9 @@ use an alternate root path
> >   .TP
> >   .B \-e directory
> >   directory to exclude (repeat option for more than one directory.)
> > +.TP
> > +.B \-C
> > +continue on errors (instead of aborting after 10 errors).
> >   .TP
> >   .B \-F
> >   Force reset of context to match file_context for customizable files
> > diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.c selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c
> > --- selinux-20072012/policycoreutils/setfiles/setfiles.c	2012-06-18 18:54:45.764500252 +0200
> > +++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c	2012-07-21 12:42:15.610999907 +0200
> > @@ -43,9 +43,9 @@ void usage(const char *const name)
> >   			name);
> >   	} else {
> >   		fprintf(stderr,
> > -			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> > +			"usage:  %s [-dnpqvCW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> >   			"usage:  %s -c policyfile spec_file\n"
> > -			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
> > +			"usage:  %s -s [-dnpqvCW] [-o filename ] spec_file\n", name, name,
> >   			name);
> >   	}
> >   	exit(1);
> > @@ -56,7 +56,7 @@ static int nerr = 0;
> >   void inc_err()
> >   {
> >   	nerr++;
> > -	if (nerr>  9&&  !r_opts.debug) {
> > +	if (nerr>  9&&  !r_opts.debug&&  r_opts.abort_on_error) {
> >   		fprintf(stderr, "Exiting after 10 errors.\n");
> >   		exit(1);
> >   	}
> > @@ -217,7 +217,7 @@ int main(int argc, char **argv)
> >   	exclude_non_seclabel_mounts();
> >
> >   	/* Process any options. */
> > -	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0"))>  0) {
> > +	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:CFRW0"))>  0) {
> 
> I think it's confusing that there are now two options that control 
> whether or not to exit after 10 errors.  I think the man page should be 
> updated to reflect that -d implies -C.

Yes, you're right, I didn't notice that, mostly because I trusted too
much the wording "debug" as being something related to producing more
verbose output or some other functionality related to the usual meaning
of the word in similar contexts and even more catastrophically I did
then fully trust the actual manual page description of the option.

In truth the problem is not just related to "debugging" but also to
"fixing" the filesystem as invalid contexts might be due to an improper
policy installation (e.g. begin a new policy + do not relabel or system
crashes or new policy loading fails for some reason at the next reboot =
the system needs to be fixed after rebooting and there might be invalid
contexts around).

Given the above, it's better to ignore the whole patch and perhaps just
give a better documentation of -d (or at most, add -C as an alias to -d
in the switch block).

I think there is at least one more in-congruence in the documentation,
as far as I remember, the -0 option is only documented in one of the two
manual pages.

> >   		switch (opt) {
> >   		case 'c':
> >   			{
> > @@ -274,6 +274,9 @@ int main(int argc, char **argv)
> >   		case 'l':
> >   			r_opts.logging = 1;
> >   			break;
> > +		case 'C':
> > +			r_opts.abort_on_error = 0;
> > +			break;
> 
> b/c -C is only an option for setfiles, I think there should be an
> 
> if (iamrestorecon)
>      usage(argv[0]);

To be honest, at the moment, I think restorecon does not produce any
usage message when called without arguments (so that at first, to get
one, I had to fool it by using an invalid option such as -h). If you
don't mind, I'll check what exactly is going on tomorrow as I am quite
sure that's not the way it was intended to behave when it was created...

By the way, I was also thinking about de-hardcoding the number of errors
value of 10 (by using a #define), in order to improve style, readability
and so on.

> block in this case (like there is for -c)
> 
> >   		case 'F':
> >   			r_opts.force = 1;
> >   			break;
> >
> >

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
