Subject: Re: [PATCH] policycoreutils: setfiles - Add option to stop setting
 the digest
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1474814972-7216-1-git-send-email-richard_c_haines@btinternet.com>
 <aa582df5-aea9-c733-db52-b23df736a951@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <822d35ef-cf65-1a1c-c2a1-1886a4fdf841@tycho.nsa.gov>
Date: Fri, 30 Sep 2016 10:53:05 -0400
MIME-Version: 1.0
In-Reply-To: <aa582df5-aea9-c733-db52-b23df736a951@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/30/2016 10:44 AM, Stephen Smalley wrote:
> On 09/25/2016 10:49 AM, Richard Haines wrote:
>> Add -D option to setfiles and restorecon - Do not set or update
>> directory SHA1 digests when relabeling files. This will allow
>> users the option of not using the "security.restorecon_last"
>> extended attribute feature.
>>
>> Also review and update the man pages.
> 
> I think we need to flip the default here.  Rationale:
> 1) Users often use restorecon to fix labels on files whose labels are
> wrong even through nothing has changed in file_contexts, e.g. after
> copying/moving files to a different location.  They won't expect
> restorecon to suddenly stop relabeling by default because the hash of
> file_contexts hasn't changed.
> 
> 2) Only processes running with CAP_SYS_ADMIN can set
> security.restorecon_last, so this will fail for non-root users anyway.
> 
> Any objection?

I guess (2) means that (1) won't be a problem for non-root users, since
the attribute won't ever be set. But typical instructions for fixing
labels on files copied manually to /var/www are restorecon -R /var/www,
and now we'll get this:
# restorecon -R /var/www
# restorecon -R /var/www
Skipping restorecon as matching digest on: /var/www

With no hint to the user on how to force it to happen.

