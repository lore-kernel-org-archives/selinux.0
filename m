Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IEYuLA004057
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 10:34:56 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IEYtlK017505
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 14:34:55 GMT
Message-ID: <47DFD303.4080004@redhat.com>
Date: Tue, 18 Mar 2008 10:34:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?P=E4r_Aronsson?= <par.aronsson@telia.com>
CC: selinux@tycho.nsa.gov, fedora-directory-users@redhat.com
Subject: Re: SELinux policy for Fedora Directory Server 1.1.0
References: <200803111734.10289.par.aronsson@telia.com>
In-Reply-To: <200803111734.10289.par.aronsson@telia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pär Aronsson wrote:
> Hello,
> 
> Attached is a SELinux policy for the Fedora Directory Server 1.1.0.
> It is composed of three parts.
> * dirsrv - directory server and setup programs
> * dirsrv-admin - administration server and setup programs
> * fedora-idm-console - java based console for administration
> 
> The policies were developed on a CentOS 5.1 with the following packages:
> fedora-ds-base-1.1.0-3.fc6
> fedora-ds-admin-1.1.1-1.fc6
> fedora-ds-console-1.1.0-5.fc6
> selinux-policy-2.4.6-106.el5_1.3
> kernel-2.6.18-53.1.4.el5
> 
> I've succesfully tested the policies in targeted and strict mode.
> 
> The dirsrv-admin policy requires that the apache policy module is loaded.
> Also run:
> setsebool -P httpd_enable_cgi on
> 
> Comment out the following in /usr/sbin/start-ds-admin (line 63-65):
> if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> 	SELINUX_CMD="runcon -t unconfined_t --"
> fi
> 
> I had trouble with the replication plugin so I haven't been able to do any 
> testing with replication.
> 
> Any comments are welcome.
> 
> // Pär Aronsson
> 
Just started looking at this policy
dirsrv.te looks pretty good,  I have never setup a directory server, so
I am guessing on some of this stuff.

You want 	logging_search_logs($1) in
dirsrv_read_setuplog

The fedora-idm-console stuff makes no sense.  Looks like you are trying
to fix bugs in javaplugin policy.

Not sure if you want/need  dirserv-admin policy?  If this is just stuff
to be run in cgi, just extend it.

ALso not sure you need dirsrv_setup_t  Why not leave in admin context?



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkff0wIACgkQrlYvE4MpobPytQCbBlFzyMaq83N79iPxQTbk/G5k
/SkAn2TL7xy7VwL1oDaj62isjxNnqd9O
=jUQi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
