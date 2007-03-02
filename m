Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l22K8D3p013125
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 15:08:13 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l22K9bOK023059
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 20:09:37 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [RFC] Policy Management Server release
Date: Fri, 2 Mar 2007 15:09:36 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015888BAC2F@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A release of the policy management server has been put on
oss.tresys.com. This version is completely redesigned from the last
release in that it uses hooks within libsepol expansion code to handle
enforcement. This allows the policy management server to handle the
access control more abstractly, similar to SELinux within the Linux
kernel. This release also has a less granular object model, not for a
technical reason but because it was felt that the extra permissions
weren't necessarilly useful. Since this is an RFC we'd love to hear
comments about the design and the object model.

Without further ado, instructions for trying out the policy management
server are available at
http://oss.tresys.com/projects/policy-server/wiki/PolicyServerHowTo.
This is still a prototype release and should not be used on production
systems.

For those wanting to look at the source code, the svn checkout is
available at
http://oss.tresys.com/projects/policy-server/browser/branches/selinux-pm
s-support for the patches to the upstream SELinux code, quilt should be
used to apply the patches in the patches/ directory and
http://oss.tresys.com/projects/policy-server/browser/branches/trunk-pms
for the policy management server source.

Please let me know if there are any problems with this. At some point
the patches will start to trickle onto list to get upstreamed, after
they've been cleaned up and reviewed more heavily.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
