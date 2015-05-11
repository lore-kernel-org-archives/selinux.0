Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4BFS4vJ011455
 for <selinux@tycho.nsa.gov>; Mon, 11 May 2015 11:28:04 -0400
Received: by wizk4 with SMTP id k4so110352285wiz.1
 for <selinux@tycho.nsa.gov>; Mon, 11 May 2015 08:28:02 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id hn7sm311117wib.5.2015.05.11.08.28.00
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2015 08:28:00 -0700 (PDT)
Date: Mon, 11 May 2015 17:27:58 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
Message-ID: <20150511152757.GD10375@x131e>
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
In-Reply-To: <5550C212.6090702@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 10:52:02AM -0400, Stephen Smalley wrote:
> On 05/11/2015 10:11 AM, Petr Lautrbach wrote:
> > On 05/11/2015 04:04 PM, Stephen Smalley wrote:
> >> On 05/11/2015 10:02 AM, Stephen Smalley wrote:
> >>> On 05/11/2015 09:49 AM, Petr Lautrbach wrote:
> >>>> On 05/11/2015 03:43 PM, Stephen Smalley wrote:
> >>>>> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
> >>>>>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
> >>>>>>> SELinux can be disabled via the selinux=3D0 kernel parameter or v=
ia
> >>>>>>> /sys/fs/selinux/disable (triggered by setting SELINUX=3Ddisabled =
in
> >>>>>>> /etc/selinux/config).  In either case, selinuxfs will be unmounted
> >>>>>>> and unregistered and therefore it is sufficient to check for the
> >>>>>>> selinuxfs mount.  We do not need to check for no-policy-loaded and
> >>>>>>> treat that as SELinux-disabled anymore; that is a relic of Fedora=
 Core 2
> >>>>>>> days.  Drop the no-policy-loaded test, which was a bit of a hack =
anyway
> >>>>>>> (checking whether getcon_raw() returned "kernel" as that can only=
 happen
> >>>>>>> if no policy is yet loaded and therefore security_sid_to_context(=
) only
> >>>>>>> has the initial SID name available to return as the context).
> >>>>>>>
> >>>>>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=3D11=
95074
> >>>>>>> by virtue of removing the call to getcon_raw() and therefore avoi=
ding
> >>>>>>> use of tls on is_selinux_enabled() calls.  Regardless, it will ma=
ke
> >>>>>>> is_selinux_enabled() faster and simpler.
> >>>>>>>
> >>>>>>
> >>>>>> This patch breaks system with SELinux enabled kernel and without
> >>>>>> loaded/installed an SELinux policy, see [1].
> >>>>>>
> >>>>>> Would it be feasible to have is_selinux_enabled() connected to exi=
stence
> >>>>>> of SELINUX variable in /etc/selinux/config file for the cases when
> >>>>>> there's no specific kernel command line option used in running sys=
tem?
> >>>>>> Or would it break something else?
> >>>>>>
> >>>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1219045
> >>>>>
> >>>>> Sorry, does this occur even if they have SELINUX=3Ddisabled in
> >>>>> /etc/selinux/config?
> >>>>
> >>>> It works with SELINUX=3Ddisabled. It's only related to systems witho=
ut
> >>>> /etc/selinux/config and without selinux=3D0 on kernel command line.
> >>>
> >>> I see.  So I can see that it is a regression for such systems, but su=
ch
> >>> systems are definitely running suboptimally by NOT disabling SELinux =
if
> >>> they are not going to even load a policy.  They are just wasting all =
of
> >>> the SELinux hook call overhead in the kernel.
> >=20
> > I agree.
> >=20
> >>>
> >>> In any event, one of the benefits of the change that caused this
> >>> regression is that it makes is_selinux_enabled() very fast and avoids
> >>> any need to open any extra files on calls to it, thereby improving
> >>> performance on both SELinux-enabled and SELinux-disabled systems.
> >>>
> >>> I don't think we need or want to actually have it read
> >>> /etc/selinux/config and look for a SELINUX=3D variable.  Isn't it
> >>> sufficient to test for the existence of an /etc/selinux/config file,
> >>> e.g. access("/etc/selinux/config", F_OK)?
> >=20
> > I'm fine with that.
> >=20
> >>>
> >>> We'll have to wrap that test with #ifndef ANDROID as Android does not
> >>> use /etc/selinux/config.
> >>
> >> Oh, and let's do it once in init_selinuxmnt() and cache the result so =
we
> >> aren't calling access() on each is_selinux_enabled() call.
> >=20
> > Do you want me to prepare and send a patch?
>=20
> See if my patch solves the problem.  I do however see one other
> potential scenario that could occur in Fedora, i.e. where they have
> selinux-policy installed (and thus have an /etc/selinux/config) but do
> not have selinux-policy-targeted installed (and thus do not have any
> /etc/selinux/targeted).  Not sure how far down this path we should travel=
=2E..
>=20

I think i actually encountered a person with just that configuration.

He was trying to set up SELinux on Debian but, i believe, Debian (Jesse) no=
 longer ship with a policy by default.

So he did have a /etc/selinux/config (with a selinuxtype of default) but /e=
tc/selinux/default did not exist

I suppose he manually created /etc/selinux/config but i am not sure.

Not sure if one would want to support this, i agree, but thought i'd just m=
ention it

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVUMp4AAoJENAR6kfG5xmcLVoMAK4ygn/lnwtFNRXkOwD35B46
yK9dcKl/ISgts78nzrq+n+5nMZkk8TBHqpwFiJNvbces1ErxBcVh1sG4wwX9dD8l
VyjVbSQTsY5Ijb7prhEFFwP/YPUW1SGgGYgq4AX7RtdTEos18OFfmSM5JMhFp6Mu
6ZbiZFeQWyMgf8uH33h9L2erGiipZ4hzarFmV621rg25bR5ZaRkVvBfLxR1qSJLE
wsXWJf+qMupEJUuPHHq+VMs1eNHARWK/J2p4Z9NLS07rMYtfC3DF433Zy6j8TIWd
B1H9WDZnUMj+YS1xcvVDFOzshbkEcQfyScqKz+vUszZjD15B5ZpQ8SjlEIKeHHLB
UhQAgyUYBRV+RFO4yGqi0UjC7EFJB+3mSgoMP//7UXNjN2cIsDmyzhzEsg29UJWP
GIvGL8itMlnlLrBbDcnf9V6WmrIz1yJC5LvHFvkai6QPZgojchG8blwpP/+CN3Ja
+ozhTLE1oHRdXdAg5arDUbY4jqQFwpHowrnANivBrQ==
=qtAJ
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
