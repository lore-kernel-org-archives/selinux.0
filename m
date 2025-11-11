Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1C2FE075
	for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872299; cv=none; b=puFFvvDY1+hTl2EYXr1Ze1TU97r9ipXLFq4jdrALWjv68KTMo6mjo+RCU/EhKdOi0xACv5jKHQ4vDEgiDAm0PvCsy5eUSojiSxOy7ayIcueW1k9JGI96jgG17wxHjOehTtWIxYFFzL5yU9cTV25X0SvTorhwGRiPeScxfREZe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872299; c=relaxed/simple;
	bh=/3w24MmyBAXlgNxOMAvTQuGqu2h8JQKxOegXjW1/X8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6Dp6wX4GbwVBpG65FUeygG0fzMwd5u22loSmf8oYIsQDBJEL9JezN9Mzx0yr4snuHaIyQcg9x2mVEMx/rnYzgOIm+h86dDBK0aZnD6HlU4kqz2Tk3oZ3/dP4p3gHmBVW90IrUP+HKazPYazn3TSdWu5ERj4uOR7HdTWr9Yk+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b3OhAx0u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b3OhAx0u"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40765212AE48;
	Tue, 11 Nov 2025 06:44:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40765212AE48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762872296;
	bh=UgVTuAGFHQMAPfrU5X7cEMRje9FGCBpE3L55keM6sjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b3OhAx0ui/VDZetDai99VsN6154dmNRbVNgl0OZ0ponMWdttBUkw5Rk/8OgniT3z+
	 LnjT3yEnb9Is2OEByW8YsqL50J8wgNdqqVWFhOAUcjwdvInCAN9ZuKVbnd/zVmHi8p
	 iZDB+0W9PGvyEBcegiQnr0H9ZaUheNhfLuY18p9M=
Message-ID: <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com>
Date: Tue, 11 Nov 2025 09:44:54 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: William Roberts <bill.c.roberts@gmail.com>,
 Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
References: <20251110180935.202229-1-vmojzis@redhat.com>
 <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/2025 3:37 PM, William Roberts wrote:
