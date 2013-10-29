Message-ID: <526FA142.3030603@redhat.com>
Date: Tue, 29 Oct 2013 07:51:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 01/17] Do not return error if system is in permissive
 mode.
References: <526EBE56.6010901@redhat.com> <526ECF62.6040007@tycho.nsa.gov>
In-Reply-To: <526ECF62.6040007@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/28/2013 04:56 PM, Stephen Smalley wrote:
> On 10/28/2013 03:43 PM, Daniel J Walsh wrote:
>> This is an updated patch with Steven's suggestions on making sure we
>> audit bad data.
>> 
>> This patch looks good to me. acked.
> 
> I applied my v1 patch instead as it ensured that we only do this if 
> security_compute_av* fails with EINVAL, not for any other case.
> 
> 
> 
That is fine with me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJvoUIACgkQrlYvE4MpobOxVQCggfAO208Q3Ue6A/Kzwi4+aigs
2k4AoOMg6PNDsIye6F0+SWAPSDuer2OX
=ULAS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
