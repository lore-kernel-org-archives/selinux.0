Message-ID: <424CEE3E.40302@gentoo.org>
Date: Fri, 01 Apr 2005 09:46:22 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about customizing apache policy.
References: <424C1B73.6020508@redhat.com>
In-Reply-To: <424C1B73.6020508@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB504B79058A083FF8A03A7D2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB504B79058A083FF8A03A7D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Daniel J Walsh wrote:
> There was a question yesterday in one of the fedora list, from a person
> who would like to run a special httpd script that would manage his
> passwd file, now whether or not this is a good idea, it caused me to try
> an experiment.
> Currently we have a  macro apache_domain.  I thought it would be cool if
> I could start writing policy for this passwd app by adding a file to
> domains/misc/apachepasswd.te.  Then having one line
> apache_domain(passwd)
> 
> Which in theory would create httpd_passwd_script_exec_t,
> httpd_passwd_script_t, httpd_passwd_script_rw_t.  I could then go ahead
> and label my cgi httpd_passwd_script_exec_t and start adding the
> additional allow rules to allow this to happen.  Needless to say, we
> have added a lot of cruft to the apache_domain() macro.  So I did some
> cleanup of apache.te and apache_macro.te, see attach.
> Could people review these to make sure there is no mistakes.
> But this exercise also brought up the idea that this would be an
> excellent example of how we would want to use loadable modules. I think
> that this might be a fairly common problem.  People want to run a
> specialized apache cgi script that slightly extends httpd_sys_script_t.
> 
> It would be cool if they could do this without having to have policy
> installed, but a simple boiler plate for adding a new type of httpd
> script type.
> 
> Ideas?
> 
> Dan

This is a great idea that I've been using for some time now :)
I needed it for all kind of cgi-type applications and the policy can be as clean as apache_domain(awstats) and a few webapp-related rules.

bye,
peter


--------------enigB504B79058A083FF8A03A7D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCTO5PGSBEIeh4AEYRAlJCAJdQoxdE9MByQNLclE2GW9brYiPFAKCNx1ve
JECYhnV1i1F7MDY9FPfdRg==
=tOT6
-----END PGP SIGNATURE-----

--------------enigB504B79058A083FF8A03A7D2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
