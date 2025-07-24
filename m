Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CD2E401
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335251; cv=none; b=EuUkNW+BG9UuHpZ9jZRrxHU2ND9loQ6B6VHmu6ERzvcM3UlYC2bYwltZaN3RENTdMF+AdmOVqj1jMC1OIfHYlYEILJOtVr/Rb6hWiZS/d20gG+dl2PkI4W45bEbpI49ztOd0xKy54j896J+OVxl/cGriFiqr+5x6TCgAhnlGHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335251; c=relaxed/simple;
	bh=OD9C9LMY+wXEIesgVQyPpU712uFxrvCdTQV8jMo24HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7F+dra1OjRyK5ps00hZ2iGwXS17tsKolsBxBu8Mpt/z8HVWZr54Zi3gMLOUMGQ3uNgNwRNdMDKtVmi8PMuuoOMUvVa+Ou7HbOoykQn6oQtaq+43uiputSzys3QsT83qEDlrWmdTWXj5G45zvkyAghhpBWpJDVxn/Vqj7HCYkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=KPq6SmQv; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="KPq6SmQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1753335240;
	bh=OD9C9LMY+wXEIesgVQyPpU712uFxrvCdTQV8jMo24HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KPq6SmQvH7i6ZTNGk05D+fFafwbx1BJ3zTqzTixTPP3T6VfBt4gyc9TTXWHl2wST0
	 LBeD9rqoOleE/DIiw57qyVlWLl9kxSXjSIh9Idy48PcMrYvYxPH1uwWQ9xIFK+tWAz
	 mYbX+HCVXy0FHSbze++bd17iic7hxfi1t1XoMtBI=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 9662F1B3A6F;
	Thu, 24 Jul 2025 07:34:00 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: systemd.exec(5) PAMName= with libselinux
