Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SCf7rT009370
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:41:07 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SCeaAN004600
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 12:40:36 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 12:41:05 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BpnFY-0000oJ-6L
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 12:09:36 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bpnug-0000pq-DW
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 13:52:06 +0100
Date: Wed, 28 Jul 2004 13:52:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: modifications to cups policy (maybe debian specific)
Message-ID: <20040728125206.GA3158@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FHS policy violation in cupsys daemon where certs were stored in
/etc/cups has been fixed - in debian version 1.1.20final+rcSomething.

i added the following, also removing the /etc/cups/certs references which
are set to cupsd_rw_etc_t.

	/var/lib/cups/certs		-d	system_u:object_r:cupsd_var_t
	/var/lib/cups/certs/.*	--	system_u:object_r:cupsd_var_t

i also added the following, but i did NOT remove or try to remove the
allow for cupsd_t to write to cupsd_rw_etc_t in case there are other
things going on.

	type cupsd_var_t, file_type, sysadmfile, usercanread;
	file_type_auto_trans(cupsd_t, var_lib_t, cupsd_var_t, file)
	allow cupsd_t cupsd_var_t:dir { setattr rw_dir_perms };

these are the minimum requirements to Get It Working (tm) and it's
probably not a good idea to remove the write-perms to etc_rw_t for a
while until people have thought to have completely upgraded.

unless it is thought to be sensible to add in a dependency of policy
1.15(?) (16?) on cupsys1.1.20finalrcN but of course that means you _must_
install cupsys1.1.20finalrcN so probably not a good idea.

so, how is package updating / changes to be handled?

* detect versions of <package> and install different policy files?

* split out policy files into their own packages, and then have
  these packages depend on selinux-policy-default and also on the
  correct version of the package for which they are relevant?

* leave it, it's not really that crucial: people can just... upgrade
  to latest, and Like It.

* other.

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
