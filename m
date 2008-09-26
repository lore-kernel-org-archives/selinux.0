Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8Q3UW4n025332
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 23:30:32 -0400
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8Q3UVWa014766
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 03:30:32 GMT
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: "Working with SELinux" sections
In-Reply-To: Your message of "Tue, 23 Sep 2008 16:16:00 +1000."
             <48D889A0.1010604@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <48D889A0.1010604@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1222399818_7097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 25 Sep 2008 23:30:18 -0400
Message-ID: <9405.1222399818@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1222399818_7097P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Sep 2008 16:16:00 +1000, Murray McAllister said:

> * selinux-policy-[policy]: provides SELinux policies. For targeted 
> policy, install selinux-policy-targeted. For MLS, install 
> selinux-policy-mls. The strict policy was merged in Fedora 9, allowing 
> confined and unconfined users to co-exist on the same system.

Strict was merged with what, exactly? (This threw me for a loop when
strict evaporated out of rawhide, before I figured out that MLS was what
I needed as the replacement - for most of my boxes, I don't actually *need*
the MLS/MCS stuff, I just need to not have an 'unconfined' on the box.  For
a *few* others, the MCS stuff is handy.  And actual MLS is barely on the
radar here...)

> denied if running in enforcing mode. When using disabled mode, SELinux 
> is disabled (the SELinux module is not registered with the Linux 
> kernel), and only DAC rules are used.

Might want to note that operating in disabled mode probably means you want
to do a relabel if you re-enable SELinux, because any files created/modified
while running disabled are probably unlabeled.

> SELINUXTYPE=targeted: The SELINUXTYPE option sets the SELinux policy to 
> use. Targeted policy is the default policy used. Only change this option 
> if you want to use the MLS policy. To use the MLS policy, install the 
> selinux-policy-mls package; configure SELINUXTYPE=mls in 
> /etc/selinux/config; and reboot your system.

Someplace, you want to discuss why one might want to use MLS (whether as the
replacement for the old 'strict' policy where everything ran confined as
opposed to 'targeted', or if you have an actual use case for the MLS/MCS
features).

> 4. In permissive mode, SELinux policy is not enforced, but denials are 
> still logged for actions that would have been denied if running in 
> enforcing mode. Before changing to enforcing mode, as the Linux root 
> user, run the grep "SELinux is preventing" /var/log/messages command to 

Erm. What *exactly* produces that entry in /var/log/messages?  All my
AVC stuff ends up in auditd.  Or is this just because the setroubleshoot
RPMs aren't *quite* as mandatory as you noted above, and I don't see those
messages because I don't have them installed *and enabled*? (Gotta watch
out for those pesky 'chkconfig off' ;)

> # should users run something like "> /var/log/messages" before rebooting?

This is a good way to lose potentially important log entries.  Also,
note that if the box is running syslog-ng, the file might be called
/var/log/messages.YYMMDD or similar (very handy, that - no need to worry
about cronjobs rolling the files).

> 5. If there were no denial messages in /var/log/messages, configure 
> SELINUX=enforcing in /etc/selinux/config:

You need to discuss the very possible case that there *were* denial messages.
How do you fix them?  audit2allow is *one* option, as is correctly labelling
files (if you have them in a non-standard place, you probably want to be doing
an 'semanage fcontext -a').  But blindly doing either of those is a good way to
hose yourself gloriously.

> 7. As the Linux root user, run the semanage login -l command to confirm 
> that the mapping between SELinux and Linux users is correct. The output 
> should be as follows:

Also handy at this point - explain how to add additional SELinux userids
and map login IDs to them (you can't really do anything with the MLS/MCS
support if everybody is either user_u or staff_u).

--==_Exmh_1222399818_7097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFI3FdKcC3lWbTT17ARAmXNAKCLqL3WNzk/4jQ78DUKAQ7b3gIWRQCcDJZ5
iB6k7Qmdj1qbhwAKGjC61lc=
=QM25
-----END PGP SIGNATURE-----

--==_Exmh_1222399818_7097P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
