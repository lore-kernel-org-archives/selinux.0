Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k02J5AXf010150
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 14:05:10 -0500 (EST)
Received: from luminouswebdesign.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k02J4AYl026471
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 19:04:11 GMT
Date: Mon, 2 Jan 2006 14:06:17 -0500
From: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>
Message-Id: <200601021906.k02J6HmB009362@luminouswebdesign.com>
To: linux-security-module@wirex.com
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux metadata protection
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------------------------
Casey Schaufler
casey@schaufler-ca.com
650.906.1780




--- KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:

> Date: Sun, 01 Jan 2006 03:11:47 +0900
> From: KaiGai Kohei <kaigai@kaigai.gr.jp>
> To: linux-security-module@wirex.com, "SELinux(NSA)"
> <selinux@tycho.nsa.gov>
> Subject: SELinux metadata protection
>
> Hello
>
>
> Nowaday, I´m considering about a philosophical
> theme.
>
> In my understanding, file-metadata includes
> _filename_ similar to filesize
> update-timestamp, and so on.

Casey takes a deep breath...

The filename is not an attribute of the file.
The pathname components are data contained
in directory entries. The association of path name
to inode number is one way. There is no association
of path name from file. Really. This is the thing
that make audit hard.

Yes, I know "It's obvious". It's just not true.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
