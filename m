Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l299JwYg011392
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 04:19:58 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l299JsoJ025832
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 09:19:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: mmap_file_perms needs ioctl also
Date: Fri, 9 Mar 2007 18:38:25 +1100
References: <45F02B61.7040008@redhat.com>
In-Reply-To: <45F02B61.7040008@redhat.com>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703091838.26634.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why?

Many programs that mmap files will also make ioctl() calls on them.  But AFAIK 
there is nothing forcing the application programmer to do so.  Expanding the 
permissions in this regard seems unnecessary.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