In-Reply-To: <87tt324t1q.fsf@defensec.nl> (Dominick Grift's message of "Wed,
	23 Jul 2025 21:16:01 +0200")
References: <87jz42dj60.fsf@defensec.nl>
	<CAEjxPJ7dcbX+gUQ5UGnM5+zCA2qKZMdxJ0QqBFnbPe12WyKMuw@mail.gmail.com>
	<87tt34yqcc.fsf@defensec.nl> <87tt324t1q.fsf@defensec.nl>
Date: Thu, 24 Jul 2025 07:34:00 +0200
Message-ID: <87pldq40fr.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dominick Grift <dominick.grift@defensec.nl> writes:

> Dominick Grift <dominick.grift@defensec.nl> writes:
>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>>> On Mon, Jul 21, 2025 at 4:53=E2=80=AFAM Dominick Grift
>>> <dominick.grift@defensec.nl> wrote:
>>>>
>>>>
>>>> systemd has an identity directive called PAMName=3D which allows you to
>>>> run a unit with a specified PAM stack. The issue here is that in this
>>>> case the "session leader" is always systemd.
>>>>
>>>> Thus you get into issues with pam_selinux because since systemd is for
>>>> example always associated with "init_t" you can't really specify log
>>>> SELinux identity foo_u in with foo_r:foo_t:s0 if this PAM stack is used
>>>> and log SELinux identity foo_u in with bar_r:bar_t:s0 if that PAM stack
>>>> is used.
>>>>
>>>> This previously was not a big issue since this feature is pretty niche
>>>> but with the advent of `run0` it became an issue since that relies on
>>>> PAMName=3D
>>>>
>>>> The problem is that pam_selinux is often already used to start the
>>>> systemd --user instance, for example:
>>>>
>>>> /etc/selinux/TYPE/contexts/users/foo_u (/etc/pam.d/systemd-user):
>>>> system_r:init_t:s0 foo_r:foo_systemd_user_instance_t:s0
>>>>
>>>> So you can't add the following because it would conflict
>>>>
>>>> /etc/selinux/TYPE/contexts/user/foo_u (/etc/pam.d/run0):
>>>> system_r:init_t:s0 foo_r:foo_shell_t:s0
>>>>
>>>> Ideas? Suggestions?
>>>
>>> I probably don't understand your question, but systemd --user
>>> instances on my Fedora system are running in the user's context, not
>>> in init_t. If you have two processes with the same context logging in
>>> as the same user, then there isn't any way to distinguish and it is
>>> unclear on what basis you would distinguish.
>
> Here is a log from the pam_selinux pam_close_session issue:
>
> kcinimod@nimbus ~ $ getenforce && id -Z && ls -alZ `tty`
> Enforcing
> wheel.id:wheel.role:user.subj:s0
> crw-------. 1 kcinimod tty wheel.id:wheel.role:user.ptytermdev:s0 136, 8 =
Jul 23 21:12 /dev/pts/8
> kcinimod@nimbus ~ $ run0
> =3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.systemd1.manage-units =3D=
=3D=3D=3D
> Authentication is required to start transient unit 'run-p655631-i655931.s=
ervice'.
> Authenticating as: kcinimod
> Password:=20
> =3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D=3D
> =F0=9F=A6=B8 root@nimbus:/home/kcinimod# getenforce && id -Z && ls -alZ `=
tty`
> Enforcing
> sys.id:sys.role:sys.user.subj:s0
> crw-------. 1 root tty sys.id:sys.role:sys.ptytermdev:s0 136, 10 Jul 23 2=
1:13 /dev/pts/10
> =F0=9F=A6=B8 root@nimbus:/home/kcinimod# systemctl --user
> --machine=3Dkcinimod@.host daemon-reload
> =F0=9F=A6=B8 root@nimbus:/home/kcinimod# getenforce && id -Z && ls -alZ `=
tty`
> Enforcing
> sys.id:sys.role:sys.user.subj:s0
> crw-------. 1 root tty wheel.id:wheel.role:user.ptytermdev:s0 136, 10 Jul=
 23 21:13 /dev/pts/10
> =F0=9F=A6=B8 root@nimbus:/home/kcinimod# journalctl --grep "pam_selinux\(=
login"
> Jul 23 21:13:23 nimbus (sd-pam)[655719]: pam_selinux(login:session):
> Setting file context "sys.id:sys.role:sys.ptytermdev:s0" failed for
> /dev/pts/10: Operation not permitted

Found a hint: its using the session from /etc/pam.d/login for this (PAMName=
=3Dlogin)
and I am not sure if that is right.

I edited /etc/pam.d/login and appended nottys to the pam_selinux open
call just to test and the results look promising.

Need to figure out why its using /etc/pam.d/login for this because that
seems less than optimal.

kcinimod@nimbus ~ $ getenforce && id -Z && ls -alZ `tty`
Enforcing
wheel.id:wheel.role:user.subj:s0
crw-------. 1 kcinimod tty wheel.id:wheel.role:user.ptytermdev:s0 136, 8 Ju=
l 24 07:21 /dev/pts/8
kcinimod@nimbus ~ $ run0
=3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.systemd1.manage-units =3D=
=3D=3D=3D
Authentication is required to start transient unit 'run-p680430-i680730.ser=
vice'.
Authenticating as: kcinimod
Password:=20
=3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D=3D
=F0=9F=A6=B8 root@nimbus:/home/kcinimod# getenforce && id -Z && ls -alZ `tt=
y`
Enforcing
sys.id:sys.role:sys.user.subj:s0
crw-------. 1 root tty sys.id:sys.role:sys.ptytermdev:s0 136, 10 Jul 24 07:=
21 /dev/pts/10
=F0=9F=A6=B8 root@nimbus:/home/kcinimod# systemctl --user --machine=3Dkcini=
mod@.host daemon-reload
=F0=9F=A6=B8 root@nimbus:/home/kcinimod# getenforce && id -Z && ls -alZ `tt=
y`
Enforcing
sys.id:sys.role:sys.user.subj:s0
crw-------. 1 root tty sys.id:sys.role:sys.ptytermdev:s0 136, 10 Jul 24 07:=
21 /dev/pts/10
=F0=9F=A6=B8 root@nimbus:/home/kcinimod# exit
logout
kcinimod@nimbus ~ $ getenforce && id -Z && ls -alZ `tty`
Enforcing
wheel.id:wheel.role:user.subj:s0
crw-------. 1 kcinimod tty wheel.id:wheel.role:user.ptytermdev:s0 136, 8
Jul 24 07:25 /dev/pts/8




> =F0=9F=A6=B8 root@nimbus:/home/kcinimod# exit
> logout
> kcinimod@nimbus ~ $ getenforce && id -Z && ls -alZ `tty`
> Enforcing
> wheel.id:wheel.role:user.subj:s0
> crw-------. 1 kcinimod tty wheel.id:wheel.role:user.ptytermdev:s0 136, 8 =
Jul 23 21:14 /dev/pts/8
> kcinimod@nimbus ~ $
>
>>
>> Lets take refpolicy as a reference here.
>>
>> https://github.com/SELinuxProject/refpolicy/blob/main/config/appconfig-m=
cs/staff_u_default_contexts
>>
>> line one. Basically that causes pid1 to execute a systemd --user
>> instance for staff_u users using pam_selinux and user@UID.service which
>> has the PAMName=3D directive set to systemd-user (this tells systemd to
>> use the /etc/pam.d/systemd-user pam configuration)
>>
>> systemd --user instances are very intrusive and one might not want to
>> run it in the user login shell domain for this reason.
>>
>> The PAMName=3D directive can use used to run all kinds of things with a
>> session. the `run0` functionality is one (PAMName=3Drun0 ->
>> /etc/pam.d/run0) but it could be anything. Simply use PAMName=3D in a
>> service unit to tell systemd what PAM config to use.
>>
>> I am not very familiar with pam but one thing that came to my mind which
>> i am sure is not very robust is to make the pam_selinux syntax a bit
>> more "smarter" by using something similar to name-based type transition
>> rules. For example to differentiate between PAMName=3Dsystemd-user and
>> PAMName=3Drun0:
>>
>> /etc/selinux/TYPE/contexts/users/staff_u
>> system_r:init_t:s0 staff_r:user_systemd_t:s0 "systemd-user"
>> system_r:init_t:s0 staff_r:staff_t:s0 "run0"
>>
>> So that we can some how tell the login program (systemd in this case)
>> use the line that corresponds to the name of the pam config file
>> (PAMName=3D)
>>
>> Its a tough issue to solve but here is yet another touch issue:
>>
>> systemd refuses to support pam_session_close. pam_selinux relies on this
>> to reset the tty label. The process that deals with pam_session_close
>> (sd-pam) runs unprivileged and that means that when the session closes
>> that the terminal context cannot be reset because the process does not
>> have the permission to reset the label (does not run as root)
>>
>> I brought this issue up here:
>>
>> https://lists.freedesktop.org/archives/systemd-devel/2025-July/051561.ht=
ml
>>
>> kindly read follow the url in that link to read more.
>>
>> These are complicated issues and we were able to look away for over ten
>> years but people are noe starting to use functionality that relies on
>> this pam functionality to work properly (run0 is one feature but another
>> feature is package postinstallation scriptlets entering session of other
>> users to reload their systemd instance (so that it picks up upgraded
>> user service units) for example: systemctl --user --machine
>> kcinimod@.host daemon-reload
>>
>>>
>>>>
>>>> --
>>>> gpg --locate-keys dominick.grift@defensec.nl (wkd)
>>>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>>>> Dominick Grift
>>>> Mastodon: @kcinimod@defensec.nl
>>>>
>>>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
