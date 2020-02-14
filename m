Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DFC2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DC620873
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdcxopjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgBNIzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:55:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41475 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNIzD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 03:55:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so9968081wrw.8
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBPnWCnr+Ol3KWwXg62ikaZxSD3Ps5fCqW22rWtBwfQ=;
        b=DdcxopjFvLMLK7K5HK1/b9wCZdyqZwyuhP4xXDZ90J2pbXhJpcdi6xEyB5SiPfN1ha
         RRp5BDc0aL47JxDhpiYSxQMNI2PtCXvtBZ+8MaCribPj71eXyQW5UD4SLFnk0HQ7E7Bb
         IplBj1qjcXoKNKb5FdbI6T/Y9kIaU3+y7wcNM1214c90+zeIpz29Rf8GLlsT5tCnMbQm
         dXuidRGELj5P1ctEuQ0t80Ubc7xpzPFnpMH9PlyHGZ5A/8W6alrxhxk+NxvmHrVAur2J
         Yy2iYwg5/pYsZuEZ5osh+fJn89YdWdl80hcnjW8J4SRLdKp8Pcang+hKhz2CkVh4b2hN
         mtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XBPnWCnr+Ol3KWwXg62ikaZxSD3Ps5fCqW22rWtBwfQ=;
        b=iDxc3mc5gVO1R0lo+z2t42LjOmK72SGFxGgM6jhlRabiPPYItlSwpSk4p4f5OrZCoK
         BTZvk1amC+d9odJPl7XK7P82lwbsuzZ8VGEiDD/WcEUBohPB4urv5nQf6jdbJV1pm/Nt
         AytxTVCnfkG0z4jhkJqi4XZeL9kBfSooR1dzU/CsiTM+IMv/g16QpwAon3KQWqlgP+h1
         HBHIyKdfZzgYeQiZEOnnRKkImeVTclkgn2O1CUZRWv5COmCZ/o/eCvLNwKTCYI17VjTN
         TEtqZkZySwp6S96hqmo8/BpM4fjlraGpf6tSAE4nBOVfo6gmvnMNfWVkEegeDTy1d5I7
         6sBw==
X-Gm-Message-State: APjAAAUXdlfjHxh8WAwA2pT/LIVEqRa/kOzlNrybCxVxk4sDslvenKob
        QSq848wM2MbRjiRD7mV1ECbEquQZ
X-Google-Smtp-Source: APXvYqyhfkaRJx2xDJt38Rvpc65VkafBC+uuQDOcw+FWcmQ7XSG4y3WwIyGbKerSG56PgYI+Ctx/Rw==
X-Received: by 2002:adf:f310:: with SMTP id i16mr2904123wro.326.1581670499840;
        Fri, 14 Feb 2020 00:54:59 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id h205sm6607019wmf.25.2020.02.14.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:54:58 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:54:55 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org, omosnace@redhat.com
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve
 handling
Message-ID: <20200214085455.GA2050498@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, omosnace@redhat.com
References: <20200129164256.3190-1-sds@tycho.nsa.gov>
 <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 09:13:09AM -0500, Stephen Smalley wrote:
> On 1/29/20 11:42 AM, Stephen Smalley wrote:
> > Remove initial SIDs that have never been used or are no longer
> > used by the kernel from its string table, which is also used
> > to generate the SECINITSID_* symbols referenced in code.
> > Update the code to gracefully handle the fact that these can
> > now be NULL. Stop treating it as an error if a policy defines
> > additional initial SIDs unknown to the kernel.  Do not
> > load unused initial SID contexts into the sidtab.
> > Fix the incorrect usage of the name from the ocontext in error
> > messages when loading initial SIDs since these are not presently
> > written to the kernel policy and are therefore always NULL.
> >=20
> > This is a first step toward enabling future evolution of
> > initial SIDs. Further changes are required to both userspace
> > and the kernel to fully address
> > https://github.com/SELinuxProject/selinux-kernel/issues/12
> > but this takes a small step toward that end.
> >=20
> > Fully decoupling the policy and kernel initial SID values will
> > require introducing a mapping between them and dyhamically
> > mapping them at load time.
> >=20
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>=20
> Any objections, acks/reviews, or other questions/comments on this patch?
> The GitHub issue has a more detailed discussion of how we can safely reuse
> and eventually increase the number of initial SIDs in the future.

I encourage this initiative from a user perspective. Having to be aware of/=
address legacy when writing policy is a distraction (just like having to be=
 aware of ordering for that matter)
Even removing the requirement to define sidcons for unused sids is a step i=
n a good direction. In documenting my policy I noticed how often my explana=
tion boils down to:  "This is a historical artifact".