> On Mon, Nov 10, 2025 at 2:23 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
>>
>> On Mon, Nov 10, 2025 at 12:11 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>
>>> This is useful in case we want to check that a remediation using
>>> restorecon was successful (otherwise 0 is always returned, even if no
>>> files where relabeled).
>>>
>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> ---
>>>   libselinux/include/selinux/restorecon.h |  9 +++++++++
>>>   libselinux/src/libselinux.map           |  1 +
>>>   libselinux/src/selinux_restorecon.c     | 14 ++++++++++++++
>>>   policycoreutils/setfiles/restore.h      |  1 +
>>>   policycoreutils/setfiles/restorecon.8   |  3 +++
>>>   policycoreutils/setfiles/setfiles.c     | 24 ++++++++++++++++++++----
>>>   6 files changed, 48 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
>>> index 0ccf73a6..736481bb 100644
>>> --- a/libselinux/include/selinux/restorecon.h
>>> +++ b/libselinux/include/selinux/restorecon.h
>>> @@ -228,6 +228,15 @@ extern int selinux_restorecon_xattr(const char *pathname,
>>>    */
>>>   extern long unsigned selinux_restorecon_get_skipped_errors(void);
>>>
>>> +/* selinux_restorecon_get_relabeled_files - Get the number of relabeled files
>>> + *
>>> + * If selinux_restorecon(3) or selinux_restorecon_parallel(3) was called,
>>> + * this function returns the number of files that were successfully relabeled.
>>> + * If the SELINUX_RESTORECON_NOCHANGE flag was set, this function returns
>>> + * the number of files that would be relabeled.
>>> + */
>>> +extern long unsigned selinux_restorecon_get_relabeled_files(void);
>>> +
>>>   #ifdef __cplusplus
>>>   }
>>>   #endif
>>> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
>>> index ab002f01..f21e089e 100644
>>> --- a/libselinux/src/libselinux.map
>>> +++ b/libselinux/src/libselinux.map
>>> @@ -244,6 +244,7 @@ LIBSELINUX_1.0 {
>>>   LIBSELINUX_3.4 {
>>>     global:
>>>       selinux_restorecon_get_skipped_errors;
>>> +    selinux_restorecon_get_relabeled_files;
>>>       selinux_restorecon_parallel;
>>>   } LIBSELINUX_1.0;
>>>
>>> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
>>> index 681c69db..6e9a159e 100644
>>> --- a/libselinux/src/selinux_restorecon.c
>>> +++ b/libselinux/src/selinux_restorecon.c
>>> @@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
>>>   /* Number of errors ignored during the file tree walk. */
>>>   static long unsigned skipped_errors;
>>>
>>> +/* Number of successfully relabeled files or files that would be relabeled */
>>> +static long unsigned relabeled_files;
>>> +
>>>   /* restorecon_flags for passing to restorecon_sb() */
>>>   struct rest_flags {
>>>          bool nochange;
>>> @@ -796,6 +799,10 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>>>                                  syslog(LOG_INFO, "labeling %s to %s\n",
>>>                                              pathname, newcon);
>>>                  }
>>> +
>>> +               /* Count relabeled files (or would be relabeled if "nochange" was not set) */
>>> +               relabeled_files++;
>>> +
>>>          }
>>>
>>>   out:
>>> @@ -1096,6 +1103,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
>>>          state.skipped_errors = 0;
>>>          state.saved_errno = 0;
>>>
>>> +       relabeled_files = 0;
>>> +
>>>          struct stat sb;
>>>          char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
>>>          char *paths[2] = { NULL, NULL };
>>> @@ -1618,3 +1627,8 @@ long unsigned selinux_restorecon_get_skipped_errors(void)
>>>   {
>>>          return skipped_errors;
>>>   }
>>> +
>>> +long unsigned selinux_restorecon_get_relabeled_files(void)
>>> +{
>>> +       return relabeled_files;
>>> +}
>>> diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
>>> index 95afb960..7c949c1c 100644
>>> --- a/policycoreutils/setfiles/restore.h
>>> +++ b/policycoreutils/setfiles/restore.h
>>> @@ -37,6 +37,7 @@ struct restore_opts {
>>>          unsigned int ignore_mounts;
>>>          unsigned int conflict_error;
>>>          unsigned int count_errors;
>>> +       unsigned int count_relabeled;
>>
>> It's using unsigned int, but other places use unsigned long. Wouldn't we want to
>> keep this consistent to prevent truncating long to int? Do we care
>> about rollovers?
>> It's unlikely to happen, but some file systems don't have bounds on
>> the number of files,
>> also can't restorecon go across fs boundaries, so the count could be
>> high, albeit unlikely.
>>
>>>          /* restorecon_flags holds | of above for restore_init() */
>>>          unsigned int restorecon_flags;
>>>          char *rootpath;
>>> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
>>> index 1134420e..e9bd16b6 100644
>>> --- a/policycoreutils/setfiles/restorecon.8
>>> +++ b/policycoreutils/setfiles/restorecon.8
>>> @@ -153,6 +153,9 @@ display warnings about entries that had no matching files by outputting the
>>>   .BR selabel_stats (3)
>>>   results.
>>>   .TP
>>> +.B \-c
>>> +count and display the number of (would be) relabeled files. The exit code will be set to the number of relabeled files (capped at 254).
>>> +.TP
>>>   .B \-0
>>>   the separator for the input items is assumed to be the null character
>>>   (instead of the white space).  The quotes and the backslash characters are
>>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>>> index 31034316..6323f56c 100644
>>> --- a/policycoreutils/setfiles/setfiles.c
>>> +++ b/policycoreutils/setfiles/setfiles.c
>>> @@ -35,8 +35,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
>>>   {
>>>          if (iamrestorecon) {
>>>                  fprintf(stderr,
>>> -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] pathname...\n"
>>> -                       "usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -f filename\n",
>>> +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] pathname...\n"
>>> +                       "usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] -f filename\n",
>>>                          name, name);
>>>          } else {
>>>                  fprintf(stderr,
>>> @@ -146,7 +146,7 @@ int main(int argc, char **argv)
>>>          size_t buf_len, nthreads = 1;
>>>          const char *base;
>>>          int errors = 0;
>>> -       const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
>>> +       const char *ropts = "ce:f:hiIDlmno:pqrsvFURW0xT:";
>>>          const char *sopts = "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
>>>          const char *opts;
>>>          union selinux_callback cb;
>>> @@ -223,7 +223,10 @@ int main(int argc, char **argv)
>>>          while ((opt = getopt(argc, argv, opts)) > 0) {
>>>                  switch (opt) {
>>>                  case 'c':
>>> -                       {
>>> +                       if (iamrestorecon) {
>>> +                               r_opts.count_relabeled = 1;
>>> +                               break;
>>> +                       } else {
>>>                                  FILE *policystream;
>>>
>>>                                  policyfile = optarg;
>>> @@ -479,5 +482,18 @@ int main(int argc, char **argv)
>>>          if (r_opts.progress)
>>>                  fprintf(stdout, "\n");
>>>
>>> +       /* Output relabeled file count if requested */
>>> +       if (r_opts.count_relabeled) {
>>> +               long unsigned relabeled_count = selinux_restorecon_get_relabeled_files();
>>> +               printf("Relabeled %lu files\n", relabeled_count);
>>> +
>>> +               /* Set exit code to number of relabeled files (capped at 254) */
>>> +               if (errors) {
>>> +                       exit(-1);
>>> +               } else {
>>> +                       exit(relabeled_count > 254 ? 254 : (int)relabeled_count);
>>> +               }
>>
>> This I don't like. By convention, certain exit codes mean things. If
>> someone is debugging a restorecon with this option set,
>> and sees exit code 127, they're going to think, "command not found".
>> There are other codes to, like 126 not executable,
>> 128 + signum, ie 137 is I was killed by SIGKILL Additionally, the
>> truncation makes it less useful.
> 
> I forgot to mention as well, If a user enables this option in a script
> set to exit
> on error, they have to code around this command under specific options.
> 
>>
>> I'd rather see this just exit 0 or 1, if folks need the count they can
>> parse it from stdout.
>>
>> I'm no longer an SELinux maintainer, so don't let my nack stop anyone.

We have a need for a similar use case in terms of ensuring that 
restorecon actually performed relabeling, but I agree that I don't think 
this patch as is would meet our needs.

One thing that might make the patch more usable and address these 
comments would be to instead pass the expected number of relabels as an 
argument to restorecon and then return success if the relabel count == 
the expected count.  That avoids all the problems around exit code 
handling while still verifying the count.

The other problem though is that in the presence of globbing it's not 
clear that getting the expected number of files relabeled means that you 
actually relabeled the files you expected to.  But I guess the answer to 
that is just "don't use the count feature with globbing".  Even without 
globbing though, if you don't relabel all the files, you don't know 
which one you skipped without extra handling, which seems like you 
really don't need to know the number relabeled as much as whether it was 
the number you expected, which seems like a point in favor of "pass the 
expected count".

-Daniel

>>
>>> +       }
>>> +
>>>          exit(errors ? -1 : skipped_errors ? 1 : 0);
>>>   }
>>> --
>>> 2.51.0
>>>
>>>

