Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA25984
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 14:10:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA07677
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 18:09:41 GMT
Received: from unicorn.lemuria.org (b067043.adsl.hansenet.de [62.109.67.43])
	by jazzswing.ncsc.mil  with ESMTP id SAA07673
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 18:09:40 GMT
Date: Fri, 12 Jul 2002 20:06:08 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: revising the su decision
Message-ID: <20020712200607.C26001@lemuria.org>
References: <20020712111941.30466.qmail@web40009.mail.yahoo.com> <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com>; from brazell@bmh.com on Fri, Jul 12, 2002 at 01:10:19PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 12, 2002 at 01:10:19PM -0400, Natr Brazell wrote:
> facility I am at even though no one knows anything about selinux expect 
> how to spell it so I guess I am the expert.  (Haven't got the T-Shirt yet) 
> but I have got people looking at my configuration as a starting point for 
> future projects.  Now to my question...
> 
> ...  What is this lists proposal for how to manage and push to multiple 
> machines quickly and securely based on the above comments?

I'm probably about as much expert as you are (no T-shirt, either) so
don't trust me unless someone else says I got it right, but this is
what I think would be the right way to do it:

a) SELinux basic assumption is not to trust, especially not remote
parties. that's a Good Thing(tm).

b) so, what you need is a trusted process ON the machines. ideally,
with a policy crafted specifically for it. I'll call this process
instwa, the "install watcher". it could be as simple as a cronjob
called every 5 minutes that essentially does:

if ( any file in /var/install ) then ( rpm/dpkg/whatever -i $file )

c) give your remote/install user write priviledges for /var/install

d) voila. you can push software unto the machines and the instwa will
take care of the installation.

-- 
New GPG Key issued (old key expired):
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
