Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CAPV3P021601
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 06:25:32 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CAOBmj023339
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 10:24:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Klaus Weidner <klaus@atsec.com>
Subject: Re: MLS enforcing PTYs, sshd, and newrole
Date: Thu, 12 Oct 2006 20:25:12 +1000
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
References: <20061012073338.GG28525@w-m-p.com>
In-Reply-To: <20061012073338.GG28525@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610122025.15043.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 October 2006 17:33, Klaus Weidner <klaus@atsec.com> wrote:
> If you need local console (or serial) login at different MLS levels for
> the same user, you can create multiple Linux users for each human user
> that share the same uid and home directory, and use "semanage login" to
> map them to appropriate levels. So you'd have smith_secret_cat1,
> smith_unclassified and so on.

That doesn't work well with password expiry policies.  Having 
smith_secret_cat1 password expire at different times to smith_unclassified 
would be a pain for users and sys-admins.

Then if you want to use RSA SecurID or similar tokens you have an extra level 
of pain in mapping them to the right Unix account names.

I think that the right solution is to re-enable the code for selecting the 
role etc at login time and adding some code for selecting the level.  It 
should not be difficult to do this if there are no plans to ever support it 
for ssh or X logins.

> It should still work to put a multilevel X desktop on top of this, since
> that presumably uses a mechanism other than "newrole" to launch terminals
> or windows at different levels. But that's only guesswork due to not
> having seen any code for this...

Can someone who has worked on one of these things before please comment on how 
it's done?

It seems to me that the current way of managing desktops isn't going to work 
(IE Gnome and KDE won't work).

Currently we have a desktop manager program that can launch an xterm (in the 
same context) and then a shell (EG bash) is run in the same context as an 
xterm.  This means that if you run a hostile program in one xterm it can 
ptrace or otherwise interfere with all processes back to the desktop and down 
again to another xterm.  I guess we need to have a trusted desktop manager (I 
use the term loosely, such a program probably wouldn't have 10% the features 
of anything we currently call a "desktop manager") that launches xterms in 
different contexts depending on what they are doing and has the option of 
launching an xterm that runs "newrole -l" (or maybe launches xterms at 
different levels).

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
