Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MKiHaV001181
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:44:17 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MKhGEW006801
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 20:43:17 GMT
Date: Fri, 22 Sep 2006 16:44:12 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
In-Reply-To: <451421C6.5050003@hp.com>
Message-ID: <Pine.LNX.4.64.0609221640590.10058@d.namei>
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
 <451421C6.5050003@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Sep 2006, Paul Moore wrote:

> Venkat Yekkirala wrote:
> > OK, here's what we will do:
> > 
> > 1. We will have getpeercon() fail if there's no labeled-SA.
> 
> ... or NetLabel :)  What do you propose we do if there is both a SA and
> NetLabel label, bearing in mind that NetLabel may be a full context?

I don't think we should have both of these possible for the same packet.  
It's too complicated. 

Remember: CIPSO is just a legacy technology which is useful for talking to 
existing CIPSO systems.  We should not be making the rest of the code jump 
through hoops to accomodate things it was never intended for, such as 
integrated IPsec protection.

The preferred & recommended means to implement labeled networking is via 
the new xfrm labeling.  If you want to talk to legacy CIPSO systems the 
way they already talk to each other, fine, but don't expect anything more 
than that.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