> 
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  policycoreutils/setfiles/restorecon.8 |  76 ++++++++++++++++-----
>>  policycoreutils/setfiles/setfiles.8   | 122 +++++++++++++++++++++++++---------
>>  policycoreutils/setfiles/setfiles.c   |  26 +++++---
>>  3 files changed, 167 insertions(+), 57 deletions(-)
>>
>> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
>> index 4851f0f..f996467 100644
>> --- a/policycoreutils/setfiles/restorecon.8
>> +++ b/policycoreutils/setfiles/restorecon.8
>> @@ -4,10 +4,33 @@ restorecon \- restore file(s) default SELinux security contexts.
>>  
>>  .SH "SYNOPSIS"
>>  .B restorecon
>> -.I [\-R] [\-m] [\-n] [\-p] [\-v] [\-I] [\-e directory] pathname...
>> +.RB [ \-r | \-R ]
>> +.RB [ \-m ]
>> +.RB [ \-n ]
>> +.RB [ \-p ]
>> +.RB [ \-v ]
>> +.RB [ \-i ]
>> +.RB [ \-F ]
>> +.RB [ \-W ]
>> +.RB [ \-I | \-D ]
>> +.RB [ \-e
>> +.IR directory ]
>> +.IR pathname \ ...
>>  .P
>>  .B restorecon
>> -.I \-f infilename [\-e directory] [\-R] [\-m] [\-n] [\-p] [\-v] [\-F] [\-I]
>> +.RB [ \-f
>> +.IR infilename ]
>> +.RB [ \-e
>> +.IR directory ]
>> +.RB [ \-r | \-R ]
>> +.RB [ \-m ]
>> +.RB [ \-n ]
>> +.RB [ \-p ]
>> +.RB [ \-v ]
>> +.RB [ \-i ]
>> +.RB [ \-F ]
>> +.RB [ \-W ]
>> +.RB [ \-I | \-D ]
>>  
>>  .SH "DESCRIPTION"
>>  This manual page describes the
>> @@ -18,14 +41,22 @@ This program is primarily used to set the security context
>>  (extended attributes) on one or more files.
>>  .P
>>  It can also be run at any other time to correct inconsistent labels, to add
>> -support for newly-installed policy or, by using the \-n option, to passively
>> +support for newly-installed policy or, by using the
>> +.B \-n
>> +option, to passively
>>  check whether the file contexts are all set as specified by the active policy
>>  (default behavior).
>>  .P
>> -If a file object does not have a context, restorecon will write the default
>> +If a file object does not have a context,
>> +.B restorecon
>> +will write the default
>>  context to the file object's extended attributes. If a file object has a
>> -context, restorecon will only modify the type portion of the security context.
>> -The \-F option will force a replacement of the entire context.
>> +context,
>> +.B restorecon
>> +will only modify the type portion of the security context.
>> +The
>> +.B \-F
>> +option will force a replacement of the entire context.
>>  .P
>>  It is the same executable as
>>  .BR setfiles
>> @@ -33,11 +64,15 @@ but operates in a slightly different manner depending on its argv[0].
>>  
>>  .SH "OPTIONS"
>>  .TP
>> -.B \-e directory
>> +.BI \-e \ directory
>>  exclude a directory (repeat the option to exclude more than one directory, Requires full path).
>>  .TP
>> -.B \-f infilename
>> -infilename contains a list of files to be processed. Use \- for stdin.
>> +.BI \-f \ infilename
>> +.I infilename
>> +contains a list of files to be processed. Use
>> +.RB \*(lq \- \*(rq
>> +for
>> +.BR stdin .
>>  .TP
>>  .B \-F
>>  Force reset of context to match file_context for customizable files, and the
>> @@ -56,6 +91,14 @@ there are no errors. See the
>>  .B NOTES
>>  section for further details.
>>  .TP
>> +.B \-D
>> +do not set or update any directory SHA1 digests. Use this option to
>> +effectively disable usage of the
>> +.IR security.restorecon_last
>> +extended attribute. Note that using this option will override the
>> +.B \-I
>> +option.
>> +.TP
>>  .B \-m
>>  do not read
>>  .B /proc/mounts
>> @@ -64,9 +107,10 @@ Setting this option is useful where there is a non-seclabel fs mounted with a
>>  seclabel fs mounted on a directory below this.
>>  .TP
>>  .B \-n
>> -don't change any file labels (passive check).  To display the files whose labels would be changed, add \-v.
>> +don't change any file labels (passive check).  To display the files whose labels would be changed, add
>> +.BR \-v .
>>  .TP
>> -.B \-o outfilename
>> +.BI \-o \ outfilename
>>  Deprecated, SELinux policy will probably block this access.  Use shell redirection to save list of files with incorrect context in filename.
>>  .TP
>>  .B \-p
>> @@ -106,7 +150,7 @@ option of GNU
>>  produces input suitable for this mode.
>>  .TP
>>  .SH "ARGUMENTS"
>> -.B pathname...
>> +.IR pathname \ ...
>>  The pathname for the file(s) to be relabeled.
>>  .SH "NOTES"
>>  .IP "1." 4
>> @@ -115,7 +159,7 @@ does not follow symbolic links and by default it does not
>>  operate recursively on directories.
>>  .IP "2." 4
>>  If the
>> -.B pathname
>> +.I pathname
>>  specifies the root directory and the
>>  .B \-vR
>>  or
>> @@ -135,12 +179,12 @@ will write an SHA1 digest of the default specfiles set to an extended
>>  attribute named
>>  .IR security.restorecon_last
>>  to the directory specified in each
>> -.B pathname...
>> +.IR pathname \ ...
>>  once the relabeling has been completed successfully. This digest will be
>>  checked should
>>  .B restorecon
>>  be rerun with the same
>> -.B pathname
>> +.I pathname
>>  parameters. See
>>  .BR selinux_restorecon (3)
>>  for further details.
>> @@ -148,7 +192,7 @@ for further details.
>>  The
>>  .B \-I
>>  option will ignore the SHA1 digest from each directory specified in
>> -.B pathname...
>> +.IR pathname \ ...
>>  and provided the
>>  .B \-n
>>  option is NOT set and recursive mode is set, files will be relabeled as
>> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
>> index 35e38b2..11bc335 100644
>> --- a/policycoreutils/setfiles/setfiles.8
>> +++ b/policycoreutils/setfiles/setfiles.8
>> @@ -4,7 +4,23 @@ setfiles \- set SELinux file security contexts.
>>  
>>  .SH "SYNOPSIS"
>>  .B setfiles
>> -.I [\-c policy] [\-d] [\-l] [\-m] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] [\-I] spec_file pathname...
>> +.RB [ \-c
>> +.IR policy ]
>> +.RB [ \-d ]
>> +.RB [ \-l ]
>> +.RB [ \-m ]
>> +.RB [ \-n ]
>> +.RB [ \-e
>> +.IR directory ]
>> +.RB [ \-p ]
>> +.RB [ \-s ]
>> +.RB [ \-v ]
>> +.RB [ \-W ]
>> +.RB [ \-F ]
>> +.RB [ \-I | \-D ]
>> +.I spec_file
>> +.IR pathname \ ...
>> +
>>  .SH "DESCRIPTION"
>>  This manual page describes the
>>  .BR setfiles
>> @@ -16,14 +32,24 @@ them).  Usually it is initially run as part of the SELinux installation
>>  process (a step commonly known as labeling).
>>  .P
>>  It can also be run at any other time to correct inconsistent labels, to add
>> -support for newly-installed policy or, by using the \-n option, to passively
>> +support for newly-installed policy or, by using the
>> +.B \-n
>> +option, to passively
>>  check whether the file contexts are all set as specified by the active policy
>> -(default behavior) or by some other policy (see the \-c option).
>> +(default behavior) or by some other policy (see the
>> +.B \-c
>> +option).
>>  .P
>> -If a file object does not have a context, setfiles will write the default
>> +If a file object does not have a context,
>> +.B setfiles
>> +will write the default
>>  context to the file object's extended attributes. If a file object has a
>> -context, setfiles will only modify the type portion of the security context.
>> -The \-F option will force a replacement of the entire context.
>> +context,
>> +.B setfiles
>> +will only modify the type portion of the security context.
>> +The
>> +.B \-F
>> +option will force a replacement of the entire context.
>>  .SH "OPTIONS"
>>  .TP
>>  .B \-c
>> @@ -33,11 +59,15 @@ check the validity of the contexts against the specified binary policy.
>>  show what specification matched each file (do not abort validation
>>  after ABORT_ON_ERRORS errors).
>>  .TP
>> -.B \-e directory
>> +.BI \-e \ directory
>>  directory to exclude (repeat option for more than one directory).
>>  .TP
>> -.B \-f
>> -take a list of files to be processed from an input file.
>> +.BI \-f \ infilename
>> +.I infilename
>> +contains a list of files to be processed. Use
>> +.RB \*(lq \- \*(rq
>> +for
>> +.BR stdin .
>>  .TP
>>  .B \-F
>>  Force reset of context to match file_context for customizable files, and the
>> @@ -57,6 +87,14 @@ there are no errors. See the
>>  .B NOTES
>>  section for further details.
>>  .TP
>> +.B \-D
>> +do not set or update any directory SHA1 digests. Use this option to
>> +effectively disable usage of the
>> +.IR security.restorecon_last
>> +extended attribute. Note that using this option will override the
>> +.B \-I
>> +option.
>> +.TP
>>  .B \-l
>>  log changes in file labels to syslog.
>>  .TP
>> @@ -70,7 +108,7 @@ seclabel fs mounted on a directory below this.
>>  .B \-n
>>  don't change any file labels (passive check).
>>  .TP
>> -.B \-o filename
>> +.BI \-o \ filename
>>  Deprecated, SELinux policy will probably block this access.  Use shell redirection to save list of files with incorrect context in filename.
>>  .TP
>>  .B \-p
>> @@ -84,15 +122,18 @@ options are mutually exclusive.
>>  .B \-q
>>  Deprecated, was only used to stop printing inode association parameters.
>>  .TP 
>> -.B \-r rootpath
>> +.BI \-r \ rootpath
>>  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
>>  to label files under
>> -.B rootpath
>> -as if they were at /
>> +.I rootpath
>> +as if they were at
>> +.B /
>>  .TP 
>>  .B \-s
>>  take a list of files from standard input instead of using a pathname from the
>> -command line (equivalent to \-f \-).
>> +command line (equivalent to
>> +.RB \*(lq "\-f \-" \*(rq
>> +).
>>  .TP
>>  .B \-v
>>  show changes in file labels and output any inode association parameters.
>> @@ -120,26 +161,43 @@ option of GNU
>>  produces input suitable for this mode.
>>  
>>  .SH "ARGUMENTS"
>> -.B spec_file
>> -The specification file which contains lines of the following form
>> -.br
>> -.B regexp [ \-type ] ( context | <<none>> )
>> -.br
>> -The regular expression is anchored at both ends.  The optional type field 
>> -specifies the file type as shown in the mode field by the
>> -.B ls(1)
>> -program, e.g. \-\- to match only regular files or \-d to match only
>> -directories.  The context can be an ordinary security context or the
>> -string <<none>> to specify that the file is not to have its context
>> +.TP
>> +.I spec_file
>> +The specification file which contains lines of the following form:
>> +.sp
>> +.RS
>> +.I regexp
>> +.RI [ type ]
>> +.IR context \ |
>> +.B <<none>>
>> +.RS
>> +The regular expression is anchored at both ends.  The optional
>> +.I type
>> +field specifies the file type as shown in the mode field by the
>> +.BR ls (1)
>> +program, e.g.
>> +.B \-\-
>> +to match only regular files or
>> +.B \-d
>> +to match only
>> +directories.  The
>> +.I context
>> +can be an ordinary security context or the
>> +string
>> +.B <<none>>
>> +to specify that the file is not to have its context
>>  changed.
>>  .br
>>  The last matching specification is used. If there are multiple hard
>>  links to a file that match different specifications and those
>>  specifications indicate different security contexts, then a warning is
>>  displayed but the file is still labeled based on the last matching
>> -specification other than <<none>>.
>> +specification other than
>> +.BR <<none>> \|.
>> +.RE
>> +.RE
>>  .TP 
>> -.B pathname...
>> +.IR pathname \ ...
>>  The pathname for the root directory of each file system to be relabeled
>>  or a specific directory within a filesystem that should be recursively
>>  descended and relabeled or the pathname of a file that should be
>> @@ -156,7 +214,7 @@ option is used.
>>  follows symbolic links and operates recursively on directories.
>>  .IP "2." 4
>>  If the
>> -.B pathname
>> +.I pathname
>>  specifies the root directory and the
>>  .B \-v
>>  option is set and the audit system is running, then an audit event is
>> @@ -171,15 +229,15 @@ will write an SHA1 digest of the
>>  set to an extended attribute named
>>  .IR security.restorecon_last
>>  to the directory specified in each
>> -.B pathname...
>> +.IR pathname \ ...
>>  once the relabeling has been completed successfully. This digest will be
>>  checked should
>>  .B setfiles
>>  be rerun
>>  with the same
>> -.B spec_file
>> +.I spec_file
>>  and
>> -.B pathname
>> +.I pathname
>>  parameters. See
>>  .BR selinux_restorecon (3)
>>  for further details.
>> @@ -187,7 +245,7 @@ for further details.
>>  The
>>  .B \-I
>>  option will ignore the SHA1 digest from each directory specified in
>> -.B pathname...
>> +.IR pathname \ ...
>>  and provided the
>>  .B \-n
>>  option is NOT set, files will be relabeled as required with the digest then
>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>> index b700228..520866e 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -17,6 +17,7 @@
>>  static char *policyfile;
>>  static int warn_no_match;
>>  static int null_terminated;
>> +static int request_digest;
>>  static struct restore_opts r_opts;
>>  static int nerr;
>>  
>> @@ -42,14 +43,14 @@ void usage(const char *const name)
>>  {
>>  	if (iamrestorecon) {
>>  		fprintf(stderr,
>> -			"usage:  %s [-iIFmnprRv0] [-e excludedir] pathname...\n"
>> -			"usage:  %s [-iIFmnprRv0] [-e excludedir] -f filename\n",
>> +			"usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
>> +			"usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
>>  			name, name);
>>  	} else {
>>  		fprintf(stderr,
>> -			"usage:  %s [-diIlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
>> -			"usage:  %s [-diIlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
>> -			"usage:  %s -s [-diIlmnpqvFW] spec_file\n"
>> +			"usage:  %s [-diIDlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
>> +			"usage:  %s [-diIDlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
>> +			"usage:  %s -s [-diIDlmnpqvFW] spec_file\n"
>>  			"usage:  %s -c policyfile spec_file\n",
>>  			name, name, name, name);
>>  	}
>> @@ -147,8 +148,8 @@ int main(int argc, char **argv)
>>  	size_t buf_len;
>>  	const char *base;
>>  	int mass_relabel = 0, errors = 0;
>> -	const char *ropts = "e:f:hiIlmno:pqrsvFRW0";
>> -	const char *sopts = "c:de:f:hiIlmno:pqr:svFR:W0";
>> +	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0";
>> +	const char *sopts = "c:de:f:hiIDlmno:pqr:svFR:W0";
>>  	const char *opts;
>>  
>>  	/* Initialize variables */
>> @@ -156,6 +157,7 @@ int main(int argc, char **argv)
>>  	altpath = NULL;
>>  	null_terminated = 0;
>>  	warn_no_match = 0;
>> +	request_digest = 1;
>>  	policyfile = NULL;
>>  	nerr = 0;
>>  
>> @@ -278,6 +280,12 @@ int main(int argc, char **argv)
>>  			r_opts.ignore_digest =
>>  					   SELINUX_RESTORECON_IGNORE_DIGEST;
>>  			break;
>> +		case 'D': /*
>> +			   * Don't request file_contexts digest in selabel_open
>> +			   * This will effectively disable usage of the
>> +			   * security.restorecon_last extended attribute.
>> +			   */
>> +			request_digest = 0;
>>  		case 'l':
>>  			r_opts.syslog_changes =
>>  					   SELINUX_RESTORECON_SYSLOG_CHANGES;
>> @@ -409,9 +417,9 @@ int main(int argc, char **argv)
>>  	} else if (argc == 1)
>>  		usage(argv[0]);
>>  
>> -	/* Set selabel_open options. Always request a digest. */
>> +	/* Set selabel_open options. */
>>  	r_opts.selabel_opt_validate = (ctx_validate ? (char *)1 : NULL);
>> -	r_opts.selabel_opt_digest = (char *)1;
>> +	r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
>>  	r_opts.selabel_opt_path = altpath;
>>  
>>  	if (nerr)
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
