Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11831
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 18:45:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA28206
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:43:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA28202 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:43:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Changing the default role/type of a user
Date: Tue, 20 Aug 2002 00:44:48 +0200
References: <20020819220134.41324.qmail@web40004.mail.yahoo.com>
In-Reply-To: <20020819220134.41324.qmail@web40004.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020819224448.7446C129F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Aug 2002 00:01, Brad Chapman wrote:
> In my policy, my username of Brad is placed in the role user_r and the
> domain user_t. However, the login program has my username in the role
> sysadm_r and the domain sysadm_t, despite there being no such role
> configured in the users file. Why does the login program do this?

It sounds like it's set to that in /etc/security/default_context .

Although if the policy doesn't permit this then login should not be allowed 
to do it.  Are you running in permissive mode?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
