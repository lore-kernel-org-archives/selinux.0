Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9NIW1Vj024717
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2013 14:32:01 -0400
Message-ID: <52680E66.9090500@redhat.com>
Date: Wed, 23 Oct 2013 13:59:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mark Montague <mark@catseye.org>, selinux@lists.fedoraproject.org,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: filtering outgoing packets with SELinux and iptables
References: <CADM6DBaR5oqiNNPwneaoWPSkTaqKk8NnK5ZfsrLWgOquyk40Uw@mail.gmail.com>	<5267E47B.5010401@catseye.org> <5267E847.8040309@catseye.org>
In-Reply-To: <5267E847.8040309@catseye.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/23/2013 11:16 AM, Mark Montague wrote:
> On October 23, 2013 11:00 , Mark Montague <mark@catseye.org> wrote:
>> On October 23, 2013 10:28 , Konstantin Ryabitsev <icon@fedoraproject.org>
>> wrote:
>>> I would like to be able to only allow httpd_myapp_script_t to connect
>>> to 192.168.1.1 port 443, but not any other IP address. This is actually
>>> quite common -- an application may need to make a REST call to some
>>> site, but it really has no business talking to any other hosts on the
>>> net.
>> 
>> # Restrict what things running under php-fpm can access.  We're using a #
>> local policy named phpfcgi here because Red Hat's policies include an #
>> alias of httpd_t for phpfpm_t, and if we use that then these rules would 
>> # prevent httpd from communicating with clients. -N PHPFPM -A OUTPUT -m
>> selinux --task-ctx system_u:system_r:phpfcgi_t:s0 -j PHPFPM
> 
> I should add that the local SELinux policy that I'm using for PHP-FPM is a 
> modified version of prometheanfire's work, which he has previous posted to
> this list:
> 
> https://github.com/prometheanfire/selinux-modules.git
> 
> I've renamed the types and added a couple extra allow rules for things that
> my installation of PHP-FPM needs to be able to do, but none of the
> modifications are related to restricting network traffic; the magic for
> that is all in the kernel module and iptables rules.
> 
> 
> -- Mark Montague mark@catseye.org -- selinux mailing list 
> selinux@lists.fedoraproject.org 
> https://admin.fedoraproject.org/mailman/listinfo/selinux
It is better that these types of questions go to the upstream SELinux list
<selinux@tycho.nsa.gov>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJoDmYACgkQrlYvE4MpobOUZwCgp2J9uCiby7hpgdCJ6l+V4IjB
0e0An22kxst8CQsk70mqcftxUyBKmjKi
=/b1Z
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
