Message-ID: <4D78E7D9.20909@redhat.com>
Date: Thu, 10 Mar 2011 10:01:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: selinux_file_context_verify function returns wrong value.
References: <517317.65701.qm@web87008.mail.ird.yahoo.com>
In-Reply-To: <517317.65701.qm@web87008.mail.ird.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/09/2011 11:34 AM, Richard Haines wrote:
> I thought I would have a go at fixing the problem so here is a patch that may be acceptable. I've tested it on libselinux 2.0.98 and 2.0.99.
> 
> selinux_file_context_verify(3) should now return the correct codes and matchpathcon(8) has been modified to handle them.
> 
> The selinux_file_context_verify(3)and selinux_file_context_cmp(3) man pages have also been updated (re-written really) to correct return codes.
> 
> I found that selabel_open left errno set to ENOENT because a file_contexts.subs file did not exist on my system, but left selabel_open alone and set errno = 0 before calling selinux_filecontext_cmp.
> 
> 
> diff --git a/include/selinux/selinux.h b/include/selinux/selinux.h
> index 0725b57..6627f7d 100644
> --- a/include/selinux/selinux.h
> +++ b/include/selinux/selinux.h
> @@ -562,7 +562,7 @@ extern int selinux_file_context_cmp(const security_context_t a,
>  
>  /* 
>   * Verify the context of the file 'path' against policy.
> - * Return 0 if correct. 
> + * Return 1 if match, 0 if not and -1 on error. 
>   */
>  extern int selinux_file_context_verify(const char *path, mode_t mode);
>  
> diff --git a/man/man3/selinux_file_context_cmp.3 b/man/man3/selinux_file_context_cmp.3
> index 51e8c20..048ef45 100644
> --- a/man/man3/selinux_file_context_cmp.3
> +++ b/man/man3/selinux_file_context_cmp.3
> @@ -1,25 +1,76 @@
> -.TH "selinux_file_context_cmp" "3" "21 November 2009" "sds@tycho.nsa.gov" "SELinux API documentation"
> +.TH "selinux_file_context_cmp" "3" "08 March 2011" "SELinux API documentation"
> +
>  .SH "NAME"
> -selinux_file_context_cmp, selinux_file_context_verify \- comparison of two file contexts.
> +selinux_file_context_cmp \- Compare two SELinux security contexts excluding the 'user' component.
>  
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
>  .sp
> -
> -.BI "int selinux_file_context_cmp(const security_context_t " a ", const security_context_t " b ");"
> -
> -.BI "int selinux_file_context_verify(const char *" path ", mode_t " mode ");"
> +.BI "int selinux_file_context_cmp(const security_context_t " a ", "
> +.RS
> +.BI "const security_context_t " b ");"
> +.RE
>  
>  .SH "DESCRIPTION"
>  .B selinux_file_context_cmp
> -compares two file contexts to see if their differences are "significant", the function runs the strcmp function ignoring the user componant of the file context.  
> -.sp
> -.B selinux_file_context_verify
> -compares the file context on disk to the system default.
> +compares two context strings excluding the user component with
> +.B strcmp(3)
> +as shown in the
> +.B EXAMPLE
> +section.
>  .sp
> +This is useful as for most object contexts, the user component is not relevant.
>  
>  .SH "RETURN VALUE"
> -Returns zero on success or \-1 otherwise.
> +The return values follow the
> +.B strcmp(3)
> +function, where:
> +.RS
> +0  if they are equal.
> +.RE
> +.RS
> +1  if
> +.I a
> +is greater than
> +.I b
> +.RE
> +.RS
> +\-1 if
> +.I a
> +is less than
> +.I b
> +.RE
> +
> +.SH "ERRORS"
> +None.
> +
> +.SH "NOTES"
> +The contexts being compared do not specifically need to be file contexts.
> +
> +.SH "EXAMPLE"
> +If context
> +.I a
> +is:
> +.RS
> +user_u:user_r:user_t:s0
> +.RE
> +.sp
> +and context
> +.I b
> +is:
> +.RS
> +root:user_r:user_t:s0
> +.RE
> +.sp
> +then the actual strings compared are:
> +.RS
> +:user_r:user_t:s0 and :user_r:user_t:s0
> +.RE
> +.sp
> +Therefore they will match and
> +.B selinux_file_context_cmp
> +will return zero.
>  
>  .SH "SEE ALSO"
> -.BR selinux "(8), " selinux_lsetfilecon "(3), " matchpathcon "(3), " freecon "(3), " setfilecon "(3), " setfscreatecon "(3)"
> +.BR selinux "(8)"
> +
> diff --git a/man/man3/selinux_file_context_verify.3 b/man/man3/selinux_file_context_verify.3
> index d777547..fcc716d 100644
> --- a/man/man3/selinux_file_context_verify.3
> +++ b/man/man3/selinux_file_context_verify.3
> @@ -1 +1,99 @@
> -.so man3/selinux_file_context_cmp.3
> +.TH "selinux_file_context_verify" "3" "08 March 2011" "SELinux API documentation"
> +
> +.SH "NAME"
> +selinux_file_context_verify \- Compare the SELinux security context on disk to the default security context required by the policy file contexts file. 
> +
> +.SH "SYNOPSIS"
> +.B #include <selinux/selinux.h>
> +.sp
> +.BI "int selinux_file_context_verify(const char *" path ", mode_t " mode ");"
> +
> +.SH "DESCRIPTION"
> +.B selinux_file_context_verify
> +compares the context of the specified 
> +.I path
> +that is held on disk (in the extended attribute), to the system default entry held in the file contexts series of files.
> +.sp
> +The 
> +.I mode
> +may be zero.
> +.sp
> +Note that the two contexts are compared for "significant" differences (i.e. the user component of the contexts are ignored) as shown in the
> +.B EXAMPLE
> +section.
> +
> +.SH "RETURN VALUE"
> +If the contexts significantly match, 1 (one) is returned. 
> +.sp
> +If the contexts do not match 0 (zero) is returned and 
> +.I errno
> +is set to either
> +.B ENOENT
> +or 
> +.B EINVAL
> +for the reasons listed in the 
> +.B ERRORS
> +section, or if 
> +.I errno
> += 0 then the contexts did not match.
> +.sp
> +On failure \-1 is returned and 
> +.I errno
> +set appropriately.
> +
> +.SH "ERRORS"
> +.TP
> +.B ENOTSUP
> +if extended attributes are not supported by the file system.
> +.TP
> +.B ENOENT
> +if there is no entry in the file contexts series of files or 
> +.I path
> +does not exist.
> +.TP
> +.B EINVAL
> +if the entry in the file contexts series of files or 
> +.I path
> +are invalid, or the returned context fails validation.
> +.TP
> +.B ENOMEM
> +if attempt to allocate memory failed.
> +
> +.SH "FILES"
> +The following configuration files (the file contexts series of files) supporting the active policy will be used (should they exist) to determine the 
> +.I path
> +default context:
> +.sp
> +.RS
> +contexts/files/file_contexts - This file must exist.
> +.sp
> +contexts/files/file_contexts.local - If exists has local customizations.
> +.sp
> +contexts/files/file_contexts.homedirs - If exists has users home directory customizations.
> +.sp
> +contexts/files/file_contexts.subs - If exists has substitutions that are then applied to the 'in memory' version of the file contexts files.
> +.RE
> +
> +.SH "EXAMPLE"
> +If the files context is:
> +.RS
> +unconfined_u:object_r:admin_home_t:s0
> +.RE
> +.sp
> +and the default context defined in the file contexts file is:
> +.RS
> +system_u:object_r:admin_home_t:s0
> +.RE
> +.sp
> +then the actual strings compared are:
> +.RS
> +:object_r:admin_home_t:s0 and :object_r:admin_home_t:s0
> +.RE
> +.sp
> +Therefore they will match and
> +.B selinux_file_context_verify
> +will return 1.
> +
> +.SH "SEE ALSO"
> +.BR selinux "(8)"
> +
> diff --git a/src/matchpathcon.c b/src/matchpathcon.c
> index bb4eb9f..7e7be9a 100644
> --- a/src/matchpathcon.c
> +++ b/src/matchpathcon.c
> @@ -386,7 +386,7 @@ int selinux_file_context_verify(const char *path, mode_t mode)
>  	rc = lgetfilecon_raw(path, &con);
>  	if (rc == -1) {
>  		if (errno != ENOTSUP)
> -			return 1;
> +			return -1;
>  		else
>  			return 0;
>  	}
> @@ -396,11 +396,18 @@ int selinux_file_context_verify(const char *path, mode_t mode)
>  
>  	if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {
>  		if (errno != ENOENT)
> -			rc = 1;
> +			rc = -1;
>  		else
>  			rc = 0;
> -	} else
> +	} else {
> +		/* 
> +		 * Need to set errno to 0 as it can be set to ENOENT if the 
> +		 * file_contexts.subs file does not exist (see selabel_open in
> +		 * label.c), thus causing confusion if errno is checked on return.
> +		 */
> +		errno = 0;
>  		rc = (selinux_file_context_cmp(fcontext, con) == 0);
> +	}
>  
>  	freecon(con);
>  	freecon(fcontext);
> diff --git a/utils/matchpathcon.c b/utils/matchpathcon.c
> index 4453a88..ff98f0a 100644
> --- a/utils/matchpathcon.c
> +++ b/utils/matchpathcon.c
> @@ -41,7 +41,7 @@ int printmatchpathcon(char *path, int header, int mode)
>  
>  int main(int argc, char **argv)
>  {
> -	int i, init = 0;
> +	int i, init, rc = 0;
>  	int header = 1, opt;
>  	int verify = 0;
>  	int notrans = 0;
> @@ -115,16 +115,20 @@ int main(int argc, char **argv)
>  
>  		if (verify) {
>  			if (quiet) {
> -				if (selinux_file_context_verify(argv[i], mode))
> +				if ((rc = selinux_file_context_verify(argv[i], mode)) == 1)
>  					continue;
>  				else
>  					exit(1);
>  			}
> -			if (selinux_file_context_verify(argv[i], mode)) {
> +
> +			rc = selinux_file_context_verify(argv[i], mode);
> +			if (rc == -1) {
> +				printf("%s error: %s\n", argv[i], strerror(errno));
> +				exit(1);
> +			} else if (rc == 1)
>  				printf("%s verified.\n", argv[i]);
> -			} else {
> +			else {
>  				security_context_t con;
> -				int rc;
>  				error = 1;
>  				if (notrans)
>  					rc = lgetfilecon_raw(argv[i], &con);
> 
> 
> 
> Richard
> 
> --- On Wed, 16/2/11, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> Subject: Re: selinux_file_context_verify function returns wrong value.
>> To: "Richard Haines" <richard_c_haines@btinternet.com>
>> Cc: selinux@tycho.nsa.gov, "Daniel J Walsh" <dwalsh@redhat.com>
>> Date: Wednesday, 16 February, 2011, 18:25
>> On Mon, 2011-02-14 at 15:56 +0000,
>> Richard Haines wrote:
>>> The selinux_file_context_verify seems to return the
>> wrong value when I
>>> know the context of the file and that in the
>> file_contexts file are
>>> the same (returns '1' but according to man page should
>> be '0').
>>>   
>>> Looking at the libselinux source code (matchpathcon.c)
>> the line:
>>>   
>>>         rc =
>> (selinux_file_context_cmp(fcontext, con) == 0);
>>>   
>>> seems the problem.
>>>   
>>> I'm using libselinux 2.0.96
>>>   
>>> So should it return 0 on match, 1 if contexts are
>> different (or if the
>>> file / file_contexts entries do not exist) and -1 on
>> error.
>>>   
>>> And just to clarify the selinux_file_context_cmp
>> function return
>>> values:
>>>   
>>>       Should it return 0 on match (after
>> the 'user:' portion), 1 if
>>> contexts do not match and -1 on error.
>>>   
>>> Thanks
>>> Richard
>>>   
>>
>> Looks like a bug in the man page, combined with
>> inconsistent return
>> values on certain error paths within the code.  It
>> looks like the intent
>> was for selinux_file_context_verify() to return 1 if they
>> match, 0 if
>> they do not match, and -1 on error.  However:
>> a) that isn't what the man page says,
>> b) there is some special case handling of ENOTSUP and
>> ENOENT internally
>> that looks suspect to me, and
>> c) utils/matchpathcon.c doesn't check for < 0
>>
>> selinux_file_context_cmp is a bit simpler - it just follows
>> strcmp
>> conventions, i.e. -1 for "less than", 0 for equal, and 1
>> for "greater
>> than".
>>
>> Dan?
>>
>>
>> -- 
>> Stephen Smalley
>> National Security Agency
>>
>>
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
Patch looks good to me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1459kACgkQrlYvE4MpobOTUwCg0GzXn30xUVCTFHxuvBfc1DQF
qCcAnRN4XC9rljBLw1Rj2yi9oRhiTIfW
=LMXf
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
