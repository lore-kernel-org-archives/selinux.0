Message-ID: <456F0D94.2030407@redhat.com>
Date: Thu, 30 Nov 2006 11:57:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to load_policy to enforce quiet option
References: <456E06BE.1030007@redhat.com> <456F0580.7070003@tresys.com>
In-Reply-To: <456F0580.7070003@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>>
>>
>> ------------------------------------------------------------------------
>>
>> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
>> --exclude='*.pot' -N -u -r 
>> nsapolicycoreutils/load_policy/load_policy.c 
>> policycoreutils-1.33.5/load_policy/load_policy.c
>> --- nsapolicycoreutils/load_policy/load_policy.c    2006-11-16 
>> 17:14:31.000000000 -0500
>> +++ policycoreutils-1.33.5/load_policy/load_policy.c    2006-11-28 
>> 10:44:25.000000000 -0500
>> @@ -50,12 +50,12 @@
>>      nargs = argc - optind;
>>      if (nargs > 2)
>>          usage(argv[0]);
>> -    if (nargs >= 1) {
>> -        fprintf(stderr,
>> -            "%s:  Warning!  Policy file argument (%s) is no longer 
>> supported, installed policy is always loaded.  Continuing...\n",
>> -            argv[0], argv[optind++]);
>> +    if (nargs >= 1 && !quiet) {
>> +            fprintf(stderr,
>> +                "%s:  Warning!  Policy file argument (%s) is no 
>> longer supported, installed policy is always loaded.  Continuing...\n",
>> +                argv[0], argv[optind++]);
>>      }
>> -    if (nargs == 2) {
>> +    if (nargs == 2 && ! quiet) {
>>          fprintf(stderr,
>>              "%s:  Warning!  Boolean file argument (%s) is no longer 
>> supported, installed booleans file is always used.  Continuing...\n",
>>              argv[0], argv[optind++]);
>
>
> Hrm. Should quiet really squelch warnings? Also, it looks like 
> load_policy is using a deprecated interface to squelch other output 
> from libsepol, this should probably be fixed.
>
man load_policy
...
      -q     suppress warning messages.
...


I think this was originally added to stop things like boolean is no 
longer in this package.  It might not be necessary any longer,  but if 
we have it we should be consistant.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
