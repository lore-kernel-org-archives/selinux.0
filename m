Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46IDU98005148
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 14:13:30 -0400
Message-ID: <5187F2C7.3070602@redhat.com>
Date: Mon, 06 May 2013 14:13:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>
CC: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: SELinux errors with pam_faillock
References: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com>
In-Reply-To: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/25/2013 05:35 PM, Andy Ruch wrote:
> Hello,
> 
> I'm receiving some SELinux errors related to the pam_faillock module. I'm 
> running RHEL 6.3 with a custom policy based on the reference policy.
> 
> When a user enters an incorrect password, the pam faillock module will
> track it with a file in /var/run/faillock/<user>. This is being applied
> whenever the user enters their password (i.e. console login, newrole,
> sudo). Everything works appropriately for the console login. For newrole
> and sudo, I'm getting errors when the /var/run/faillock/<user> file is
> trying to be created. Basically, newrole_t and <role>_sudo_t don't have
> permission to create files in a faillog_t dir.
> 
> I found a rule in 'selinuxutil.te' allowing newrole_t to read/write to
> faillog: "auth_rw_faillog(newrole_t)". However, this rule only allows
> writing if the file already exists. It doesn't address if the faillock file
> needs to be created.
> 
> I'm able to address the issues with the following rules:
> 
> # Note that these rules would be applied in the sudo interface to support
> all sudo types create_files_pattern( sysadm_sudo_t, faillog_t, faillog_t ) 
> setattr_files_pattern( sysadm_sudo_t, faillog_t, faillog_t ) allow
> sysadm_sudo_t_t self:capability:chown;
> 
> create_files_pattern( newrole_t, faillog_t, faillog_t ) 
> setattr_files_pattern( newrole_t, faillog_t, faillog_t ) allow newrole_t
> self:capability:chown;
> 
> Is this the correct solution? Or should a transition be happening when
> faillock executes?
> 
> Thanks, Andy Ruch
We don't have these rules in policy either.

I would add

auth_manage_faillog(sysadm_sudo_t)
auth_manage_faillog(newrole_t)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGH8scACgkQrlYvE4MpobMPPQCfQWcTrvlU8zeaW+Zzvx2wG2rC
CtkAn3kapX0n0p6bwJR/7G57JSeG7Yh5
=6NjD
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
