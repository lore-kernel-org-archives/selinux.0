Subject: Re: should setfscreatecon be able to override auto type transition
 rules?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56D4987B.2030001@gmail.com> <56D4A8A9.40704@tycho.nsa.gov>
 <56D4AA85.3050405@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56D4AC1C.7000102@gmail.com>
Date: Mon, 29 Feb 2016 21:37:48 +0100
MIME-Version: 1.0
In-Reply-To: <56D4AA85.3050405@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/29/2016 09:31 PM, Dominick Grift wrote:
> On 02/29/2016 09:23 PM, Stephen Smalley wrote:
>> On 02/29/2016 02:14 PM, Dominick Grift wrote:
>>> I encountered this today and it got me thinking. Should this
>>> be happenin g?
> 
>> Yes.
> 
>>> I would think that a auto type transition rule should always 
>>> take precedence, and that setfscreatecon should only be
>>> honored if there is nothing in policy overriding it.
> 
>> No.  The type_transition rules are merely defaults to provide 
>> compatibility with a non-security-aware userspace. 
>> setfscreatecon() intentionally permits overriding type
>> transition or default inheritance rules.  Of course, one can only
>> use setfscreatecon() if one has the requisite permissions,
>> including setfscreate to even use it at all, plus create to the
>> specified type.  However, in Android, the usage permissions like
>> setfscreate are tightly locked down; only a few domains are
>> allowed them.
> 
> 
> So if one does not allow the requisite permissions for the 
> setfscreatecon, should it then "fall" back to the auto type
> transition?
> 
> this is one of the instances:
> 
> AVC avc:  denied  { create } for  pid=31307 comm="useradd" 
> name="subuid-" 
> scontext=wheel.id:sysadm.role:useradd.subj:s0-s0:c0.c1023 
> tcontext=sys.id:sys.role:config.config_file:s0 tclass=file
> permissive=1
> 
> There was a rule:
> 
> type_transition useradd.subj config.config_file:file
> passwords.file;
> 
> But there was no file context specified for it.
> 
> Thus useradd wanted to create /etc/subuid- with type 
> config.config_file even though there was a type transition.
> 
> In enforcing mode, would it have created /etc/subuid- with type 
> passwords.file? Since it was not allowed to create /etc/suduid-
> with type config.config_file?
> 

I think I know the answer. No it would not fall back.

I can understand that setfscreate overrides default inheritance, but I
personally think that auto type transition should take precedence.

In gnu/linux even coreutils request setfscreatecon. Sometimes that
makes perfect sense but sometimes you want to be able to override that.

> 

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW1KwYAAoJECV0jlU3+Udpd+oL/0PF6wZrB9U6/W22y6CV2Msz
I+zI7LiRwPUO9Bq54bO15bOmiAg8fOcR+J6qYbkLJ0IyRQdamfpBHBCiwNNP0Sf9
zK8BcJm/E3kR5oAW1HbxwYmkfZvLANvHmCBkrYNW3304SflTClRwT8K5y6kj18Xt
2Ro7u5VCywB9U/ajF0kDQNXEVbFV+YRGEDEpJ+qRqaj2GqDL93VELAbMyUZA0oVx
7x91P3pzw3kcToDqVQLYRzuUreiabFA+jqHrcCSkIycrinoWRu0EHXAOmdh1tI4I
i0CD6GqmY8ygLBnOEj6mR657hCh8fYMAQDNkPnL0pXcNP4BcfQWhYkWgnIWn+nF0
zXvP7WKlJ8Cg0XCxX5G8mVmIeGGlrasRbV/6RLAZesUDhcMPgbOMXu2yKpXBM8l8
ExHfaQvBHgtu3H6KxIDh3hF3BZrmCHsr9HPN05x9G8xGnzw/2PgyGRZYNbqvD0Ve
/f8imbPQVYrxAMcTR4CSa0scfr6hI1OQ/oRnb1J2fg==
=fagI
-----END PGP SIGNATURE-----
