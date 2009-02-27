Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1R2MSPw007978
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 21:22:28 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1R2MPme024669
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 02:22:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to libsemanage to remove labeling of /root
Date: Fri, 27 Feb 2009 13:22:14 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <496C9A96.1080805@redhat.com> <499C2D9F.4040806@manicmethod.com> <499C32C8.2020700@redhat.com>
In-Reply-To: <499C32C8.2020700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902271322.18928.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Feb 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> The problem with treating /root as the same as every other homedir, is
> confined daemons all consider /root their home dir, so they want to be
> able to read/write contents in the homedir.

We should not be allowing confined daemons to write to /root.

There is little point in confining a daemon if it can write to a file such 
as /root/.bashrc which is likely to be executed as unconfined_t.

The only reason a confined daemon should access /root is if the sysadmin 
starts it immediately after logging in without changing directory.  A daemon 
starting with a cwd that is not accessible should not be a problem, if it is 
then there are other usage cases that will get you.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
