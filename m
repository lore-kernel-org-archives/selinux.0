Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA24193
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 18:16:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA11140
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 22:15:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA11136
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 22:15:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: More Samba
Date: Fri, 2 Aug 2002 00:16:01 +0200
References: <000801c239a5$9a226e50$0300a8c0@donkey> <20020801215515.35EBB493@lyta.coker.com.au>
In-Reply-To: <20020801215515.35EBB493@lyta.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020801221602.48BD97737@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Aug 2002 23:55, Russell Coker wrote:
> > On a related note, I just realized that I didn't take into consideration
> > the case where the log files need to be created. In those cases, smbd_t
> > and nmbd_t both need add_name and write access for dir in samba_log_t.
>
> rw_dir_create_file({ smbd_t nmbd_t }, samba_log_t)

Actually, that's not so good.  I think we need a new macro something like the 
following:

define(`create_append_log_file', `
allow $1 $2:dir { read getattr access search add_name write };
allow $1 $2:file { create getattr access setattr append link };
')

What do you think?  There's probably quite a few places where 
rw_dir_create_file() could be replaced with such a macro...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
