Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06879
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:19:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA24381
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:18:08 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA24377 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:18:08 GMT
Date: Mon, 19 Aug 2002 08:19:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: psidfiles_init errors
In-Reply-To: <20020819020245.495578922@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190812330.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Russell Coker wrote:

> These are file types that existed in old versions of the policy but which
> don't exist any more.  They still have entries in the ...security database
> because there's no code to clean them up (IMHO they should be removed when
> there are no files of that context on the file system any more).
>
> To avoid the messages add the following to your policy:
> type dummy_file_t alias { dmesg_exec_t xdm_log_t minilogd_exec_t ... };

You can run 'make reset' in your policy directory and then reboot to
eliminate dead entries from the persistent label mapping.  With regard to
automatically removing such entries, it isn't clear that it would be
desirable and it would require maintaining persistent reference counts on
the PSIDs within each filesystem.  As to why it might not be desirable,
consider the following:

1) Transient files (e.g. temporary files) with derived types may be
frequently created and destroyed.  Adding the overhead of re-creating the
PSID/context entry for each such create/destroy cycle would be
undesirable.

2) File deletion doesn't truly destroy the data.  It may be desirable to
be able to check the set of contexts that have _ever_ been used for files
within a filesystem to determine whether the disk needs to be scrubbed.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
