Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319F80C02
	for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212717; cv=none; b=qXslxn27sR7b0ACD8ybIkVuJ2wt/VfEVYJkPLCxfLAp2t4quZa8FXFWztudx2ixsm5OIjqCimp/Ro9yfnwjpsV81CRJ2IDw/hEKnIeoTOMXd6c2NzlZbnobc200xGH8xYhV6spLddM7PLZsqlfKykOeuXditpRagYORbKKFTMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212717; c=relaxed/simple;
	bh=DZH8EfU9wVTJny7FegOsQ24SMW5MoXguvM3cx5XKzOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnflUiTCsm6+pocu60DqwGPzIZZ6G/+5xY5qOclOM/Z2zcprNEp4oC+54rDgYSCH9kF31xRaKlP15YtOqsdvgHjng7b//gNKTDlM+h0vcBmUiuBq0ri4DWnHKgkeVNu1sGcL3MvYVb0zvjpCT1mUiJDBVY04Uhsv/ao3jYRKXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=NQ85x46G; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="NQ85x46G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1753212708;
	bh=DZH8EfU9wVTJny7FegOsQ24SMW5MoXguvM3cx5XKzOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NQ85x46GJrmH/foOM/WEUzuL73OJQzD/FER/b4hELFHyFC5QxI6wuUrswSQGu9cKY
	 qwqx1wo0qpz4JZxsB47vAHYbvJGGZv3lYlBrNLEvvPZCtw+l9cUIK0W1JQlLHWviT2
	 T3u8epS2gHS8FwqPnU1Cr6tPuiOARL/5Cd8krxIg=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
	by markus.defensec.nl (Postfix) with ESMTPSA id 3D7B41B396A;
	Tue, 22 Jul 2025 21:31:48 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: systemd.exec(5) PAMName= with libselinux
In-Reply-To: <CAEjxPJ7dcbX+gUQ5UGnM5+zCA2qKZMdxJ0QqBFnbPe12WyKMuw@mail.gmail.com>
	(Stephen Smalley's message of "Tue, 22 Jul 2025 15:06:02 -0400")
References: <87jz42dj60.fsf@defensec.nl>
	<CAEjxPJ7dcbX+gUQ5UGnM5+zCA2qKZMdxJ0QqBFnbPe12WyKMuw@mail.gmail.com>
Date: Tue, 22 Jul 2025 21:31:47 +0200
Message-ID: <87tt34yqcc.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Jul 21, 2025 at 4:53=E2=80=AFAM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> systemd has an identity directive called PAMName=3D which allows you to
>> run a unit with a specified PAM stack. The issue here is that in this
>> case the "session leader" is always systemd.
>>
>> Thus you get into issues with pam_selinux because since systemd is for
>> example always associated with "init_t" you can't really specify log
>> SELinux identity foo_u in with foo_r:foo_t:s0 if this PAM stack is used
>> and log SELinux identity foo_u in with bar_r:bar_t:s0 if that PAM stack
>> is used.
>>
>> This previously was not a big issue since this feature is pretty niche
>> but with the advent of `run0` it became an issue since that relies on
>> PAMName=3D
>>
>> The problem is that pam_selinux is often already used to start the
>> systemd --user instance, for example:
>>
>> /etc/selinux/TYPE/contexts/users/foo_u (/etc/pam.d/systemd-user):
>> system_r:init_t:s0 foo_r:foo_systemd_user_instance_t:s0
>>
>> So you can't add the following because it would conflict
>>
>> /etc/selinux/TYPE/contexts/user/foo_u (/etc/pam.d/run0):
>> system_r:init_t:s0 foo_r:foo_shell_t:s0
>>
>> Ideas? Suggestions?
>
> I probably don't understand your question, but systemd --user
> instances on my Fedora system are running in the user's context, not
> in init_t. If you have two processes with the same context logging in
> as the same user, then there isn't any way to distinguish and it is
> unclear on what basis you would distinguish.

Lets take refpolicy as a reference here.

https://github.com/SELinuxProject/refpolicy/blob/main/config/appconfig-mcs/=
staff_u_default_contexts

line one. Basically that causes pid1 to execute a systemd --user
instance for staff_u users using pam_selinux and user@UID.service which
has the PAMName=3D directive set to systemd-user (this tells systemd to
use the /etc/pam.d/systemd-user pam configuration)

systemd --user instances are very intrusive and one might not want to
run it in the user login shell domain for this reason.

The PAMName=3D directive can use used to run all kinds of things with a
session. the `run0` functionality is one (PAMName=3Drun0 ->
/etc/pam.d/run0) but it could be anything. Simply use PAMName=3D in a
service unit to tell systemd what PAM config to use.

I am not very familiar with pam but one thing that came to my mind which
i am sure is not very robust is to make the pam_selinux syntax a bit
more "smarter" by using something similar to name-based type transition
rules. For example to differentiate between PAMName=3Dsystemd-user and
PAMName=3Drun0:

/etc/selinux/TYPE/contexts/users/staff_u
system_r:init_t:s0 staff_r:user_systemd_t:s0 "systemd-user"
system_r:init_t:s0 staff_r:staff_t:s0 "run0"

So that we can some how tell the login program (systemd in this case)
use the line that corresponds to the name of the pam config file
(PAMName=3D)

Its a tough issue to solve but here is yet another touch issue:

systemd refuses to support pam_session_close. pam_selinux relies on this
to reset the tty label. The process that deals with pam_session_close
(sd-pam) runs unprivileged and that means that when the session closes
that the terminal context cannot be reset because the process does not
have the permission to reset the label (does not run as root)

I brought this issue up here:

https://lists.freedesktop.org/archives/systemd-devel/2025-July/051561.html

kindly read follow the url in that link to read more.

These are complicated issues and we were able to look away for over ten
years but people are noe starting to use functionality that relies on
this pam functionality to work properly (run0 is one feature but another
feature is package postinstallation scriptlets entering session of other
users to reload their systemd instance (so that it picks up upgraded
user service units) for example: systemctl --user --machine
kcinimod@.host daemon-reload

>
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl (wkd)
>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> Dominick Grift
>> Mastodon: @kcinimod@defensec.nl
>>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
