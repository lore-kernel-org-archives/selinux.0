Subject: Re: Documentation, anyone?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   Ivan Gyurdiev <ivg2@cornell.edu>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1136327471.1340.8.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
	 <1136306860.27632.102.camel@moss-spartans.epoch.ncsc.mil>
	 <1136327471.1340.8.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 08:09:14 -0500
Message-Id: <1136380154.27632.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 23:31 +0100, Erich Schubert wrote:
> genhomedircon doesn't fall back on the "old" behaviour as I had it on
> Debian up to now. When libsemanage fails (I guess when the "modular" dir
> doesn't exist), it tries to load /etc/selinux/seusers instead; the old
> genhomedircon I had was apparently parsing the local.users and users
> files directly;
> the current fallback is to load seusers and then parse these files for
> any user found in this seusers file (which also must have three
> components per line).

Ah, sorry - my mistake.

> So I managed to get sufficient fallback now by writing an appropriate
> seusers file; I think I got an example from one of the fedora packages.
> 
> For debian users, I've created two new mailing lists; as noted on
> http://blog.drinsama.de/erich/en/linux/selinux/2006010201-debian-selinux-lists.html
> The first mail on the selinux-users debian list gives details on the
> seusers workaround to get a working genhomedircon again.

What I find curious is that these same issues weren't encountered when
Russell and/or Manoj created and tested updated packages from the newer
upstream tarballs.  Or were they?

> Thanks for your udev feedback; I'm not entirely happy with the
> restorecon approach (e.g. what will happen on a syslog restart, which
> might recreate the /dev/log device with incorrect permissions?) but it
> will do for now.

Runtime creation of the file after initial policy load is handled by the
type_transition rules in the policy (typically encapsulated within
file_type_auto_trans macro in the example policy or within higher level
interfaces in the reference policy).  Hence, we only need to be
concerned with fixing up labels on /dev nodes created prior to the
initial policy load by /sbin/init, which is what the restorecon does.
Also, for anything created by udev itself, that is handled by the
SELinux support in udev (once policy has been loaded).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
