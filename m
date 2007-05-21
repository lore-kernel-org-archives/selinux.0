Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LKR7p1020907
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 16:27:07 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LKR69R025225
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 20:27:06 GMT
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
From: James Antill <jantill@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Klaus Weidner <klaus@atsec.com>
In-Reply-To: <200705211543.10171.paul.moore@hp.com>
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com>
	 <4651EFCC.1040500@redhat.com>  <200705211543.10171.paul.moore@hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PlPZg2f6i1JD5D78lOt1"
Date: Mon, 21 May 2007 16:27:02 -0400
Message-Id: <1179779222.23650.24.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PlPZg2f6i1JD5D78lOt1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-21 at 15:43 -0400, Paul Moore wrote:
> If I recall correctly, there was some chatter about creating a more gener=
ic=20
> translation facility so that we could translate the entire SELinux contex=
t,=20
> versus the MLS range which we do now, into a more human readable label.  =
I=20
> believe doing something like this would help achieve some of the goals th=
at=20
> Klaus hinted at with the "make it more suitable for everyday use by=20
> non-experts".  It would also help to reinforce the notion that the contex=
t is=20
> a blob and in general shouldn't be parsed by applications that don't know=
=20
> what they are doing.

 Right, this is one of the really horrible things in the nautilus code
to change the context. I've included the full function at the end of
this email, so you can all bask in it's unworthyness (and it's probably
already out of date).
 If we can fix this in a good way just for targeted/nautilus, that would
be a significant win ... the other obvious use would be integration into
sealert messages.

# define HACK_TYPE(x, y)                               \
       else if (!strcmp (nice_type, x)) nice_type =3D y

/* hack to convert a selinux_context type into a readable string for the
   user */
static const char *
selinux__hack_conv_type (const char *type)
{ /* FIXME: hack attack, but nowhere else to put it. Because mathpathcon
   * here now probably want a bunch of other types? */
        const char *nice_type;

       nice_type =3D type;
      =20
       if (0) { }
      =20
       HACK_TYPE("cupsd_etc_t", _("CUPS printer configuration"));
       HACK_TYPE("cupsd_rw_etc_t", _("CUPS printer configuration (rw)"));
       HACK_TYPE("cupsd_tmp_t", _("CUPS temporary data"));
       HACK_TYPE("dhcp_etc_t", _("DHCP configuration"));
       HACK_TYPE("dictd_etc_t", _("Dictd configuration"));
       HACK_TYPE("dnssec_t", _("DNS secret"));
       HACK_TYPE("etc_t", _("System configuration"));
       HACK_TYPE("etc_aliases_t", _("Email aliases configuration"));
       HACK_TYPE("etc_runtime_t", _("System configuration (rw)"));
       HACK_TYPE("cvs_data_t", _("Read and write from CVS daemon"));
       HACK_TYPE("httpd_config_t", _("Apache-httpd configuration"));
       HACK_TYPE("httpd_php_tmp_t",
                 _("Apache-httpd PHP module temporary data"));
       HACK_TYPE("httpd_sys_content_t",
                 _("Read from all httpd scripts and the daemon"));
       HACK_TYPE("httpd_sys_htaccess_t",
                 _("Apache-httpd .htaccess configuration"));
       HACK_TYPE("httpd_sys_script_exec_t",
                 _("CGI programs with default access"));
       HACK_TYPE("httpd_sys_script_ra_t",
                 _("CGI programs can read and append"));
       HACK_TYPE("httpd_sys_script_ro_t",
                 _("CGI programs can read"));
       HACK_TYPE("httpd_sys_script_rw_t",
                 _("CGI programs can read and write"));
       HACK_TYPE("httpd_unconfined_script_exec_t",
                 _("CGI programs without any SELinux protection"));
       HACK_TYPE("httpd_tmp_t", _("Apache-httpd temporary data"));
       HACK_TYPE("ice_tmp_t", _("ICE temporary data"));
       HACK_TYPE("locale_t", _("Locale data"));
       HACK_TYPE("mysql_tmp_t", _("MySQL temporary data"));
       HACK_TYPE("named_conf_t", _("Nameserver configuration"));
       HACK_TYPE("net_conf_t", _("Network configuration"));
       HACK_TYPE("postgresql_tmp_t", _("Postgresql temporary data"));
       HACK_TYPE("public_content_rw_t",
                 _("Read and write from CIFS/ftp/http/nfs/rsync"));
       HACK_TYPE("public_content_t", _("Read from CIFS/ftp/http/nfs/rsync")=
);
       HACK_TYPE("samba_etc_t", _("Samba configuration"));
       HACK_TYPE("samba_share_t", _("Shared via CIFS (samba)"));
       HACK_TYPE("staff_home_t", _("Staff user data"));
       HACK_TYPE("staff_home_dir_t", _("Staff user home directory"));
       HACK_TYPE("swapfile_t", _("System swapfile"));
       HACK_TYPE("sysadm_home_t", _("Sysadmin user data"));
       HACK_TYPE("sysadm_home_dir_t", _("Sysadmin user home directory"));
       HACK_TYPE("system_cron_spool_t", _("Cron data"));
       HACK_TYPE("tmp_t", _("Temporary data"));
       HACK_TYPE("user_tmp_t", _("User temporary data"));
       HACK_TYPE("user_home_t", _("User data"));
       HACK_TYPE("user_home_dir_t", _("User home directory"));
       HACK_TYPE("var_log_t", _("Logfile"));
       HACK_TYPE("xen_image_t", _("Xen image"));
      =20
       return nice_type;
}
#undef HACK_TYPE


--=20
James Antill <jantill@redhat.com>

--=-PlPZg2f6i1JD5D78lOt1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGUgCW11eXTEMrxtQRAjpoAJ9q/nWsxyRiDTyZbUU7UdjazE1qOACgpOQa
8Vnwq2WCmeAWRMQ+KVcvm0s=
=BdEp
-----END PGP SIGNATURE-----

--=-PlPZg2f6i1JD5D78lOt1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
