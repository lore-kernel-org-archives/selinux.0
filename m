Subject: Re: should setfscreatecon be able to override auto type transition
 rules?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56D4987B.2030001@gmail.com> <56D4A8A9.40704@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56D4AA85.3050405@gmail.com>
Date: Mon, 29 Feb 2016 21:31:01 +0100
MIME-Version: 1.0
In-Reply-To: <56D4A8A9.40704@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/29/2016 09:23 PM, Stephen Smalley wrote:
> On 02/29/2016 02:14 PM, Dominick Grift wrote:
>> I encountered this today and it got me thinking. Should this be
>> happenin g?
> 
> Yes.
> 
>> I would think that a auto type transition rule should always
>> take precedence, and that setfscreatecon should only be honored
>> if there is nothing in policy overriding it.
> 
> No.  The type_transition rules are merely defaults to provide 
> compatibility with a non-security-aware userspace.
> setfscreatecon() intentionally permits overriding type transition
> or default inheritance rules.  Of course, one can only use
> setfscreatecon() if one has the requisite permissions, including
> setfscreate to even use it at all, plus create to the specified
> type.  However, in Android, the usage permissions like setfscreate
> are tightly locked down; only a few domains are allowed them.
> 

So if one does not allow the requisite permissions for the
setfscreatecon, should it then "fall" back to the auto type transition?

this is one of the instances:

AVC avc:  denied  { create } for  pid=31307 comm="useradd"
name="subuid-"
scontext=wheel.id:sysadm.role:useradd.subj:s0-s0:c0.c1023
tcontext=sys.id:sys.role:config.config_file:s0 tclass=file permissive=1

There was a rule:

type_transition useradd.subj config.config_file:file passwords.file;

But there was no file context specified for it.

Thus useradd wanted to create /etc/subuid- with type
config.config_file even though there was a type transition.

In enforcing mode, would it have created /etc/subuid- with type
passwords.file? Since it was not allowed to create /etc/suduid- with
type config.config_file?

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW1KqAAAoJECV0jlU3+UdpqzoL/jc7b2DacnIBZLMtU6sSFFly
8hJITLGj2DeGS/InlMwzEvPtey1a/uNhFyJrqoyOBp+fi1HC5Iszmp4CyeII+mHz
HakqwvlaMfulA+r91pgKAwGxtYomJQNvSJpqb/xUvEYAAczQrqSAudyX7n9DRUuz
tdGahYA9XvRh1Bx2mwv/hxJS+p6u2SDpXQk5tLG1sEdO+c1YUjPTBy7gYgGhsS7O
G2spp8C3A07mZ659tNUZe1cVVA7t3txVElE8F5KFJXKm4wuqvYNE7KLzxGZlMp5s
+aNcXsN6RnSDYkSuCZDEepq0UmAZYeQ3zNPk/sxczuE5xa2Bl/ADzvcHMbt/dkkK
RMFgTUAhNSd6g/ZvoN98ZPs7+lVTExkK1yDTsWPOqgEyp47OCVZ/6ScPGfoLIE+F
W0BINIJefqo77QCl6IEnDsOlnY6PEOZYTD4BmC4+7Men40drMnNvsW3yogfn8Cuf
FIhlDJ1l6HUjGZ6Hi+lSaoVASVK4vVa+3N1kMA7GiQ==
=IOpT
-----END PGP SIGNATURE-----
