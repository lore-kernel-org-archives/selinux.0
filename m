Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BMAiK5029508
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 18:10:44 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2BMAgHB022451
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 22:10:42 GMT
Date: Wed, 12 Mar 2008 09:10:29 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Justin Mattock <justinmattock@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: 2.6.25-rc5
In-Reply-To: <dd18b0c30803111352r25eb64a0m335b5a0740d5646c@mail.gmail.com>
Message-ID: <Xine.LNX.4.64.0803120907480.8423@us.intercode.com.au>
References: <dd18b0c30803111352r25eb64a0m335b5a0740d5646c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Mar 2008, Justin Mattock wrote:

> Hi;
> Thanks for the reply, With handle_unkown=deny  should this provide enough
> security, until the upstream release comes out?

Yes, although the default is 'allow', so that your system doesn't break 
due to lack of policy for the new permissions.  For production systems, I 
suggest ensuring that you have both the kernel and policy updated to match 
each other.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
