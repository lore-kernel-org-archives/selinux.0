Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA20948
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 21:55:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA28768
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 01:54:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA28764
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 01:54:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: /etc/resolv.conf
Date: Fri, 12 Jul 2002 03:54:49 +0200
References: <20020712014137.GA2504@snoopy.apana.org.au>
In-Reply-To: <20020712014137.GA2504@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020712015450.28D7442F2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 03:41, you wrote:
> If I edit /etc/resolv.conf as sysadm, eg. using vim, it gets the label
> root:object_r:etc_t.
>
> This means pumpd can no longer alter it, it requires
> it be system_u:object_r:resolv_conf_t.
>
> What is the best way around this problem.

I have been thinking of writing a script that uses a similar concept to 
"vipw" for such things.  It would use the setfiles configuration file to 
determine the correct context, and it would cause vi to edit the file under 
/tmp and use open_secure() to create the new file after vi has finished.

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
