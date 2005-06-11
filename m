Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5B0jGgA024280
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:45:16 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5B0bZfM018240
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 00:37:35 GMT
Received: from [192.168.1.102] (c-24-61-202-223.hsd1.ma.comcast.net [24.61.202.223])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j5B0bbdf011708
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:37:37 -0400 (EDT)
Subject: Nested Booleans
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 10 Jun 2005 20:38:14 -0400
Message-Id: <1118450294.31022.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why is it not possible to nest booleans - this is always causing
problems for me. For example, right now I can't compile my policy, 
because it contains code like this:

if (mozilla_writehome) {
write_untrusted($1_mozilla_t, $1)
file_type_auto_trans($1_mozilla_t, { $1_home_t $1_home_dir_t },
$1_untrusted_content_t)
}
file_type_auto_trans($1_mozilla_t, { tmp_t $1_tmp_t },
$1_untrusted_content_t)

and then:

################################################
# write_untrusted(source, role_prefix)
#
define(`write_untrusted', `
write_network_home($1)
create_dir_file($1, $2_untrusted_content_t)
') dnl write_untrusted

and:

################################################
# write_network_home(source)
#
# Allows source domain to create directories and
# files on network file system

define(`write_network_home', `
allow $1 home_root_t:dir search;

if (use_nfs_home_dirs) {
create_dir_file($1, nfs_t)
}
if (use_samba_home_dirs) {
create_dir_file($1, cifs_t)
}
allow $1 autofs_t:dir { search getattr };
') dnl write_network_home


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
