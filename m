Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13997
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 07:45:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA07577
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:45:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA07573
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 11:45:03 GMT
Date: Mon, 22 Jul 2002 07:45:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: tripwire
In-Reply-To: <000501c22e9e$7807c200$0300a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0207220741140.4503-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Jul 2002, Ryan Bergauer wrote:

> reason.) My first thought was to create a domain just for Tripwire, but
> unfortunately, the fact that Tripwire needs access to just about every
> file type on the disk results in a domain that not only would take quite
> some time to create, but would also require a fair degree of
> maintenance.

You can use type attributes to represent entire sets of types.  At
present, the file_type attribute is associated with all types assigned to
files in persistent filesystems.  If you want to grant tripwire read
access to all directories, regular files, and symbolic links with these
file types, you can merely specify:
	allow tripwire_t file_type:dir r_dir_perms;
	allow tripwire_t file_type:{ file lnk_file } r_file_perms;

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
