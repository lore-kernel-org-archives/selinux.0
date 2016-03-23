Subject: Re: strange pam_selinux behavior
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F2E9F0.7040905@gmail.com>
Date: Wed, 23 Mar 2016 20:09:36 +0100
MIME-Version: 1.0
In-Reply-To: <56F2E999.1070904@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/23/2016 08:08 PM, Stephen Smalley wrote:
> On 03/23/2016 02:37 PM, Dominick Grift wrote:
>> On 03/23/2016 07:32 PM, Dominick Grift wrote:
>>> On 03/23/2016 06:58 PM, Dominick Grift wrote: <snip>
>>>> This seems to be the code:
>> 
>>>>> /* we have to check that this user is allowed to go into
>>>>> the range they have specified ... role is tied to an
>>>>> seuser, so that'll be checked at setexeccon time */ if
>>>>> (mls_enabled && !mls_range_allowed(pamh, defaultcon,
>>>>> newcon, debug)) { pam_syslog(pamh, LOG_NOTICE, "Security
>>>>> context %s is not allowed for %s", defaultcon, newcon);
>> 
>>>>> goto fail_set;
>> 
>> 
>> 
>>> This seems related:
>> 
>>>> class = string_to_security_class("context"); if (!class) { 
>>>> pam_syslog(pamh, LOG_ERR, "Failed to translate security class
>>>>  context. %m"); return 0; }
>> 
>>> since:
>> 
>>> pam_selinux(sshd:session): Failed to translate security class 
>>> context. Invalid argument
>> 
>>> What is a "security class context"?
>> 
>>> Is it choking on the periods in my identifiers?
>> 
>> 
>> oh sh.. now i get it. It is choking on the "context" security
>> class.
>> 
>> Yes i dont have that "user space" access vector because that
>> seems to be no longer used.
>> 
>> isnt the context security class a "setransd" thing? if so then i
>> do not believe that setransd still uses that. So this should
>> probably be adjusted then to not rely on that user space access
>> vector?
> 
> I still see it in use in mcstrans 
> policycoreutils/mcstrans/src/mcscolor.c:	security_class_t
> context_class = string_to_security_class("context");
> 
> Whether or not it ought to be used by pam_selinux is a different
> question...
> 

Until recently i used mcstransd on one of my systems, and it never
perfomed any checks , that is why i removed that access vector from my
policy.

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8unrAAoJECV0jlU3+UdpmGMMAJjJRrkXGGT6bmsqrqwKGes7
YlSgTMVUZi1ncsBLoq6wVhV+HHATOj9IOaWXbT0k+bsPv/2xPEk0Tr+TV6Pq7C+v
xfbspTJYW91wKloa7GKE8W+869y/7mwq8BGUJcaeoJy3WktsClV85ZTKL5RNcoaV
DKt3FrkJbvBjzcy7nONqYUJQKXHdgQhsAzMmy2rgZRUeH9CrTVb3/MVCjHTkA9H1
26Euzu2LqUK5R/u19AgtJwqz3peSe4NWsM40z5m7PjrfURQXX8Yd43jGN79Y54PD
ptJ38BUXaPI2H3eRs9gLgh+ewNrxdm2P8wST80fXfrirPxVscxDmk4jrr72hGi0/
jgqM2WZktypEOoZFirfpmHA86AUeZHR//cuvtoyfirYJv3/shmmWPHGDZyeqeX5H
FDqtMIgRahNbayJu7gLgkEVSnT5DVZATyKOgm3CIxyOlVAOaAgC6E7YIaL4LBFA+
98S7Ehf62ArgQ8RPUSFkJO7wPlJHacLUofQqNKt83w==
=DsF5
-----END PGP SIGNATURE-----
