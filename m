Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCUENs021157
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:30:14 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCOnpk000688
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:24:49 GMT
Message-Id: <200509271224.j8RCOaYs025773@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>
Cc: <dwalsh@redhat.com>, <jbrindle@tresys.com>
Subject: RE: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
Date: Tue, 27 Sep 2005 08:24:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <43348FB4.4000108@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Friday, September 23, 2005 7:29 PM
> To: selinux@tycho.nsa.gov
> Cc: dwalsh@redhat.com; jbrindle@tresys.com
> Subject: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
> 
> The attached patch does the following:
> 
> - Stub out semanage_handle structure and create/destroy.
> Put those in include/semanage/handle.h, src/handle.h, src/handle.c.
> Relay the handle down to the dbase_* level, but not any lower (for now).
> Joshua, please add your patch on top of that.
> 

The patches that I sent out yesterday were not on top of these patches. I
would be happy to either rebase your patches or give you a hand rebasing
them. It looks, however, that you can probably just drop handle.[c,h] in
favor of semanage.[c,h] and things should work. Let me know.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> - Set up initialization of dbase_config_t (most of it anyway - filename
> is still
> missing). On handle creation, the handle code queries XXX_file.c, which
> invokes a dbase_config_t initialization function with the appropriate
> parameters. On handle destruction, do the same thing for releasing
> resources. The database configuration(s) are now kept in the handle.
> 
> - Split the record table into two - base table, and file-related table.
> This will be necessary for future changes that try to support policydb
> as a database.
> 
> - Move the generic chunk of the record table into users.c/ports.c
> where it belongs.
> 
> - Replaces the doubly-linked list in dbase_* with a singly-linked list.
> 
> - Fixes incorrect sepol function name:
> sepol_user_get_num_roles -> sepol_user_get_numroles
> 
> - Adds stddef.h to user_record semanage headers.
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
