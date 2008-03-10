Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AD0XQ5016377
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 09:00:33 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2AD0VZf027056
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 13:00:32 GMT
Message-ID: <47D530DC.5030606@redhat.com>
Date: Mon, 10 Mar 2008 09:00:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: prelink, cron-job and SELinux compliance
References: <1204970465.4229.10.camel@vogon>
In-Reply-To: <1204970465.4229.10.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> In RHEL/CentOS 5.1 a cron job (/etc/cron.daily/prelink) runs prelink.
> The cron job itself removes a file (/etc/prelink.cache) if necessary and
> updates the database. This does not work with the strict SELinux policy.
> 
> To solve this I patched the prelink application to
> use /var/cache/prelink/prelink.cache instead of /etc/prelink.cache
> This would make it more easier to write SELinux policies. But know my
> actual question is how to modify the cron job to work properly? All cron
> jobs on my system are labeled as bin_t. This would mean that
> system_crond_t needs write/create etc. permissions
> on /var/cache/prelink. Thats not really nice and I would prefer to
> create a domain like cron_script_prelink_t for /etc/cron.daily/prelink
> which gets all the rights to manage /var/cache/prelink.
> 
> What are your ideas to handle cron scripts properly?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Does labeling the directory cron_var_run_t make it work?

Please open a bug report on prelink to put the cache file in this new
directory.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfVMNwACgkQrlYvE4MpobM2fACcCsoJisgY2LL9x19bwqiN7W6F
IQUAoIRGXttjVPA5mkVIenfP2DEGpvGi
=ybll
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
