Received: from yunyun.fuwafuwatime.moe (yunyun.fuwafuwatime.moe [107.191.99.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E36FC5
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.99.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521738; cv=none; b=C+oSc6XWQWV+DzgXDQNCTGfR4Sv4Z5/+FWqjYtFht4ZMqHFkYsgZov9t1bHiIWSKloCJ8ysFBxDHciu+T3g1EBbDJ4D65h5Av12qZyz+8gUTtMRF4MD4gFBeID60Ywue73gm2ZjAAzd3KweFieEICmQEeMGHu8AnrfWGZe6eDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521738; c=relaxed/simple;
	bh=FueKxK5HDuAhOyZb5gO29xuPAx38ZCghxx1uIlu3qHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nejpzc6+lY1PvqeOVT77HFbWTyTSoZLlquN3V/o/UpfqbKW9mIfg1ewRDSxgykqG/GWyDFh89WpIBwixBU3uofgvpWGGx6enoCKIau8aTNjkCsOIRXeR05NKFit2bCpd9ZGauEg2jW8TVvM0UfTsVlJ2JgPR7odz8n16MecXc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh; spf=pass smtp.mailfrom=concord.sh; dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b=qlFoJTln; arc=none smtp.client-ip=107.191.99.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=concord.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b="qlFoJTln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=concord.sh; s=dkim;
	t=1731521237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdurfzWU/lfIgoYzxauY0Do2UFPJwlJHYtRLfylqLkU=;
	b=qlFoJTlnPRnFnPHv8DrymlusjFl9wNUp5yUB2Oc5mgUyG6Wly4q+W1wfOqzmKgjbbUBvC9
	teC2kKxOkk3QfOwpMranSuXTknUuv7PrGOPFcLACOjrXKM7SupSnaUiD0VUp8/8ZTQ04aK
	JChDgKH3REXOygRKtkLaSxr+3Qzzk6MYTQAY7RSaIL2osnTTuPXywSqdadjb9HanMg1AoF
	3YjTLDTr3nCZ4YbrfZVSzX6Y5SgVEpM1KJCroikarDLEJQuIig5I1qPhmgCXQxslyBqU1N
	FF+FH3nu3TWhq9jirFBr8d4uGBWlCHE2jELEt6i+OjxevYxRQzPI5ZHNXb+9gA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=me@concord.sh smtp.mailfrom=me@concord.sh
Date: Wed, 13 Nov 2024 13:07:15 -0500
From: Kenton Groombridge <me@concord.sh>
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>, bluca@debian.org
Subject: Re: RFC: Adding a dyntrans in systemd pid1's forking
Message-ID: <yu6ym23durwgcu2vvt7vuekyfwzufbicl6t2suiayqn7j5sfa7@7yczpfibdthm>
Mail-Followup-To: Chris PeBenito <chpebeni@linux.microsoft.com>, 
	SELinux mailing list <selinux@vger.kernel.org>, bluca@debian.org
References: <34e77b6f-2c76-4bf9-8e3f-ac01047c952d@linux.microsoft.com>
 <8568d29a-1281-41ae-b693-2cdbff32c333@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxj7v6zpfszgobmz"
Content-Disposition: inline
In-Reply-To: <8568d29a-1281-41ae-b693-2cdbff32c333@linux.microsoft.com>


--pxj7v6zpfszgobmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/11/13 11:07AM, Chris PeBenito wrote:
> On 11/6/2024 10:21 AM, Chris PeBenito wrote:
> > I've recently become aware of systemd's credentials feature[1].=C2=A0 I=
n a
> > nutshell, the intent is to reduce privilege in units by systemd itself
> > copying the credentials (crypto materials, passwords, though in practice
> > it could be anything) and placing it in /run/credentials, with access
> > managed by namespacing.=C2=A0 This is intended to eliminate the need fo=
r the
> > daemon in the unit directly accessing the data.=C2=A0 My concern is the
> > possibility of inadvertently leaking credentials or abuse.=C2=A0 i.e. p=
utting
> > in
> >=20
> > LoadCredential=3Dfoobar:/etc/shadow
> >=20
> > This illustrative, as systemd can't read shadow if it's confined, but
> > you could replace shadow with a private key or any other highly
> > confidential data systemd needs to access.=C2=A0 The common response to=
 my
> > concern is systemd units should be protected at high integrity; only
> > root can modify them, etc.=C2=A0 However, I think we can do better to r=
educe
> > the possibility of errors.
> >=20
> > I've discussed this with one of the systemd maintainers, and I'm
> > proposing this change:
> >=20
> > 1. pid1 forks (to pidN) to run the unit, as usual.
> > 2. pidN does security_compute_create() using the current domain and the
> > label of the unit to get a new domain.
> > 3. pidN does setcon() to the new domain.
> > 4. pidN runs the unit as per usual (including the credentials stuff)
> >=20
> > Then we'd need to add something like this to the policy:
> >=20
> > allow init_t httpd_initrc_t:process dyntransition;
> > type_transition init_t httpd_unit_t:process httpd_initrc_t;
> >=20
> > I have not yet prototyped this, but based on my discussion with the
> > systemd maintainers, this should be doable.=C2=A0 I believe the added b=
enefit
> > is we can decompose initrc_t's privilege and maybe even reduce init_t's
> > privilege.
>=20
> Hearing no objections, I've done an initial implementation:
>=20
> https://github.com/systemd/systemd/compare/main...pebenito:systemd:pidN-s=
elinux-setcon
>=20
> If there is no policy in place, it does not incur new denials.  One nice
> thing I found is that the unit name is available, so I used that in the
> security_compute_create_name_raw() call.  I tested by adding the following
> systemd-networkd.service drop-in:
>=20
> [Service]
> LoadCredential=3Dshadow:/etc/shadow
>=20
>=20
> I added the following to the policy:
>=20
> type systemd_networkd_initrc_t;
> domain_type(systemd_networkd_initrc_t)
> role system_r types systemd_networkd_initrc_t;
> allow init_t self:process setcurrent;
> domain_dyntrans_type(init_t)
> allow init_t systemd_networkd_initrc_t:process dyntransition;
> type_transition init_t systemd_networkd_unit_t:process
> systemd_networkd_initrc_t;
> domtrans_pattern(systemd_networkd_initrc_t, systemd_networkd_exec_t,
> systemd_networkd_t)
>=20
>=20
> These changes resulted in this denial:
>=20
> Nov 13 15:10:54 azurelinux-vm audit[605]: AVC avc:  denied  { read } for
> pid=3D605 comm=3D"(sd-mkdcreds)" name=3D"shadow" dev=3D"sda2" ino=3D18058
> scontext=3Dsystem_u:system_r:systemd_networkd_initrc_t:s0
> tcontext=3Dsystem_u:object_r:shadow_t:s0 tclass=3Dfile permissive=3D1
>=20
>=20
> The remaining policy for systemd_networkd_initrc_t would look like (denia=
ls
> summarized by audit2allow):
>=20
> allow systemd_networkd_initrc_t autofs_t:dir getattr;
> allow systemd_networkd_initrc_t autofs_t:filesystem unmount;
> allow systemd_networkd_initrc_t bin_t:dir { getattr search };
> allow systemd_networkd_initrc_t bin_t:file { execute execute_no_trans
> getattr map open read };
> allow systemd_networkd_initrc_t boot_t:dir search;
> allow systemd_networkd_initrc_t cgroup_t:dir { getattr search };
> allow systemd_networkd_initrc_t cgroup_t:file { getattr mounton };
> allow systemd_networkd_initrc_t cgroup_t:filesystem { getattr remount };
> allow systemd_networkd_initrc_t device_t:dir mounton;
> allow systemd_networkd_initrc_t devlog_t:sock_file write;
> allow systemd_networkd_initrc_t dosfs_t:filesystem remount;
> allow systemd_networkd_initrc_t fs_t:filesystem { remount unmount };
> allow systemd_networkd_initrc_t home_root_t:dir { getattr mounton };
> allow systemd_networkd_initrc_t init_runtime_t:dir { add_name create geta=
ttr
> mounton remove_name rmdir search write };
> allow systemd_networkd_initrc_t init_t:dir search;
> allow systemd_networkd_initrc_t init_t:fd use;
> allow systemd_networkd_initrc_t init_t:file { getattr ioctl open read };
> allow systemd_networkd_initrc_t init_t:unix_stream_socket getattr;
> allow systemd_networkd_initrc_t kernel_t:unix_dgram_socket sendto;
> allow systemd_networkd_initrc_t kmsg_device_t:chr_file { getattr mounton =
};
> allow systemd_networkd_initrc_t modules_object_t:dir { getattr mounton };
> allow systemd_networkd_initrc_t proc_kmsg_t:file { getattr mounton };
> allow systemd_networkd_initrc_t proc_t:file { getattr open read };
> allow systemd_networkd_initrc_t proc_t:filesystem { mount remount unmount=
 };
> allow systemd_networkd_initrc_t root_t:dir mounton;
> allow systemd_networkd_initrc_t self:capability { dac_read_search fowner
> net_admin setgid setpcap setuid sys_resource };
> allow systemd_networkd_initrc_t self:key { search setattr write };
> allow systemd_networkd_initrc_t self:netlink_route_socket { bind create
> getattr getopt nlmsg_read read setopt write };
> allow systemd_networkd_initrc_t self:process { getcap setcap setfscreate
> setrlimit };
> allow systemd_networkd_initrc_t self:unix_dgram_socket { connect create
> getopt setopt };
> allow systemd_networkd_initrc_t shell_exec_t:file getattr;
> allow systemd_networkd_initrc_t sysctl_fs_t:dir { getattr mounton search =
};
> allow systemd_networkd_initrc_t sysctl_kernel_t:dir search;
> allow systemd_networkd_initrc_t sysctl_kernel_t:file { getattr ioctl open
> read };
> allow systemd_networkd_initrc_t syslogd_runtime_t:dir search;
> allow systemd_networkd_initrc_t systemd_networkd_runtime_t:dir { getattr
> mounton open read search watch };
> allow systemd_networkd_initrc_t systemd_networkd_runtime_t:file { getattr
> open read };
> allow systemd_networkd_initrc_t systemd_networkd_t:process2 nnp_transitio=
n;
> ### other than mounton this tmpfs dir/file access is for creating the
> /run/credentials content
> allow systemd_networkd_initrc_t tmpfs_t:dir { add_name create getattr
> mounton open read remove_name search setattr write };
> contents:
> allow systemd_networkd_initrc_t tmpfs_t:file { create getattr open read
> rename setattr write };
> allow systemd_networkd_initrc_t tmpfs_t:filesystem { mount remount unmount
> };
> allow systemd_networkd_initrc_t unlabeled_t:dir mounton;
> allow systemd_networkd_initrc_t user_home_dir_t:dir { getattr mounton };
> allow systemd_networkd_initrc_t user_runtime_root_t:dir { getattr mounton=
 };
>=20
> This seems like a very promising way to break up initrc_t, limit privileg=
es,
> and prevent administrator errors.  What do you think?
>=20
>=20
> --
> Chris
>=20

Overall I like the direction this is going! I am curious, though, about
whether this will affect systemd units' ExecStartPre=3D, ExecStartPost=3D,
and similar directives.

One of the problems I have when writing policy for some systemd units is
these directives will run commands normally under init_t instead of the
resulting daemon domain. A unit may, as an example, want to remove a
file on ExecStartPre=3D, which will run as init_t and therefore will need
to be allowed to do so by policy if the command there is a simple
/bin/rm.

Will this be extended to have these commands run under the unit's
corresponding initrc_t domain if there is one? That would solve so much
headache when dealing with these types of units and also allow breaking
up init_t potentially further.

-Kenton Groombridge

--pxj7v6zpfszgobmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmc06tBfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t54rTBAAoK7SYs51D8ygOM5R5E6zjIx0gQOhilPzIw7uGSw/1a8vCEByOR5z1jzN
gB2TQYkraz6tF/Xeblhpic1y7BvXpGWs/+lNAyYmUuhJM5fGBn5kUz66QXxtNWu+
cbLcCw6oaiakLg35YNs+VwaLjdSXwKbQ2axAccas1CgpTFAb0nKis5cbJNbX9wv+
X3G9uTE/TfDj7gVVlaiZc6OtKkIoRrpDs/auw+fmq4/aPP0vI0g4N15E+zKB28sx
lUstBQ89tcaszQ0v20IJAMGKsxF2/Rr3bJlreOhxJNp2XJQUuLd1iiWzULSMKHX2
O5jV0iJxo4xqwNKBQ8/obJz3v1a5I3ppAiI/uPntgvEeakr0JgN/PBJNeSt7qpYx
nb+t5tSV/TmOnwrULkpd6mH/uekmNpnebBt/N17EpXHya+gAtzDB1gRMT9J335zg
ihwBrLzd5mdw0MehJvF5JG7+NbGAiUecI7wo6r/ROQ0Oc07Lvk0m+9Oe7Fih7tGz
rWVqqCRAIxmf7AzemGC5KthKh0Jx9DKoFMAeothSLAi3o1vUyUe32BezSi7dK1xP
GOlpmywuPt8iZ3fyyiuEum4JvXWsMDOvPwTtydPRBoJiX0J4oU4czOAPiUCUx7FE
zwJuHKE1aAK4YjGcsHkxirBAucNkyY5tjsoVQ1TU3WVOWQbIho0=
=TScn
-----END PGP SIGNATURE-----

--pxj7v6zpfszgobmz--
