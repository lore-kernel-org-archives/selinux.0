Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA279C0
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397653; cv=none; b=skudiRKNH8HE5Qm64YENSYJz5SW/Ko7WtPeD5ROjoMM+V0z6pPt9vSuV3SZ7ZvDUkcPJjLuIM5Rtv837JQlpM03szklZT94HHJLSqmVati647Eoytb/brQYRwHyQAJe9RR4sKGRvsNtM6akGN1rGkNNC39GG1VtPmuke9vxdC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397653; c=relaxed/simple;
	bh=Sn2VOZRV1HNgG9jNppqr+EAClzVi1Ruj1Kn22fOLh+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZRj5Spa7+r/6UkFy97MZ1c2TWWbU26f9cj62Co6j/SV0snT3yyPvKKte/7icX8W6bJls9si2xjPlTWN4KQCZvs0Qex4NpiaRFR0bhHHfqZau8N2N5rcwR/RKm8x0uRK3z/IgXu5DSgyR9HbFJ1yTNraDdLRrbMi08leMSqxxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hp65S3Si; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hp65S3Si; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hp65S3Si";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hp65S3Si"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59AE81FF49;
	Wed, 19 Mar 2025 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742397649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sn2VOZRV1HNgG9jNppqr+EAClzVi1Ruj1Kn22fOLh+M=;
	b=Hp65S3SiEEXjFtWwSns2aN485YNz6GQBBVsWC3FL+tbNIOtzsKY0kVLbLJnMbZLvNeXQ3s
	dipTVqWpilEFL0JFqp/4aWOqj3ZnZ0Ty1hcXBKfTit1txP38nkrpvRdWJXm5iYQVdbS3Dm
	0g10XvTgpuhY1+UOCBI98JAcqdWANb4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742397649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sn2VOZRV1HNgG9jNppqr+EAClzVi1Ruj1Kn22fOLh+M=;
	b=Hp65S3SiEEXjFtWwSns2aN485YNz6GQBBVsWC3FL+tbNIOtzsKY0kVLbLJnMbZLvNeXQ3s
	dipTVqWpilEFL0JFqp/4aWOqj3ZnZ0Ty1hcXBKfTit1txP38nkrpvRdWJXm5iYQVdbS3Dm
	0g10XvTgpuhY1+UOCBI98JAcqdWANb4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1165613A2C;
	Wed, 19 Mar 2025 15:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F1r9AtHg2mfDRgAAD6G6ig
	(envelope-from <fvogt@suse.com>); Wed, 19 Mar 2025 15:20:49 +0000
From: Fabian Vogt <fvogt@suse.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 William Roberts <bill.c.roberts@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
 Cathy Hu <cahu@suse.de>, selinux@suse.de
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
Date: Wed, 19 Mar 2025 16:20:48 +0100
Message-ID: <19802444.fSG56mABFh@fabians-envy>
Organization: SUSE Linux GmbH
In-Reply-To:
 <CAFftDdqhoXSFzTGS4682apa+MtVWWEqnC29WVbQQXfsVqZ+svA@mail.gmail.com>
References:
 <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
 <CAEjxPJ5rG5yfwB=8aH8iDFTXgo8W8JBmjLMA7A5q_eMbEJmgaw@mail.gmail.com>
 <CAFftDdqhoXSFzTGS4682apa+MtVWWEqnC29WVbQQXfsVqZ+svA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

Hi,

Am Mittwoch, 19. M=C3=A4rz 2025, 15:35:58 Mitteleurop=C3=A4ische Normalzeit=
 schrieb William Roberts:
> On Wed, Mar 19, 2025 at 8:25=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 9:16=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 9:11=E2=80=AFAM Petr Lautrbach <lautrbach@red=
hat.com> wrote:
> > > >
> > > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > > >
> > > > > On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach=
@redhat.com> wrote:
> > > > >>
> > > > >> Cathy Hu <cahu@suse.de> writes:
> > > > >>
> > > > >> > On 17.03.25 15:29, Petr Lautrbach wrote:
> > > > >> >>
> > > > >> >> You could use `-e <directory>` to exclude read only subdirect=
ories.
> > > > >> >>
> > > > >> >
> > > > >> > Yes that is possible, but also requires a manual change by the=
 user to set
> > > > >> > this up together with the snapshot (same as telling them to ad=
d <<none>>),
> > > > >> > which we would like to avoid.
> > > > >>
> > > > >> Your -relabel.service's are generated and so can be restorecon o=
ptions
> > > > >> there.
> > > > >>
> > > > >> Fedora uses fixfiles -
> > > > >> https://github.com/SELinuxProject/selinux/blob/main/policycoreut=
ils/scripts/fixfiles
> > > > >> - which detects ro filesystems and skip them.
> > > > >
> > > > > We already have logic in libselinux/src/selinux_restorecon.c to
> > > > > exclude filesystems that lack seclabel support; should we augment=
 this
> > > > > to also exclude read-only filesystems to avoid the need to work a=
round
> > > > > this in all callers?
> > > > >
> > > > https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/=
selinux_restorecon.c#L238
> > > >
> > > > You're right, I didn't know about that.
> > > >
> > > > I think it would make sense to exclude also `ro` mount points.

Note that btrfs subvolumes don't necessarily show up as separate mount poin=
ts:
Essentially any directory could be a subvolume. That makes it rather annoyi=
ng
to gather a complete list for -e before calling restorecon (would need full=
 FS
traversal).

To detect ro subols in restorecon, changes of st_dev need to be detected.
Quoting my comment from bugzilla:

> (Some notes for d): This could be implemented in restorecon by adding to =
the
> if (ftsent->fts_statp->st_dev !=3D state->dev_num) check. The
> BTRFS_IOC_SUBVOL_GETFLAGS ioctl can be called on that FD and the result
> checked against BTRFS_SUBVOL_RDONLY. That is not too complex or expensive=
 and
> does not need additional dependencies on e.g. libbtrfs.)

That leaves the question of what to do with that info. At first maybe just =
set
a flag that it's within a read-only subvol and soften error handling, i.e.
this:

> > > I think the tricky part is the case where the caller deliberately
> > > passed those mount points to restorecon/setfiles. The current
> > > exclusion logic IIRC won't exclude any explicitly passed directories
> > > to avoid silently failing. But skipping read-only mounts on a
> > > traversal of a subdirectory would make sense IMHO.
> >
> > Actually, maybe not. Scenario: Read-only mount on a higher level
> > directory with read-write mount of a lower level directory (e.g.
> > read-only / with a writable /var), and restorecon or setfiles invoked
> > on /.
> > Maybe it is best to just defer this to the callers.
>=20
> You beat me to this, I had a draft sitting in my inbox. My suggestion
> was to report that it occured, but not
> fail and keep going if the return code is for read only failure.

Cheers,
=46abian

> > > > >> > Is there a reason why these r-o subvolumes are not skipped by =
default?
> > > > >> > Could they be skipped without a problem and it is just missing=
 the implementation?
> > > > >> >
> > > > >> > Thanks :)
> > > > >> >
> > > > >> > Kind regards,
> > > > >> > Cathy
> > > > >> >
> > > >
> >
>=20




