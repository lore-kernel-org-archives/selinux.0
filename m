MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] libselinux: class and permission mapping support
Date: Wed, 6 Jun 2007 11:45:45 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BF0563@exchange.columbia.tresys.com>
In-Reply-To: <4666D5E6.508@tycho.nsa.gov>
References: <4666D5E6.508@tycho.nsa.gov>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This provides support for userspace object managers to
> register a mapping of class and permission values.  After the
> mapping is registered all libselinux functions that take a
> security class or permission value must be provided with
> mapped values instead of the "real," kernel values.
> 
> Changes from the original interface proposal: No
> selinux_init() function, just a straight set_mapping()
> function.  Also, to simplify things the incoming mapping does
> not include explicit values; the classes and permissions are
> numbered implicitly by their ordering.  NULL strings are used
> to terminate the lists.
> 
> Tested with X server, no problems encountered.
> 
> This patch includes the interface and implementation of the mapping
> set function. 
> 

Hrm, I thought we agreed that remapping access vectors at runtime was a
bad idea?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
