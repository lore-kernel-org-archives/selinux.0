Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA02375
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 18:30:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA00986
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 22:29:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA00982
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 22:29:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: Swollen su_macros.te file
Date: Tue, 13 Aug 2002 00:28:38 +0200
Cc: selinux@tycho.nsa.gov
References: <20020812132144.97044.qmail@web40008.mail.yahoo.com>
In-Reply-To: <20020812132144.97044.qmail@web40008.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020812222957.674718732@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Aug 2002 15:21, Brad Chapman wrote:
>         The context REMAINS THE SAME! Even when I use 'su -l' !!!
>
>         What does this mean?

This means that su is operating correctly on your system.


So how do you cause the situation where your programs are running in the su 
domain and causing the errors to be logged?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
