Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00932
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 17:05:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA02251
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 21:04:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA02247
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 21:04:55 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
Date: Thu, 27 Jun 2002 17:05:21 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627205745.33725.qmail@web40020.mail.yahoo.com>
In-Reply-To: <20020627205745.33725.qmail@web40020.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627210521.9756D7D38@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 16:57, Brad Chapman wrote:
>         I'm not using selinux-small. I'm using selinux-2002053110.tar.gz,
> downloaded straight from www.nsa.gov. And the rule you told me I needed
> will look something like this:
>
>         allow devfsd_t devfs_t:chr_file { read };

Yes

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
