Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14516
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 13:29:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA07051
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 17:28:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA07041 for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 17:28:00 GMT
Date: Tue, 16 Jul 2002 13:28:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: cant gain sysadm_r via ssh
In-Reply-To: <Pine.LNX.4.44.0207162339590.448-100000@coffeesaur>
Message-ID: <Pine.GSO.4.33.0207161306530.23767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 16 Jul 2002, Rogelio M. Serrano Jr. wrote:

> There is no way I can gain sysadm_r via ssh at all. If I login as root,
> ssh denies access to sysadm's .ssh directory. It was disallowed in the
> policy config.

You can grant sshd_t read access to sysadm_home_t if you wish, or you
might want to try something along the lines of what Russell described in
his 'home directory mangling' message to the list.  However, direct
ssh logins as root will still be awkward due to the removal of direct
transitions from sshd_t to sysadm_t (which has been discussed already on
the list).

> If I log in as an ordinary user i can su to root but
> newrole fails with "cannot find your entry in the passwd file". When check
> my sid, it was unchanged when I su to root. When I checked the newrole
> source code I find out that user_u cant become sysadm_r at all. Newrole
> uses the user name int the context string. Should I add my user name to
> the policy? Like "user rogelio roles { sysadm_r user_r }" in the users
> file? I tried that and it worked.

Yes.  Any user who needs to be authorized for a role other than user_r
needs to have an entry in policy/users, as explained in the Configuring
the SELinux Policy report.  You may also wish to provide separate entries
for users who are only authorized for user_r if you want to be able to
distinguish audit messages associated with these users.

> Also what should the context be for /dev/tts devices? I am using
> tty_device_t and I get a lot of denial messages when I do  "run_init
> pon provider".

You'll probably need to customize your pppd domain for this purpose, and
define a different type for the device (ttyS?).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
