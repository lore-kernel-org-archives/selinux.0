Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0HN18Ii016674
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 18:01:08 -0500 (EST)
Received: from oddjob.atc-nycorp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0HN15A9007439
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 23:01:08 GMT
Received: from server20.inside.oracorp.com (server20 [192.168.1.3])
	by oddjob.atc-nycorp.com (8.12.11/8.12.11) with ESMTP id j0HMvVRS003121
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 17:57:33 -0500
Message-ID: <60D45469A1AAD311A04C009027B6BF6804FCF003@server20.inside.oracorp.com>
From: Steve Brueckner <steve@atc-nycorp.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Role transition error
Date: Mon, 17 Jan 2005 18:01:02 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to add a new role and test it by adding a user with access to
that role.  I can su to the new user, but then when I try to newrole I get
"... is not a valid context".  Here are my steps so far; I'm using Fedora
Core 3 and starting from the default strict policy:

#useradd engineer

Added the following to .../strict/src/policy/users
user engineer roles { user_r developer_r };

Added the following to .../strict/src/policy/domains/user.te
full_user_role(developer)
allow system_r developer_r
allow sysadm_r developer_r
allow user_r developer_r
allow staff_r developer_r

Added the following into in_user_role macro in
.../strict/src/policy/macros/user_macros.te
role developer_r types $1;

Added the following to .../strict/src/policy/appconfig/default_type
developer_r:user_t

#make load

steve$ id -Z
user_u:user_r:user_t
steve$ su engineer
engineer$ id -Z
engineer:user_r:user_t
engineer$ newrole -r developer_r
engineer:developer_r:user_t is not a valid context

Any ideas what I've neglected in setting this up?  Thanks!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
