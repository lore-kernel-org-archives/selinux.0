Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, Stephen Smalley <sds@tislabs.com>,
        SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Inode persistence generally - was: Re: persistent labelling on afs, jfs, xfs?
Date: Mon, 17 Dec 2001 23:32:06 +0100
Cc: Hans Reiser <reiser@namesys.com>
References: <3C1B64C5.4000207@namesys.com> <Pine.GSO.4.33.0112170709420.10438-100000@raven> <20011217113903.77f0d383.fw@fwsystems.com>
In-Reply-To: <20011217113903.77f0d383.fw@fwsystems.com>
MIME-Version: 1.0
Message-Id: <20011217223207.325781821@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Dec 2001 17:39, forrest whitcher wrote:
> A more prosaic concern:
>
> Can we depend on the log check & replay functions and the fs-specific
> backup/restore to maintain inode:file persistence?

Log check and reply merely guarantee the results that would be usual anyway 
(IE Inodes don't change etc), so they should be fine.

As for backup and restore, it'll work for dump/restore but not for tar/cpio.  
There is no dump for ReiserFS...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