>=20
> > ---
> > v2 avoids loading all unused initial SID contexts into the sidtab,
> > not just ones beyond SECINITSID_NUM.  It also drops the unnecessary
> > check for an undefined context because all contexts in the OCON_ISID
> > list were already validated at load time via context_read_and_validate(=
).
> >=20
> >   scripts/selinux/genheaders/genheaders.c       | 11 +++-
> >   .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
> >   security/selinux/selinuxfs.c                  |  6 +-
> >   security/selinux/ss/policydb.c                | 25 ++++----
> >   security/selinux/ss/services.c                | 26 ++++-----
> >   5 files changed, 66 insertions(+), 59 deletions(-)
> >=20
> > diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/=
genheaders/genheaders.c
> > index 544ca126a8a8..f355b3e0e968 100644
> > --- a/scripts/selinux/genheaders/genheaders.c
> > +++ b/scripts/selinux/genheaders/genheaders.c
> > @@ -67,8 +67,12 @@ int main(int argc, char *argv[])
> >   	}
> >   	isids_len =3D sizeof(initial_sid_to_string) / sizeof (char *);
> > -	for (i =3D 1; i < isids_len; i++)
> > -		initial_sid_to_string[i] =3D stoupperx(initial_sid_to_string[i]);
> > +	for (i =3D 1; i < isids_len; i++) {
> > +		const char *s =3D initial_sid_to_string[i];
> > +
> > +		if (s)
> > +			initial_sid_to_string[i] =3D stoupperx(s);
> > +	}
> >   	fprintf(fout, "/* This file is automatically generated.  Do not edit=
=2E */\n");
> >   	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\=
n\n");
> > @@ -82,7 +86,8 @@ int main(int argc, char *argv[])
> >   	for (i =3D 1; i < isids_len; i++) {
> >   		const char *s =3D initial_sid_to_string[i];
> > -		fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
> > +		if (s)
> > +			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
> >   	}
> >   	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
> >   	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 ker=
n_tclass)\n");
> > diff --git a/security/selinux/include/initial_sid_to_string.h b/securit=
y/selinux/include/initial_sid_to_string.h
> > index 4f93f697f71c..5d332aeb8b6c 100644
> > --- a/security/selinux/include/initial_sid_to_string.h
> > +++ b/security/selinux/include/initial_sid_to_string.h
> > @@ -1,34 +1,33 @@
> >   /* SPDX-License-Identifier: GPL-2.0 */
> > -/* This file is automatically generated.  Do not edit. */
> >   static const char *initial_sid_to_string[] =3D
> >   {
> > -    "null",
> > -    "kernel",
> > -    "security",
> > -    "unlabeled",
> > -    "fs",
> > -    "file",
> > -    "file_labels",
> > -    "init",
> > -    "any_socket",
> > -    "port",
> > -    "netif",
> > -    "netmsg",
> > -    "node",
> > -    "igmp_packet",
> > -    "icmp_socket",
> > -    "tcp_socket",
> > -    "sysctl_modprobe",
> > -    "sysctl",
> > -    "sysctl_fs",
> > -    "sysctl_kernel",
> > -    "sysctl_net",
> > -    "sysctl_net_unix",
> > -    "sysctl_vm",
> > -    "sysctl_dev",
> > -    "kmod",
> > -    "policy",
> > -    "scmp_packet",
> > -    "devnull",
> > +	NULL,
> > +	"kernel",
> > +	"security",
> > +	"unlabeled",
> > +	NULL,
> > +	"file",
> > +	NULL,
> > +	NULL,
> > +	"any_socket",
> > +	"port",
> > +	"netif",
> > +	"netmsg",
> > +	"node",
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	NULL,
> > +	"devnull",
> >   };
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 79c710911a3c..daddc880ebfc 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1692,7 +1692,11 @@ static int sel_make_initcon_files(struct dentry =
*dir)
> >   	for (i =3D 1; i <=3D SECINITSID_NUM; i++) {
> >   		struct inode *inode;
> >   		struct dentry *dentry;
> > -		dentry =3D d_alloc_name(dir, security_get_initial_sid_context(i));
> > +		const char *s =3D security_get_initial_sid_context(i);
> > +
> > +		if (!s)
> > +			continue;
> > +		dentry =3D d_alloc_name(dir, s);
> >   		if (!dentry)
> >   			return -ENOMEM;
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 2aa7f2e1a8e7..768a9d4e0b86 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -865,29 +865,28 @@ int policydb_load_isids(struct policydb *p, struc=
t sidtab *s)
> >   	head =3D p->ocontexts[OCON_ISID];
> >   	for (c =3D head; c; c =3D c->next) {
> > -		rc =3D -EINVAL;
> > -		if (!c->context[0].user) {
> > -			pr_err("SELinux:  SID %s was never defined.\n",
> > -				c->u.name);
> > -			sidtab_destroy(s);
> > -			goto out;
> > -		}
> > -		if (c->sid[0] =3D=3D SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
> > -			pr_err("SELinux:  Initial SID %s out of range.\n",
> > -				c->u.name);
> > +		u32 sid =3D c->sid[0];
> > +		const char *name =3D security_get_initial_sid_context(sid);
> > +
> > +		if (sid =3D=3D SECSID_NULL) {
> > +			pr_err("SELinux:  SID null was assigned a context.\n");
> >   			sidtab_destroy(s);
> >   			goto out;
> >   		}
> > +
> > +		/* Ignore initial SIDs unused by this kernel. */
> > +		if (!name)
> > +			continue;
> > +
> >   		rc =3D context_add_hash(p, &c->context[0]);
> >   		if (rc) {
> >   			sidtab_destroy(s);
> >   			goto out;
> >   		}
> > -
> > -		rc =3D sidtab_set_initial(s, c->sid[0], &c->context[0]);
> > +		rc =3D sidtab_set_initial(s, sid, &c->context[0]);
> >   		if (rc) {
> >   			pr_err("SELinux:  unable to load initial SID %s.\n",
> > -				c->u.name);
> > +			       name);
> >   			sidtab_destroy(s);
> >   			goto out;
> >   		}
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 216ce602a2b5..bd924a9a6388 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1323,23 +1323,22 @@ static int security_sid_to_context_core(struct =
selinux_state *state,
> >   	if (!selinux_initialized(state)) {
> >   		if (sid <=3D SECINITSID_NUM) {
> >   			char *scontextp;
> > +			const char *s =3D initial_sid_to_string[sid];
> > -			*scontext_len =3D strlen(initial_sid_to_string[sid]) + 1;
> > +			if (!s)
> > +				return -EINVAL;
> > +			*scontext_len =3D strlen(s) + 1;
> >   			if (!scontext)
> > -				goto out;
> > -			scontextp =3D kmemdup(initial_sid_to_string[sid],
> > -					    *scontext_len, GFP_ATOMIC);
> > -			if (!scontextp) {
> > -				rc =3D -ENOMEM;
> > -				goto out;
> > -			}
> > +				return 0;
> > +			scontextp =3D kmemdup(s, *scontext_len, GFP_ATOMIC);
> > +			if (!scontextp)
> > +				return -ENOMEM;
> >   			*scontext =3D scontextp;
> > -			goto out;
> > +			return 0;
> >   		}
> >   		pr_err("SELinux: %s:  called before initial "
> >   		       "load_policy on unknown SID %d\n", __func__, sid);
> > -		rc =3D -EINVAL;
> > -		goto out;
> > +		return -EINVAL;
> >   	}
> >   	read_lock(&state->ss->policy_rwlock);
> >   	policydb =3D &state->ss->policydb;
> > @@ -1363,7 +1362,6 @@ static int security_sid_to_context_core(struct se=
linux_state *state,
> >   out_unlock:
> >   	read_unlock(&state->ss->policy_rwlock);
> > -out:
> >   	return rc;
> >   }
> > @@ -1553,7 +1551,9 @@ static int security_context_to_sid_core(struct se=
linux_state *state,
> >   		int i;
> >   		for (i =3D 1; i < SECINITSID_NUM; i++) {
> > -			if (!strcmp(initial_sid_to_string[i], scontext2)) {
> > +			const char *s =3D initial_sid_to_string[i];
> > +
> > +			if (s && !strcmp(s, scontext2)) {
> >   				*sid =3D i;
> >   				goto out;
> >   			}
> >=20
>=20

--=20
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5GYFkACgkQAlFoDzf+
eRMdNg//X2dyAnev6xb9wplw6qUShDfdsvPf7Fvd2+9KwyaR5SW4bwwleoZmjHh7
0yaWQRMOlchBLQftXJ+TSr4ng0EfO9bIUjF4cx2F4hdkTwjznY0ED8RVIuXuJ+7j
+MFLR33ddsnS1aRdUeoAX9C9bSjFqiFGnpeCkdUhPX4qdQ5LNaZjkAzNFALdE+bK
4FH5BdcLc6TUBroKlhZW0UWu/4OWagXajZXctmDMfyIWaTlZLsTj1l9XLM8WM3YO
lJ61XjqQspGLidbeRBncK43AE1c+uu10H9YQkiiiefXLiOXRvPXZyAtc5FZqNv5y
CNmtKGMwZxZHu17TyVbUi0yd1ui71T2uXU8XDaZRgstAzFagoHfuPD/s7lqz2jXN
/Hncj7gIXGNyiHIsCBfbeBlEyJJYgcjkKoBdpsulyBMU7CviYwLecPN2VZRA4eMs
QAj6HOq+vyWg7uLwxr4btVAh1Eio/9tQ745WvqeyCJxIy/vio1O6xlpDLXyx0JhW
xNXfLMY7766zIwm+LtDuWMP3Fdk/hxD4ERv223dPOxpIoL5QhqioHHVNiuce8DoL
E1J+SWfg/dMTVqNs73g+lE9D5FCAyfUnn/IFUCuobS6cUM30Zzn5m/gzPKYQeJmq
WxRQDQc2sBDQyKfhGHQFOSXTma9a5J8kisfWCJxnuqH4thCfJ3o=
=VnH0
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
