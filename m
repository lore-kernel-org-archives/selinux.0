MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] selinux: Kernel access key retention support for SELinux
Date: Fri, 2 Jun 2006 13:09:43 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588210227@exchange.columbia.tresys.com>
From: "Frank L. Mayer" <mayerf@tresys.com>
To: <casey@schaufler-ca.com>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        "David Howells" <dhowells@redhat.com>
Cc: "Michael LeMay" <mdlemay@epoch.ncsc.mil>, <jmorris@redhat.com>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Discretionary access control is what the basic Linux access control 
> > model is.  Mandatory access control is what SELinux provides.
> 
> With user settable MCS labels SELinux provides a 
> Discretionary Access Control mechanism.

And with non-user settable MLS and/or Type labels SELinux provides MAC.
Hence Steve's point.  Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
