Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5MBZ3bi017765
 for <selinux@tycho.nsa.gov>; Sun, 22 Jun 2014 07:35:03 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so5519374wes.7
 for <selinux@tycho.nsa.gov>; Sun, 22 Jun 2014 04:35:02 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sun, 22 Jun 2014 13:34:15 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Krzysztof Katowicz-Kowalewski <vnd@vndh.net>
Subject: Re: Different authentication with different user roles
Message-ID: <20140622113415.GA21445@siphos.be>
References: <26977C05-E366-4E64-974E-3D3605373FDA@vndh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <26977C05-E366-4E64-974E-3D3605373FDA@vndh.net>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 20, 2014 at 10:16:28PM +0200, Krzysztof Katowicz-Kowalewski wrote:
> I’m watching SELinux mailing list since a few months and it’s my first
> time here to ask a question. I haven’t found the answer for this one
> anywhere, so maybe you guys would help me, or maybe there’s no such thing
> I’ve imagined. But let’s move to the main part, I have two questions are
> related examples…
> 
> 1) It is possible to authenticate user in different way for each of the
> roles he’s in?
> 
> When the user is logged in and had the role of staff_r, he would type
> newrole command and depending on the new role given as an argument he
> would be asked about different passwords in each case. The default
> password for the account would not allow him to be authenticated and gain
> higher privileges in the system.

There's no immediate support for that, but it is technically possible. The
newrole application can be built with PAM support (and that is probably the
case for the majority of Linux distributions that support SELinux), so you
can create a PAM module that authenticates the user based on different
passwords.

> 2) Could the method of authentication and source of authentication request
> be used to determine the role a user should be in by default?
> 
> And in this case I've imagined it in the following way. We can also assume
> that the primary role for the user is staff_r.  a) If the user is logged
> in locally (using tty, not pty as in case of sshd remote access) he could
> be authorized as sysadm_r without further authentication.  b) If the user
> is logged in using ssh from trusted source (trusted IP address, trusted
> subnetwork) then he could be authorized as sysadm_r without further
> authentication.  c) If the user is logged in using ssh but he had used his
> private key rather than a passphrase for authentication then he could be
> authorized as sysadm_r without further authentication.
> 
> Once more, these are just examples.

Partially, yes.

You can have users be "logged in" in a different context based on the
security context of the process through which the user is logging in. This
is defined in the default_contexts file (or the SELinux user specific files
in the users/ subdirectory) which is located inside
/etc/selinux/mcs/contexts (substitute "mcs" with the name of your policy
store).

For instance, if you don't want logins through sshd_t to be in the sysadm_r
role immediately, remove it from the list:

system_r:sshd_t		user_r:user_t staff_r:staff_t

Users that login through SSH will have their "allowed" role list checked,
and the first role in their allowed role list that is also part of the
default_contexts listing will be used. So an administrator that is mapped to
the staff_u user (and thus has "staff_r sysadm_r" as allowed roles) would be
logged in as staff_r:staff_t and not sysadm_r:sysadm_t.

Direct logins are handled through the local_login_t, which can then support
sysadm_r direct logins if you want:

system_r:local_login_t	user_r:user_t sysadm_r:sysadm_t staff_r:staff_t

This is also where the "partially" comes from. There is no method for
changing this based on the authentication used (such as password-based or
SSH key based). You can work around it if you like, for instance by having
SSH listen on two ports (or two addresses) with a different context (sshd_t
versus sshd_keyauth_t) but that is a bit hackish and requires you to
duplicate the SSH domains.

It might be a nice idea to support sensitivity based decisions, but afaik
that isn't the case right now.

Wkr,
	Sven Vermeulen
