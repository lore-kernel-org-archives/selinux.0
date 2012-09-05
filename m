Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q85HISip004654
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2012 13:18:31 -0400
Message-ID: <50478962.10303@redhat.com>
Date: Wed, 05 Sep 2012 13:18:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: domain_kill_all_domains in login programs
References: <7C0BFC34-B6A3-4B7A-BD9F-7E3684C79B49@nall.com>
In-Reply-To: <7C0BFC34-B6A3-4B7A-BD9F-7E3684C79B49@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/05/2012 11:45 AM, Joe Nall wrote:
> There is a domain_kill_all_domains in auth_login_pgm_domain that allows
> sshd and other login programs to send sigkill to auditd and other system
> processes that were probably not intended.
> 
> For auditd, I can create domain_kill_all_domains_except and put auditd in
> the exception list. This still leaves processes that use
> auth_login_pgm_domain with the ability to kill many unrelated system
> processes.
> 
> Another approach is to allow login programs to only kill programs with an
> attribute like userdomain.
> 
> Thoughts?
> 
> joe
> 
> grep through RH policy, refpolicy is similar
> 
> find . -name \*.if -exec grep -H auth_login_pgm_domain {} \; 
> ./policy/modules/system/authlogin.if:interface(`auth_login_pgm_domain',` 
> ./policy/modules/services/ssh.if:	auth_login_pgm_domain($1_t)
> 
> find . -name \*.te -exec grep -H auth_login_pgm_domain {} \; 
> ./policy/modules/system/locallogin.te:auth_login_pgm_domain(local_login_t) 
> ./policy/modules/services/xserver.te:auth_login_pgm_domain(xdm_t) 
> ./policy/modules/services/rshd.te:auth_login_pgm_domain(rshd_t) 
> ./policy/modules/services/rlogin.te:auth_login_pgm_domain(rlogind_t) 
> ./policy/modules/services/remotelogin.te:auth_login_pgm_domain(remote_login_t)
>
>  -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 


I guess the problem here is killing all domains that a user domain could
transition to.

It would be better to set this to killall application_domain_types.


application_kill_all()


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBHiWIACgkQrlYvE4MpobNr5gCg3LW8EKJYg7Zsrw9k6D3yG89j
HhYAoOlxMA/tNqPtfw3qiBBIfGgcO3df
=kglk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
