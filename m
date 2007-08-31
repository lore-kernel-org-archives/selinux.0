Message-ID: <46D82916.10106@redhat.com>
Date: Fri, 31 Aug 2007 07:43:34 -0700
From: Ulrich Drepper <drepper@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, Ulrich Drepper <drepper@gmail.com>
Subject: Re: use the OS functionality for reading
References: <46D495A1.20505@redhat.com>	 <1188506154.26572.378.camel@moss-spartans.epoch.ncsc.mil> <1188562726.26572.394.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1188562726.26572.394.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> So...what would you think of keeping PF_USE_MEMORY as is for the policy
> reading side (since it is actually simpler and avoids introducing an
> additional error case), but switching over the policy writing side to
> using the new approach?

It's your call.  As explained in the other mail, I say it's safer to
change it over.  Given who your employer is you should be all for
safety.  It's a proactive step to avoid mistakes.  The current code is
only shorter because of the current interfaces.  If you're willing to
change them things can be cleaned up significantly.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG2CkW2ijCOnn/RHQRAn3RAKClFjZDCgy8f+YmHT1qzgNDUomiMQCgrVPF
b3sAslF2WT5CPwL6y2WFbnI=
=/9JD
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
