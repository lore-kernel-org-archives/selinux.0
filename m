Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9VDfBKY027198
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2008 09:41:11 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9VDdWZu029167
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2008 13:39:37 GMT
Message-ID: <490B0ACF.3080502@redhat.com>
Date: Fri, 31 Oct 2008 09:40:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: Re: user guide: troubleshooting chapter
References: <4907D37F.3090404@redhat.com>
In-Reply-To: <4907D37F.3090404@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Hi,
> 
> I am having trouble organizing a troubleshooting section. My current ideas:
> 
> Top Three Causes of Problems: <http://danwalsh.livejournal.com/22347.html>
> 
> Searching for and Viewing SELinux Denials
> 
> * which log files are used.
> * ausearch, sealert, setroubleshoot-gui
> 
> Analyzing SELinux Denials
> 
> * Description of each field: comm, path, scontext, tcontext, etc.
> * <http://fedoraproject.org/wiki/SELinux/Troubleshooting/AVCDecisions>
> "Troubleshooting/AVCDecisions"
> 
> Why was Access Denied?
> 
> * auditwhy.
> * DAC rules.
> 
> Fixing Problems
> 
> * fedora-selinux-list, Red Hat Bugzilla, audit2allow, chcon, semanage
> fcontext, setsebool.
> * Permissive Domains: <http://danwalsh.livejournal.com/24537.html>
> * Booleans for Services (HTTP, Samba, FTP, MySQL, rsync).
> 
> Thanks for any ideas.
> 
> Regards.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Looks good.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkLCs8ACgkQrlYvE4MpobNTbACgq+MmD27rqT5DjcIC2htNUxSX
UqAAniiRX0w3cAcoQcmdGkgCzzHNw5S/
=uR6c
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
