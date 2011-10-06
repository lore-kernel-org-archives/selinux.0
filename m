Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p96DPPUT016664
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 09:25:25 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p96DPOgL003903
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 13:25:25 GMT
Message-ID: <4E8DAC41.7060108@redhat.com>
Date: Thu, 06 Oct 2011 09:25:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Zeff <joe@zeff.us>
CC: selinux@tycho.nsa.gov
Subject: Re: Puzzling SELinux problem
References: <4E8CF584.2080708@zeff.us>
In-Reply-To: <4E8CF584.2080708@zeff.us>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/2011 08:25 PM, Joe Zeff wrote:
> I'm running Fedora 14, fully updated, with SELinux.  Off and on
> I've had SELinux alerts from various WCG projects, but nothing
> major.  Recently, however, a badly written project started walking
> parts of /proc that it had no business in, causing large spews of
> alerts.  (BOINC runs in permissive mode, so nothing got blocked.)
> I've dealt with that by unselecting the project.  However, at one
> point I accidentally clicked on the alert icon twice.  It came up,
> showing details of the alert then vanished, as a second sealert
> window came up, blank.  That is, no alerts to show.  Since then,
> I'm still getting alerts, but none of them show up in the
> troubleshooter window.  I've tried restarting auditd without effect
> and deleting the database.  Nothing works.  If anybody on this list
> knows what I can do to correct this, please let me know.  You can 
> see what I'm describing at http://www.zeff.us/sealert.png
> 
> If this isn't the right list to put this on, please direct me to
> the right place.
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
Are you seeing a python crash in /var/log/messages or
/var/log/setroubleshoot

?

Can you email me your

/var/lib/setroubleshoot/setroubleshoot_database.xml

Then make sure setroubleshootd is not running.

# killall -9 -Z setroubleshootd_t
# > /var/lib/setroubleshoot/setroubleshoot_database.xml

SEtroubleshoot should start working again.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6NrEAACgkQrlYvE4MpobNngwCgvWqA8rzLWj+xKD9cwzajkeZI
LNQAoI5DJvQBUsFt9sYNvJKEPBIOSAY1
=e+zl
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
