Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJwuxZ026255
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:58:56 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PJwMaU002728
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:58:23 GMT
Date: Mon, 25 Sep 2006 15:58:50 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: Labeled networking packets
In-Reply-To: <1159208054.4741.20.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609251555000.26346@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
  <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
 <1159199759.3169.29.camel@twoface.columbia.tresys.com>
 <1159203754.21540.156.camel@moss-spartans.epoch.ncsc.mil>
 <1159208054.4741.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Sep 2006, Karl MacMillan wrote:

> So I am getting very concerned that our model has all of these layers
> (process->sockets->SA combined with secmark rules via type_transition).

It's fine.  Think of it like a file being created, which may get a label 
based on a number of factors including the creating context and the parent 
directory context.

For networking, we're doing something similar, and just allowing all of 
the important factors to contribute to the labeling, including 
policy-controlled transitions as the labeling requirements become more 
specific.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
