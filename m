Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01594
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 07:08:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA17724
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 11:07:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA17720
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 11:07:56 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6C69792469
	for <selinux@tycho.nsa.gov>; Thu,  8 Aug 2002 21:08:49 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id D247E3C7C
	for <selinux@tycho.nsa.gov>; Thu,  8 Aug 2002 13:08:41 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new policy
Date: Thu, 8 Aug 2002 13:08:41 +0200
MIME-Version: 1.0
Message-Id: <20020808110841.D247E3C7C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Aug 2002 12:41, Russell Coker wrote:
> I am developing a new policy for chroot environments.  It consists of two
> domains, $2_super_t and $2_t.

I've just added a new type that's like $2_ro_t called $2_dropdown_t with the 
following:
domain_auto_trans($2_super_t, $2_dropdown_t, $2_t)

This is for /etc/init.d/* for example, so that when a package installation 
(which has to run as $2_super_t to write to /usr/bin etc) runs a daemon then 
the daemon will run as $2_t.  This is so that if you have an sshd to provide 
user accounts in the chroot then the sshd will run as $2_t and the users will 
get $2_t.

The only way of entering $2_super_t will be from the user_t domain (or 
whatever domain the user in question has as their main domain) so there's no 
way of increasing privs from inside the chroot.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
