Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V9xqDo023430
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 04:59:52 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V9tuTg011301
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 09:55:56 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050330175836.45907.qmail@web31614.mail.mud.yahoo.com>
References: <20050330175836.45907.qmail@web31614.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 05:04:40 -0500
Message-Id: <1112263480.10971.34.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 09:58 -0800, Casey Schaufler wrote:
> --- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> 
> > Ok, some apps like gift don't ask where to save the
> > content, 
> > but that's the exception and not the rule. 
> 
> I challenge you to back up this claim.

I don't need to back up this claim, because:

1) Apps that don't let you configure where to save your content are
badly designed.

2) They can be changed

3) If they're not changed, it doesn't matter, because what I'm proposing
is backwards compatible. User_t will still have access to all content
types, and can write stuff to /home as user_home_t. Apps will have to be
specifically confined in order not to be able to write to user_home_t.
If some app is a problem, it can be left to run at user_home_t for now.

4) If apps store stuff in a hardcoded location, we can label that easily
with the proper context, unless it's hardcoded to /home or some other
shared place. 

Anyway, I am starting to get a better idea as to how this might work - 
see my response to Luke's message.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
