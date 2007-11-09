Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9GvYNf028007
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 11:57:34 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9GvWf4024677
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 16:57:33 GMT
Subject: Re: type class key
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <47336D33.4010606@redhat.com>
References: <1194529933.3293.7.camel@vogon>  <47336D33.4010606@redhat.com>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 16:56:52 +0000
Message-Id: <1194627412.3630.2.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-08 at 15:10 -0500, Daniel J Walsh wrote:
[...]
> The avc's you are reporting above are very strange.  They look like
> dovecot created a keyring, probably though pam_keyinit.  And now sshd is
> trying to access it.  I think you are running in permissive mode and
> your context is messed up.
> 
> When you login are you getting user_t or staff_t?

Yeah your right. There is a different. The AVCs are only generated when
I log in as a staff_t. I created a test user logged in as user_t and no
AVCs where generated.

Hope you have more ideas because I run out of them ;-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
