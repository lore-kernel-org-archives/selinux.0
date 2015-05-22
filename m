Message-ID: <555F5802.3090104@tycho.nsa.gov>
Date: Fri, 22 May 2015 12:23:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: string_to_av_perm behavior
References: <CAFPpqQHQ5n=4chF3hCbQMQfU6yZ9KgjoVyotGCg6FA1RDdtxiw@mail.gmail.com>
 <555F5762.8040601@tycho.nsa.gov>
In-Reply-To: <555F5762.8040601@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/22/2015 12:20 PM, Stephen Smalley wrote:
> On 05/22/2015 12:12 PM, Ted Toth wrote:
>> ./avperm
>> 1 - av_perm 0
>> security class: 66
>> class db_tuple av select
>> 2 - av_perm 8
>> 3 - av_perm 8
>>
>> why does the first call to string_to_av_perm return 0 something seem wrong here.
> 
> You need to call string_to_security_class() first.
> 
> The hardcoded #defines in flask.h and av_permissions.h are deprecated;
> you'll get compiler warnings with a recent version of libselinux when
> including them.

BTW, the preferred interface for SELinux userspace permission checks
these days is selinux_check_access().  Then you don't ever need to deal
with class or permission values or directly use any of the avc interfaces.
