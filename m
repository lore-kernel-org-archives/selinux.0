Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5RDbjrT008170
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 09:37:45 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5RDbU5h010435
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 13:37:31 GMT
Message-Id: <200406271337.i5RDb5cN011052@mms-r01.iijmio.jp>
Date: Sun, 27 Jun 2004 22:37:03 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov,
   himainu-ynakam@miomio.jp
Subject: Re: Policy for webalizer
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200406272218.31524.russell@coker.com.au>
References: <200406272218.31524.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I checked your changes and webalizer worked, thank you.

Russell Coker <russell@coker.com.au> wrote:
> As a general rule we don't want to allow any daemons access to the 
> administrator console if we can avoid it.  I'm not sure what the best thing 
> to do for webalizer is in this regard.
I am not sure.
What can attacker do , when he obtains write access right to console file?

> We could have /var/www/usage labelled as httpd_sys_content_t.  That gives less 
> types (less pain) for no significant decrease in security.  I should probably 
> make a similar change to calamaris_t.
I think we should pay attention when we give write access to homepage,
because many users think homepage is important.
In this configuration, if attacker has webalizer_t domain by some way, 
he can compromise whole homepages. 
And if administrator misconfigured /etc/webalizer.conf, homepages may be broken.
I think we should give new type to /var/www/usage .


---
Yuichi Nakamura
Japan SELinux Users Group(JPSEG)
http://www.selinux.gr.jp/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
