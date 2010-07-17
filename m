Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6H5EJrL006600
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2010 01:14:23 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6H5DQpr026594
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2010 05:13:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: restorecon and chroot
Date: Sat, 17 Jul 2010 15:14:15 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201007151427.01927.russell@coker.com.au> <4C3F107C.10905@redhat.com>
In-Reply-To: <4C3F107C.10905@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007171514.16224.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Jul 2010, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Why not just use setfiles, since you will need to specify the
> file_context path anyways?

setfiles requires that you specify the full path of the file_contexts file, 
this means that documentation that refers to it has to be distribution 
specific to a certain extent and it's annoying to use.

Now if setfiles could default to using the same file_contexts file that 
restorecon uses then that objection would go away.  Do you think we should 
change setfiles in such a manner?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
