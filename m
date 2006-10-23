Message-ID: <453D181E.8090709@us.ibm.com>
Date: Mon, 23 Oct 2006 14:29:34 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 3/4] newrole suid functionality (take 2)
References: <45351FC9.2080204@us.ibm.com>  <45352427.20705@us.ibm.com> <1161630359.3316.127.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161630359.3316.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-10-17 at 13:42 -0500, Michael C Thompson wrote:
>> Michael C Thompson wrote:
>>> This is the intro to a set of four patches.
>>>
>>> These patches are an attempt to make newrole be an acceptably secure 
>>> suid root program, to provide it with the capabilities to generate audit 
>>> records (existing) and handle polyinstatiation (new).
>>>
>>> The 4 patches are as follows:
>>> 1) New functions introduced to newrole.c, new and existing functionality
>>> 2) Changes to existing functions in newrole.c
>>> 3) Updates to main in newrole.c to use the aforementioned changes
>> This is the 3rd of 4 patches.
>> This patch applies against policycoreutils-1.30.30-1.
>>
>> Changes:
>>   * main is changed in the following ways:
>>     - remove the duplicated functionality from patch 1/4
>>     - set to call the new functions from patch 1/4
>>     - set to use changes to functions in patch 2/4
>>     - introduces better error handling and cleanup paths
>>
>> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>
> 
> diff -Naur policycoreutils-1.30.30.orig/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> --- policycoreutils-1.30.30.orig/newrole/newrole.c	2006-10-17 13:15:20.000000000 -0500
> +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-17 13:15:03.000000000 -0500
> @@ -897,47 +898,43 @@
>  
>  int main(int argc, char *argv[])
> <snip>
> +	/*
> +	 * Step 0: Setup
> +	 *
> +	 * Do some intial setup, including dropping capabilities, checking
> +	 * if it makes sense to continue to run newrole, and setting up
> +	 * a scrubbed environment.
> +	 */
> +	if (set_signal_handles())
> +		return -1;
> +	if (drop_capabilities())
> +		return -1;
> 
> I'd keep drop_capabilities() first, as it was before this patch.
> It would also make sense to move up sanitize_environment() as soon as
> possible, even if that means splitting it into two phases (in particular
> considering the locale support).

Alright, that can be done. If we want to preserve the environment 
variables when we exec the new shell, this could be done at the same 
time support this change.

Thanks,
Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
