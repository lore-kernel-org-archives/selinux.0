Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23250
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 08:49:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA07096
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 12:48:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA07091 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 12:48:05 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: revising the su decision
Date: Fri, 12 Jul 2002 14:49:22 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0207120725020.28541-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207120725020.28541-100000@raven>
MIME-Version: 1.0
Message-Id: <20020712124923.8A94A148A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 13:26, Stephen Smalley wrote:
> On Fri, 12 Jul 2002, Brad Chapman wrote:
> >           Why do you have to change your role to sysadm_r before su'ing
> > to root? I was under the impression that becoming uid 0 by either logging
> > in or su'ing was sufficient.....
>
> The Linux root uid is not privileged with respect to the SELinux
> mandatory access controls.  Hence, in order to perform most administrative
> operations, you have to be both sysadm_r:sysadm_t and have the Linux root
> uid (or at least the proper Linux capabilities).

I think that Brad was asking why I login to a non-root account first.

One issue is the lack of dotfile support you mentioned before, although I 
could probably address that by having a PAM module that sets a different home 
directory used by the ssh config.

Another issue is that of auditing.  Having a non-root identity makes many 
things easy to solve when a number of people have root and sysadm_r access.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
