Message-ID: <20050225190043.30364.qmail@web51510.mail.yahoo.com>
Date: Fri, 25 Feb 2005 11:00:42 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [PATCH][SELINUX] 3/7 Add node controls
To: jmorris@redhat.com
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri 9 Jan 2004 - at 10:39, James Morris wrote:
> This patch against 2.6.1-mm2 adds 'node' access
> controls for SELinux, which allows network traffic 
> to be controlled on the basis of remote address. 

Can 'node' access controls now permit controls
on inbound messages based on the source address in
addition to permit controls on outbound messages based
on the destination address you mentioned above.

Thanx.


=====
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
