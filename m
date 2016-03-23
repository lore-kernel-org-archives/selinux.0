Subject: Re: strange pam_selinux behavior
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56F2E999.1070904@tycho.nsa.gov>
Date: Wed, 23 Mar 2016 15:08:09 -0400
MIME-Version: 1.0
In-Reply-To: <56F2E276.9070702@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2016 02:37 PM, Dominick Grift wrote:
> On 03/23/2016 07:32 PM, Dominick Grift wrote:
>> On 03/23/2016 06:58 PM, Dominick Grift wrote: <snip>
>>> This seems to be the code:
> 
>>>> /* we have to check that this user is allowed to go into the 
>>>> range they have specified ... role is tied to an seuser, so 
>>>> that'll be checked at setexeccon time */ if (mls_enabled && 
>>>> !mls_range_allowed(pamh, defaultcon, newcon, debug)) { 
>>>> pam_syslog(pamh, LOG_NOTICE, "Security context %s is not
>>>> allowed for %s", defaultcon, newcon);
> 
>>>> goto fail_set;
> 
> 
> 
>> This seems related:
> 
>>> class = string_to_security_class("context"); if (!class) { 
>>> pam_syslog(pamh, LOG_ERR, "Failed to translate security class 
>>> context. %m"); return 0; }
> 
>> since:
> 
>> pam_selinux(sshd:session): Failed to translate security class 
>> context. Invalid argument
> 
>> What is a "security class context"?
> 
>> Is it choking on the periods in my identifiers?
> 
> 
> oh sh.. now i get it. It is choking on the "context" security class.
> 
> Yes i dont have that "user space" access vector because that seems to
> be no longer used.
> 
> isnt the context security class a "setransd" thing? if so then i do
> not believe that setransd still uses that. So this should probably be
> adjusted then to not rely on that user space access vector?

I still see it in use in mcstrans
policycoreutils/mcstrans/src/mcscolor.c:	security_class_t context_class
= string_to_security_class("context");

Whether or not it ought to be used by pam_selinux is a different question...
