Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7I9pJrT019073
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 05:51:20 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7I9pJRq013490
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 09:51:19 GMT
Date: Wed, 18 Aug 2004 11:02:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: bug in policy (1.14-3+?) with apache.te unused
Message-ID: <20040818100223.GA19646@lkcl.net>
References: <20040817112916.GN18321@lkcl.net> <200408181845.50618.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408181845.50618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 06:45:50PM +1000, Russell Coker wrote:
> On Tue, 17 Aug 2004 21:29, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i upgraded to 1.14-6 on the policycoreutils and i get
> > httpd_sysadm_content_t does not exist in file_contexts
> > on a make relabel.
> 
> That's a minor bug in the apache policy for Debian, I'll fix it in the next 
> upload.
 
 ah, cool.

 well, i removed apache.te and openca.te and that fixed it, too.

> > so.... well, i figured okay, let's make apache.te unused
> > (as i should have done in the first place) because apache
> > isn't on this system.
> >
> > i get a compile error on openca.te not being able to find
> > httpd_t.
> 
> openca-ca.te depends on apache.te .  Why do you want to use openca without 
> Apache?  Is it usable?

 ... i have _no_ idea :)

 if it's a dependency, maybe it's good that it breaks.

 it would be better to have some sort of more descriptive error
 message saying "you don't have a policy for apache.te but are trying
 to use openca.te".

 then people can choose, based on now knowing what's going on, to either
 install apache.te or remove openca.te.

 *shrug* :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
