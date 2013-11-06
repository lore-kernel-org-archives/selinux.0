Message-ID: <527A62DA.7060500@redhat.com>
Date: Wed, 06 Nov 2013 10:40:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com>	<527168B1.4040905@tycho.nsa.gov>	<52716DE6.8040401@redhat.com>	<CAPzO=NyM2K5zb3DemGOxCFVU3dwuFDjo23AgtxS=oSwxrFdDxA@mail.gmail.com>	<5277B25A.7030105@redhat.com> <CAPzO=NwDTKKxx5KsT0X+R57vqPz4aDdrmoRV-f4DiowjQNi_2Q@mail.gmail.com>
In-Reply-To: <CAPzO=NwDTKKxx5KsT0X+R57vqPz4aDdrmoRV-f4DiowjQNi_2Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/06/2013 10:35 AM, Sven Vermeulen wrote:
> On Mon, Nov 4, 2013 at 3:42 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> In Gentoo, we try to only install the SELinux policies related to the 
>>> package that is installed. So if a system does not have a web server,
>>> no httpd policies are loaded.
> [...]
>> And how do  you handle the problem of removing policy when packages get 
>> removed?  What happens to the programs content?
> 
> Good point. We don't handle that - if the package is removed and no other
> package exists that has a dependency on the SELinux policy, then the
> SELinux policy is also removed. Which invalidates the contexts of the
> files. I reckon that users who hit issues with that would relabel the
> files, which usually labels them to the "parent" type (such as var_t for
> things in /var/www then). But I have not received such case(s) for review
> yet.
> 
> Wkr, Sven Vermeulen
> 
These are the types of things that I have to worry about with a Huge installed
base.  Just removing the apache.pp would instantaneously would invalidate all
content in /var/www, but also types in any other policy that was installed
that uses apache_content_template.

# grep apache_content_template *.te
apache.te:apache_content_template(httpd_sys)
apache.te:apache_content_template(httpd_user)
apcupsd.te:	apache_content_template(apcupsd_cgi)
awstats.te:apache_content_template(awstats)
bugzilla.te:apache_content_template(bugzilla)
collectd.te:apache_content_template(collectd)
cvs.te:	apache_content_template(cvs)
dirsrv-admin.te:	apache_content_template(dirsrvadmin)
dspam.te:	apache_content_template(dspam)
git.te:apache_content_template(git)
lightsquid.te:	apache_content_template(lightsquid)
man2html.te:	apache_content_template(man2html)
mediawiki.te:	apache_content_template(mediawiki)
mojomojo.te:	apache_content_template(mojomojo)
munin.te:apache_content_template(munin)
mythtv.te:apache_content_template(mythtv)
nagios.te:	apache_content_template(nagios)
nut.te:	apache_content_template(nutups_cgi)
openshift.te:	apache_content_template(openshift)
prelude.te:	apache_content_template(prewikka)
smokeping.te:	apache_content_template(smokeping_cgi)
squid.te:	apache_content_template(squid)
w3c.te:apache_content_template(w3c_validator)
webalizer.te:	apache_content_template(webalizer)
zoneminder.te:	apache_content_template(zoneminder)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ6YtoACgkQrlYvE4MpobPKGQCgkSWaIi99d8HtcxPV6M0DF/Wb
qwoAmwYmiREd5koNXu1RYI7TJDDnvPsG
=ZeKi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
