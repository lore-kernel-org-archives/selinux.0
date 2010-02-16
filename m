Message-ID: <4B7AC09C.8030701@gmail.com>
Date: Tue, 16 Feb 2010 07:58:20 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: label_file.c:434: error: implicit declaration of function 'fstat'
References: <dd18b0c31002151419v1445e151j761c06e3cf39f5c0@mail.gmail.com> <1266330571.5252.23.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266330571.5252.23.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/16/2010 06:29 AM, Stephen Smalley wrote:
> On Mon, 2010-02-15 at 14:19 -0800, Justin Mattock wrote:
>> this is new:
>>
>>
>> make[2]: Leaving directory `/home/kernel/selinux/libselinux/include'
>> make -C src install
>> make[2]: Entering directory `/home/kernel/selinux/libselinux/src'
>> cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn
>> -Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=64   -c -o label_file.o label_file.c
>> cc1: warnings being treated as errors
>> label_file.c: In function 'init':
>> label_file.c:434: error: implicit declaration of function 'fstat'
>> label_file.c:436: error: implicit declaration of function 'S_ISREG'
>> make[2]: *** [label_file.o] Error 1
>> make[2]: Leaving directory `/home/kernel/selinux/libselinux/src'
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/home/kernel/selinux/libselinux'
>> make: *** [install] Error 1
>>
>> three areas where this could of been created
>> update glibc
>> updated kernel
>> update userspace(altohugh there was not vary many commits in the pull).
>
> Newer glibc headers expose a failure to #include the required headers
> for stat(2).  Also exposes a conflict in redefining close() in that
> file.  Patch below should fix.
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b5e904f..509b033 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -17,6 +17,9 @@
>   #include<errno.h>
>   #include<limits.h>
>   #include<regex.h>
> +#include<sys/types.h>
> +#include<sys/stat.h>
> +#include<unistd.h>
>   #include "callbacks.h"
>   #include "label_internal.h"
>
> @@ -545,7 +548,7 @@ finish:
>   /*
>    * Backend interface routines
>    */
> -static void close(struct selabel_handle *rec)
> +static void closef(struct selabel_handle *rec)
>   {
>   	struct saved_data *data = (struct saved_data *)rec->data;
>   	struct spec *spec;
> @@ -666,7 +669,7 @@ int selabel_file_init(struct selabel_handle *rec, struct selinux_opt *opts,
>   	memset(data, 0, sizeof(*data));
>
>   	rec->data = data;
> -	rec->func_close =&close;
> +	rec->func_close =&closef;
>   	rec->func_stats =&stats;
>   	rec->func_lookup =&lookup;
>
>

o.k. plugged in the above patch to libselinux, recompiled
the userspace tools, with glibc being at the last good
commit. Then reset glibc to the current HEAD(which breaks libselinux),
and userspace compiled good.(soe before and after compile good).

Thanks Stephen.

I guess the only other thing missing is a
(although the main thing is this is fixed).

Reported-Tested-by: Justin P. Mattock <justinmattock@gmail.com>

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
