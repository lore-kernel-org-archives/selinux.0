Message-ID: <4E48F6C0.6050003@redhat.com>
Date: Mon, 15 Aug 2011 06:36:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 032/155] policycoreutils: fixfiles use new kernel seclabel
References: <4E39B680.4000106@redhat.com>  <1312469885.20973.54.camel@moss-pluto>  <CACLa4pt+cB441dB=oE3_aF=ddV+dP2BiAOUmJd18qaxGFOnKZQ@mail.gmail.com> <1313174643.19123.153.camel@moss-pluto>
In-Reply-To: <1313174643.19123.153.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/12/2011 02:44 PM, Stephen Smalley wrote:
> On Fri, 2011-08-12 at 14:22 -0400, Eric Paris wrote:
>> On Thu, Aug 4, 2011 at 10:58 AM, Stephen Smalley
>> <sds@tycho.nsa.gov> wrote:
>>> On Wed, 2011-08-03 at 16:58 -0400, Daniel J Walsh wrote:
>> 
>>>> This patch looks good to me. acked.
>>> 
>>> When similar logic was added to setfiles, we included a kernel
>>> version check (>= 2.6.30) to ensure that we didn't end up
>>> excluding all filesystems on older kernels that do not report
>>> seclabel.
>> 
>> Patch replaced with the attached.
> 
> Your version comparison isn't quite right, e.g. consider 2.2.30. If
> you want a reliable version compare, you probably want to do 
> something similar to KERNEL_VERSION() from include/linux/version.h
> and convert both versions to simple integers that can be compared.
> Or you could do something based on this gem: 
> http://rubinium.org/blog/archives/2010/04/05/shell-script-version-compare-vercmp/
>
>  Or just rewrite fixfiles in a reasonable language ;)
> 

Or stop supporting really old versions of kernels with the latest tool
chain.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5I9sAACgkQrlYvE4MpobMXqQCdHF3n5u/Yw6bHNteFU3UXOyoh
i58An2VSHBmLU1dgHGuybzUiU+c0H4zc
=F4xN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
