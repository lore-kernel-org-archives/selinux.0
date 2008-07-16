Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GIxwHt012561
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 14:59:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GIxuhc002376
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:59:56 GMT
Message-ID: <487E451C.5000603@redhat.com>
Date: Wed, 16 Jul 2008 14:59:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>,
        selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
References: <20080716165634.GA8072@hardeman.nu>	 <487E2C1F.4010308@redhat.com>  <20080716174410.GA9226@hardeman.nu> <1216232357.21191.76.camel@gorn>
In-Reply-To: <1216232357.21191.76.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Wed, 2008-07-16 at 19:44 +0200, David Härdeman wrote:
>> On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
>>> David Härdeman wrote:
>>>> While working on SELinux-enabling a Debian system, I often Google for
>>>> avc messages that show up in dmesg and 90% of the time it seems that the
>>>> problem has already been solved in Fedora's version of the refpolicy but
>>>> not in the upstream version.
>> ...
>>>> The question is how to treat the patches after that? Should I post them
>>>> as I go through them (a couple per day for a couple of weeks?) and hope
>>>> that someone at Tresys will apply them?
> [...]
>> I guess what I'm really wondering is if I can help you in some way? 
> 
> The main points which would improve upstreaming efficiency from Dan's
> set are:
> 
> 1. description / justification
> 
> What this means tends to vary depending on what access is added by a
> patch.  A patch that allows reading of usr_t files probably doesn't need
> a big description while a patch that allows reading shadow_t does.
> "myapp breaks without this rule" isn't a very good explanation,
> especially if the access is questionable.  The app may be incorrectly
> requesting extra access or it might be a bug in the app.
> 
> 2. style
> 
> The changes need to meet the refpolicy style guidelines.  Dan is pretty
> good about this, but with the volume, things still get by.
> 
> 3. patch composition
> 
> A patch should be a changeset.  So if a rule is added to a bunch of
> domains for the same reason, then that should be in a single patch by
> itself.  If you add an interface so some modules can call it, that
> should be a single patch that includes the new interface and the
> additions to the callers.  This enables me to review the change as a
> whole, and not have distractions from unrelated changes.  A set of small
> fixes to a single module can be a single patch.
> 
And the problem I have with all of these is volume of change.  When a
new release goes out and a whole bunch of new users start using SELinux
the volume of bugzillas generated is use.  My first responsibility is to
get SELinux fixed for these users.  Marking up the policy with lots of
bugzilla's or justifications is both time consuming and I believe just
dirties the policy.  In the more bizarre categories that should be
required.  My goal is to get the non-bizarre changes upstreamed so we
could concentrate on the bizarre ones and either justify or remove them.

Changes like adding

fs_list_inotify should just get into the upstream.

grep fs_list_inotify  policy-20080710.patch
+fs_list_inotifyfs(certwatch_t)
+fs_list_inotifyfs(logrotate_t)
+fs_list_inotifyfs(logwatch_t)
+fs_list_inotifyfs(tmpreaper_t)
+	fs_list_inotifyfs($1_gconfd_t)
+fs_list_inotifyfs(gpg_t)
+fs_list_inotifyfs(gpg_helper_t)
 	fs_list_inotifyfs($1_mozilla_t)
+fs_list_inotifyfs(nsplugin_t)
+fs_list_inotifyfs(nsplugin_config_t)
+fs_list_inotifyfs(locate_t)
+fs_list_inotifyfs(httpd_t)
+	fs_list_inotifyfs($1_dbusd_t)
+fs_list_inotifyfs(system_dbusd_t)
 fs_list_inotifyfs(dovecot_t)
+fs_list_inotifyfs(fail2ban_t)
+fs_list_inotifyfs(gamin_t)
+fs_list_inotifyfs(gnomeclock_t)
+fs_list_inotifyfs(system_mail_t)
+fs_list_inotifyfs(NetworkManager_t)
+fs_list_inotifyfs(nscd_t)
+fs_list_inotifyfs(polkit_t)
+fs_list_inotifyfs(prelude_lml_t)
+fs_list_inotifyfs(nmbd_t)
+fs_list_inotifyfs(swat_t)
+	fs_list_inotifyfs($1_xserver_t)
+fs_search_inotifyfs(xdm_t)
+fs_list_inotifyfs(init_t)
+fs_list_inotifyfs(iptables_t)
+	fs_list_inotifyfs($1)
+fs_list_inotifyfs(load_policy_t)
- -	fs_list_inotifyfs($1_t)
+	fs_list_inotifyfs($1_usertype)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh+RRwACgkQrlYvE4MpobM+vgCeJSBxEJ6/uErGs+dsn/JGSzAk
DBUAoIVP37Ejpr1b21QMfEfdqLrA+QKe
=sHu2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
