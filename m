Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0REuxHZ030120
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2012 09:56:59 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0REuw4Y025863
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2012 14:56:58 GMT
Message-ID: <4F22BB36.2050909@redhat.com>
Date: Fri, 27 Jan 2012 09:56:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dave Quigley <selinux@davequigley.com>
CC: Fedora SELinux Users <selinux@lists.fedoraproject.org>,
        selinux@tycho.nsa.gov
Subject: Re: SLIDE for RHEL6 and Derivatives
References: <4F225403.3030102@davequigley.com>
In-Reply-To: <4F225403.3030102@davequigley.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/27/2012 02:36 AM, Dave Quigley wrote:
> <resent as I sent it from the wrong mailing address>
> 
> I am preparing resources for a talk and I'm trying to build a
> CentOS 6.2 VM with all the SELinux tools installed on it. Most of
> them are easy as they are in the yum repo but I can't seem to find
> any RPMs for SLIDE. The tresys yum repo relies on things that
> aren't in RHEL6 or EPEL6 and only seem to be for RHEL 5 at the
> moment. Has anyone gotten SLIDE installed on RHEL6? Is Tresys
> working on releasing RHEL 6 rpms for SLIDE?
> 
> Dave
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
yum install eclipse-slide

I thought we shipped it with RHEL6.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8iuzIACgkQrlYvE4MpobNLaACgrPQc5HTcDDTQhQWAotLs0lXX
QecAoOtCPMnr5DP+L2vwCBpG0GC2VCO/
=yUuI
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
