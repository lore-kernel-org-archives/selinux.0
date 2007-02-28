MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Dropping compat support for /etc/security policy file paths
Date: Wed, 28 Feb 2007 08:11:05 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015888BA98E@exchange.columbia.tresys.com>
In-Reply-To: <1172667712.19041.455.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Steve G" <linux_4ever@yahoo.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Manoj Srivastava" <manoj.srivastava@stdc.com>,
        "Russell Coker" <russell@coker.com.au>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> Hi,
> 
> Are any active distributions still using the old 
> /etc/security/ location and layout for SELinux policy files?  
> If not, we could drop the compat file path support from 
> libselinux on the trunk.
> 

Gentoo has switched to refpolicy with standard paths since this is
required for modular policy and semanage. I'm fine with its removal.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
