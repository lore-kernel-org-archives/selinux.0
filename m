Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA22535
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 15:07:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07200
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:05:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA07196
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 20:05:24 GMT
Date: Tue, 29 Oct 2002 15:07:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: mysql policy
In-Reply-To: <20021029204914.B16084@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210291500350.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Oct 2002, Tom wrote:

> If I remember correctly, it's tee'ing any errors during startup to an
> error log file that is located there. I'm working on this anyway, so if
> you don't feel happy with it, just wait until I have a more refined
> policy to offer. For some reason, though, adding this rule makes it
> work on my system.

mysqld_db_t is assigned to /var/lib/mysql.  mysqld_log_t is assigned to
/var/log/mysql.*.   So I'm not clear as to why a log file would be
created in /var/lib/mysql.  If it is (re)creating a file in
/var/lib/mysql, then it should require search, write, and add_name
permission to mysqld_db_t:dir as well as create permission to
mysqld_db_t:file.  If it is merely appending to an existing file, it
should only need search permission to the directory and append permission
to the file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
