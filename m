Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91DN2sJ024906
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 09:23:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91DLDZt028049
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:21:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h91DLDM3028046
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:21:13 GMT
Subject: Re: shlib_t vs lib_t for symbolic links
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310012152.38059.russell@coker.com.au>
References: <200310012152.38059.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065014575.350.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Oct 2003 09:22:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-01 at 07:52, Russell Coker wrote:
> Is there any reason why the symbolic links under /lib and /usr/lib have type 
> shlib_t instead of lib_t?

No, this is just a result of the types.fc entries for shared object
(.so) files not being limited to regular files.

As a side note, for least privilege, it would be good to split up
shlib_t and bind specific programs to executing specific shared objects,
particularly for programs that are privileged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
