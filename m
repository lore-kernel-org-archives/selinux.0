Date: Wed, 11 Sep 2002 14:27:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: can_exec_read macro
In-Reply-To: <200209031647.QAA25434@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0209111426160.8813-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 3 Sep 2002, Carsten Grohmann wrote:

> What is the difference between this tow macros: can_exec and
> can_exec_read? I see none.
> Both use the rx_file_perms macro. And in my opinion is the second read in
> can_exec_read unnecessary. The rx_file_perms macro contains it.
>
> We should change it. Or?

This macro and all of its uses have been removed from the sourceforge CVS
tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
