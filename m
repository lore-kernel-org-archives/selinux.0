Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA15491
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 07:03:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA07917
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 11:02:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA07913
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 11:02:42 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Changing the default role/type of a user
Date: Tue, 20 Aug 2002 13:03:30 +0200
Cc: selinux@tycho.nsa.gov
References: <20020819231053.24335.qmail@web40012.mail.yahoo.com>
In-Reply-To: <20020819231053.24335.qmail@web40012.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020820110330.618E389F2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Aug 2002 01:10, Brad Chapman wrote:
> > > In my policy, my username of Brad is placed in the role user_r and the
> > > domain user_t. However, the login program has my username in the role
> > > sysadm_r and the domain sysadm_t, despite there being no such role
> > > configured in the users file. Why does the login program do this?
> >
> > It sounds like it's set to that in /etc/security/default_context .
> >
> > Although if the policy doesn't permit this then login should not be
> > allowed to do it.  Are you running in permissive mode?
>
> Yes, but when I try to login with Brad:sysadm_r:sysadm_t, it fails, since I
> don't have that role in the list in the users file; AAR, it complains that
> there's no SID for it. So I enter user_r and user_t for my role/type, which
> IS in the users file, and it logs in happily.

So change the /etc/security/default_context to have Brad:user_r:user_t and 
everything should be fine.

> I am using permissive mode right now, because I want to be absolutely sure
> that the parts of the policy which apply to what I do are foolproof. My
> su_macros and user_macros files are growing again, but otherwise my (or
> your) policy is quite well set up, IMO.

There is no reason for su_macros to grow unless you use other forms of 
authentication than /etc/shadow, in which case the correct thing to do is add 
rules for the "auth" attribute which affect su and all other programs that do 
authentication.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
