Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NKq4pS007471
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 16:52:04 -0400
Received: from home-pc ([79.71.36.116]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LoVja-1bLLVC31NS-00gZVy for <selinux@tycho.nsa.gov>;
 Fri, 23 Sep 2016 22:52:00 +0200
Date: Fri, 23 Sep 2016 21:51:58 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
Message-ID: <20160923205158.GA13578@home-pc>
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 03:36:47PM -0400, Stephen Smalley wrote:
>On 09/23/2016 10:28 AM, Gary Tierney wrote:
>> Introduces support for generating homedir/user contexts for policies
>> that implement RBACSEP.  The support works by taking the prefix of a
>> logins seuser and replacing the role field in their context
>> specifications with the prefix.  A new option "genhomedircon-rbacsep"
>> was added to /etc/selinux/semanage.conf to allow toggling this behavior.
>
>The user prefix was previously used as a prefix for types, e.g. you
>could have:
>HOME_DIR/\.gnupg(/.+)?  system_u:object_r:ROLE_gpg_secret_t
>and get it replaced with:
>/home/[^/]+/\.gnupg(/.+)?       system_u:object_r:user_gpg_secret_t
>/root/\.gnupg(/.+)?             system_u:object_r:sysadm_gpg_secret_t
>
>So I guess you could use it for the role field too, but for consistency
>you would want it to be:
>HOME_DIR/\.gnupg(/.+)?  system_u:ROLE_r:ROLE_gpg_secret_t
>
>and the prefix would still just be "user".
>

That would work for us currently with refpolicy, but if I write a=20
similar CIL statement:

(filecon "HOME_DIR/\.gnupg(/.+)?" (system_u ROLE_r ROLE_gpg_secret_t))

Then I get a compile error because secilc thinks ROLE_r is the name of=20
the role.  I don't think there's any way to work around this in CIL.

>>
>> The user prefix can be set from both standard kernel policy and CIL:
>>
>> CIL:
>>     (user user_u)
>>     (role user_r)
>>     (userrole user_u user_r)
>>     (userprefix user_u user_r)
>>
>> kernel policy language:
>>     role user_r;
>>     user user_u roles { user_r } prefix user_r;
>>
>> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
>> ---
>>  libsemanage/src/conf-parse.y    | 14 +++++++++++++-
>>  libsemanage/src/conf-scan.l     |  1 +
>>  libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
>>  libsemanage/src/semanage_conf.h |  1 +
>>  4 files changed, 44 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedi=
rcon.c
>> index 3fc9e7a..98f9ebd 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -857,7 +866,7 @@ static int setup_fallback_user(genhomedircon_setting=
s_t * s)
>>  	int errors =3D 0;
>>
>>  	retval =3D semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers=
);
>> -	if (retval < 0 || (nseusers < 1)) {
>> +	if (retval < 0 || (nseusers < 2)) {
>
>Why did this test change?
>

My mistake, didn't intend to include that in this patch.

>>  		/* if there are no users, this function can't do any other=20
>>  		work */
>>  		return errors;
>>  	}
>> @@ -886,6 +895,17 @@ static int setup_fallback_user(genhomedircon_settin=
gs_t * s)
>>  					level =3D FALLBACK_LEVEL;
>>  			}
>>
>> +			if (u && s->h_semanage->conf->genhomedircon_rbacsep &&
>> +			    !semanage_user_has_role(u, prefix)) {
>
>I don't think you want to use prefix alone here, since it may be a
>prefix rather than a role name.
>
>The kernel policy contains the list of authorized roles for the user, so
>libsepol could export that, but that won't tell you anything about a
>default.
>
>libselinux get_default_context() and friends are context-sensitive (the
>result depends on the caller's context, such that it may differ for
>login vs sshd vs gdm and even among multiple distinct instances of any
>of these, e.g. if they have different levels), so I don't think you can
>use those.
>
>I don't think we presently provide a good way to find this information,
>which is why we added the user prefix in the first place.  But it is
>intended to be a prefix, not a role.

Do you have any suggestions on how this information could be configured?=20
I toyed with extending the policy language to support something like a=20
"userhomedirrole" statement, but didn't look too much into what the=20
implications of that would be.  That doesn't seem too suitable either=20
since it'd only be used by genhomedircon.

I agree that the prefix isn't really suitable and this is more of a hack=20
than a good solution (I forgot to include RFC in the subject!), though=20
I'm unsure what the next step would be in creating a good solution for=20
this.  Any input would be appreciated.


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX5ZXoAAoJEHBu12WFqnnYqOYIAJttCA+oR20l8N3dLO+gIO8k
oRnXOxeCU4ybbGr9Nd5izL1J4B67n1SCN2WI2AWIk1VlNg6K7EP8y6yANZE6ts21
a9yleq1r6+6F3yPm9vaRK80ffomLbYmxJv04hAnbbCwBqHd48nJS+KH2fWWaEm/2
0YNVx/MFps7Spi+try8UWkFrk7GAxT9kFua6IGg5WADf/zXS7ETq1D3azBvTgwb3
9gH4haQDwkR+HG4N9DcVDwiLXzooWurfkemUUkZhwB1+xK1mB+UY17Nwj2X1Yjuh
nuFeqpcX7dp40jRro5hg7iIEatpu1FFuEj8Pdejv7wHzOYwH4JabxB5LthvaCH0=
=MTWh
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
