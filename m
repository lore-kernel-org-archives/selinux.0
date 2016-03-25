Subject: Re: strange pam_selinux behavior
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
 <56F3EBEF.7050808@redhat.com> <56F3FA39.6080003@gmail.com>
 <56F4512A.8080507@redhat.com> <56F56129.3080509@gmail.com>
 <56F567F2.8030507@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F56B1E.60708@gmail.com>
Date: Fri, 25 Mar 2016 17:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <56F567F2.8030507@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/25/2016 05:31 PM, Stephen Smalley wrote:
> On 03/25/2016 12:02 PM, Dominick Grift wrote:
>> I set out to try mcstransd again today. After doing to searching
>> i found a clue about the requirement to add accesscheck=1 to 
>> setrans.conf to at least enable checking of the translate av
>> perm.
>> 
>> So i added a few auditallow rules that should catch at least
>> some checks however: nothing shows up in the logs.
>> 
>> Either i am overlooking something or the mcstransd object manager
>> is broken
> 
> Yes, I mentioned the lack of this access check in 
> http://article.gmane.org/gmane.comp.security.selinux/22011
> 
> However, the mcscolor code within mcstrans still does a check of
> the context contains permission.  This is only exercised if
> something calls selinux_raw_context_to_color() in libselinux, and
> if one has a secolor.conf.  That was added for SELinux-aware
> graphical applications which display security contexts in order to
> associate color schemes with security contexts.
> 
> Likely unused in Fedora but may be used in various MLS desktop
> solutions built on SELinux.
> 
> 

Thanks for the info. I really wonder whether its sensible to make
pam_selinux depend in this way on "context contains". Not even sure
how that gets the job done, let alone about any possible alternative
approaches without relying on third party access vectors.

In my policy this breaks modularity. if i decide to exclude the
mcstransd module then the context object class is no longer in policy
and subsequently logins with sshd will break unless the env_params or
select_context options are removed from /etc/pam.d/sshd

But for now i got it "to work" by adding support for this access
vector in my policy, i just need to make a note that env_params and
select_context rely on the presence of msctransd policy

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW9WsYAAoJECV0jlU3+Udp4tEL/1D/UQ+Kf0oJZZUaXlj7GCdU
RaM1r3AsJmw14p8Qv2U88+ECu3CbepxroJW7AjPAYnzg5NVVnhy2afv6i0wNioTI
cTuIIoIav6MYNRh/n92ZhxhM18zcvPHVsGG2XWlC/KrMSKqMYiJ0dQyajA9FAd0p
O4kI9GTlcPtQlFAXKNfsLzWhp/x99T99fSjhek3AM6FQYbtk4uZ806PV2Pytn/Rq
LrM/SApdvjQXhwMp+Xiq66iHJOh17VqjP2cD5osnxfUHnPbO8iyjB0PwK3FzX0aW
dBCd4KfZL/1BuUTk6fhbYnIe5FLd2SRMcL0kBSoAkpH/eSOLx3vxsSpOQWKtbZLK
Uyd4Ut4c8Hdy3+NSwb0H8j6tG7ts2mSlWxai/7/YOADJYwT6i11oAHa/QUjptIiu
QmbGjsNcFxlKNsOsm4xDlFZQXvhE1XrPP1Pu6zSgpkMZCgdLEyO8lozNxqewInlo
bsdku9OgXVGqiLzZqTJGNcV85IIWVCO+L3/1jK7TFA==
=Pf5f
-----END PGP SIGNATURE-----
