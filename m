Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7II34nP019018
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 14:03:04 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7II2omr027942
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 18:02:51 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Subject: cp: --preserve={context,xattr,acl}
Date: Fri, 18 Aug 2006 20:03:02 +0200
Message-ID: <87veop2a7d.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, upstream cp can selectively preserve a few different attributes.
>From the documentation:

  `-p'
  `--preserve[=ATTRIBUTE_LIST]'
       Preserve the specified attributes of the original files.  If
       specified, the ATTRIBUTE_LIST must be a comma-separated list of
       one or more of the following strings:

      `mode' ...
      `ownership'
      `timestamps'
      `links'
      `all'

       Using `--preserve' with no ATTRIBUTE_LIST is equivalent to
       `--preserve=mode,ownership,timestamps'.

       In the absence of this option, each destination file is created
       with the permissions of the corresponding source file, minus the
       bits set in the umask and minus the set-user-ID and set-group-ID
       bits.  *Note File permissions::.

The SELinux patches add "context" to the list.
and upstream treats ACLs like "mode".

However, with XATTR support, I may well add two more: "xattr" and "acl".

But then there'd be overlap between --preserve=xattr and --preserve=context,
Since I presume the latter subsumes the former.  Right?

So if both were specified on a selinux-enabled system,
would there be any point in doing anything XATTR-specific?

What do you think?

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
