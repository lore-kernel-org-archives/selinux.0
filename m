Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0RG3s2d002613
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2012 11:03:54 -0500
Received: from countercultured.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id q0RG3r4Y015238
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2012 16:03:53 GMT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Jan 2012 11:03:52 -0500
From: David Quigley <selinux@davequigley.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Fedora SELinux Users <selinux@lists.fedoraproject.org>,
        <selinux@tycho.nsa.gov>
Subject: Re: SLIDE for RHEL6 and Derivatives
In-Reply-To: <4F22BB36.2050909@redhat.com>
References: <4F225403.3030102@davequigley.com> <4F22BB36.2050909@redhat.com>
Message-ID: <44f5930a85837898416abd3fe8a152ff@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/27/2012 09:56, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/27/2012 02:36 AM, Dave Quigley wrote:
>> <resent as I sent it from the wrong mailing address>
>>
>> I am preparing resources for a talk and I'm trying to build a
>> CentOS 6.2 VM with all the SELinux tools installed on it. Most of
>> them are easy as they are in the yum repo but I can't seem to find
>> any RPMs for SLIDE. The tresys yum repo relies on things that
>> aren't in RHEL6 or EPEL6 and only seem to be for RHEL 5 at the
>> moment. Has anyone gotten SLIDE installed on RHEL6? Is Tresys
>> working on releasing RHEL 6 rpms for SLIDE?
>>
>> Dave
>>
>> -- This message was distributed to subscribers of the selinux
>> mailing list. If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
>> without quotes as the message.
>>
>>
> yum install eclipse-slide
>
> I thought we shipped it with RHEL6.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk8iuzIACgkQrlYvE4MpobNLaACgrPQc5HTcDDTQhQWAotLs0lXX
> QecAoOtCPMnr5DP+L2vwCBpG0GC2VCO/
> =yUuI
> -----END PGP SIGNATURE-----

I tried that with Centos 6.2 and it didn't work. Doing a yum search for 
eclipse-slide doesn't yield any results. If RHEL 6 did ship it then 
Centos didn't repackage it for some odd reason. I can look for the srpms 
from Red Hat for RHEL 6 to see if there is a package in there for it.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
