Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA22536
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 08:43:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA22580
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:41:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA22576 for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:41:39 GMT
Date: Thu, 29 Aug 2002 08:42:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: more patches, another small patch
In-Reply-To: <20020827181256.37200311@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208290838190.2189-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These patches have been merged and are available in the sourceforge CVS
tree.  I replaced the allow rule granting mrtg_t access to
sysadm_home_dir_t with a dontaudit rule.  I omitted two changes from
postgresql.te: granting the domain setattr permission to etc_t:file and
granting the domain write and lock permission to initrc_var_run_t:file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
