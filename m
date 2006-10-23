Message-ID: <453D1764.3050200@us.ibm.com>
Date: Mon, 23 Oct 2006 14:26:28 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 0/4] newrole suid functionality (take 2)
References: <45351FC9.2080204@us.ibm.com> <1161629771.3316.119.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161629771.3316.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-10-17 at 13:24 -0500, Michael C Thompson wrote:
>> This is the intro to a set of four patches.
>>
>> These patches are an attempt to make newrole be an acceptably secure 
>> suid root program, to provide it with the capabilities to generate audit 
>> records (existing) and handle polyinstatiation (new).
>>
>> The 4 patches are as follows:
>> 1) New functions introduced to newrole.c, new and existing functionality
>> 2) Changes to existing functions in newrole.c
>> 3) Updates to main in newrole.c to use the aforementioned changes
>> 4) Changes to the Makefile to allow building of newrole with the
>>     changes and introduction of newrole-lspp.pamd
>>
>> Note: This is an atomically applicable patch set. Applying a subset of 
>> these patches will break the build.
>>
>> The comments from the previous send of these patches have been integrated.
> 
> diff -Naur policycoreutils-1.30.30.orig/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> --- policycoreutils-1.30.30.orig/newrole/newrole.c	2006-10-17 13:11:41.000000000 -0500
> +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-17 13:12:29.000000000 -0500
> @@ -87,6 +87,7 @@
>  /* USAGE_STRING describes the command-line args of this program. */
>  #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
>  
> +#define DEFAULT_PATH "/bin:/usr/bin:/usr/local/bin"
> 
> Where does this particular path come from?  Why /usr/local/bin at all?
> Why doesn't /usr/bin come before /bin?  

The concept for this came from the su source. The path basically spawned 
out of my head. It can be changed to anything that people deem appropriate.

> +/**
> + * Unset all environment variables except:
> + * TERM, DISPLAY and XAUTHORITY - if they are set, preserve values
> + * HOME, SHELL, USER and LOGNAME - set to contents of /etc/passwd
> + * PATH - set to default value DEFAULT_PATH
> 
> Anyone relying on the ability to propagate other environment settings to
> a newrole'd shell (that can't be re-created from the user's dotfiles)?

If they are, it would be pretty easy to allow the preservation of 
environment variables like su does.

> An alternative would be to save the original environment, reset it in
> this manner for the duration of newrole, but call the user shell with
> the original environment or some combination.

Again, this would be quite possible, say with a -p option?

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
