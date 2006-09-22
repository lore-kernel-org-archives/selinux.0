Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MF1tjR021693
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:01:55 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MF1N8R009005
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:01:24 GMT
Date: Fri, 22 Sep 2006 11:01:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
In-Reply-To: <1158933001.17541.18.camel@twoface.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0609221059560.7628@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
  <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
 <1158931612.14644.36.camel@localhost.localdomain>
 <1158933001.17541.18.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Sep 2006, Joshua Brindle wrote:

> I don't know about this either. I was under the impression that
> reconciliation was for multiple *data* labels (e.g., using ipsec and
> cipso at the same time). I don't know how secmark ever got pulled into
> this mess, secmark is for labeling packet objects, we never ask (or
> probably care) what the label on an individual packet is.

I thought the idea was to allow internal labels to transition to a new 
label based on the external label (simplified version), and to allow both 
ipsec and cipso labeling as external labeling schems to work well with 
this, but not at the same time.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
