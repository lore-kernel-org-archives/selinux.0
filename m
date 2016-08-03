Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u73CvZfE013568
 for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2016 08:57:36 -0400
From: Colin Powers <Colin.Powers@nexor.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Should port 3269 be ldap_port_t?
Date: Wed, 3 Aug 2016 12:48:13 +0000
Message-ID: <DB6PR0301MB2568DA47381B2C302EEC7D9F9E060@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

First of all apologies if something has changed in this area recently, I have checked on a RHEL 7 machine and noticed the omission.

LDAP is associated with the following ports:
- 389 for plain LDAP
- 686 for LDAPS
- 3268 for Global Catalog
- 3269 for Global Catalog over LDAPS

All of these ports are ldap_port_t except 3269 which is not given any special type.

Because of this, my Apache set-up was unable to perform LDAP authorisation while in enforcing. Obviously I can fix the issue with semanage, but should 3269 be ldap_port_t out of the box?

Cheers

Colin Powers
