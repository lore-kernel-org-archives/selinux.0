Date: Fri, 25 Feb 2005 16:29:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Park Lee <parklee_sel@yahoo.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 3/7 Add node controls
In-Reply-To: <20050225190043.30364.qmail@web51510.mail.yahoo.com>
Message-ID: <Xine.LNX.4.44.0502251629040.11242-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Feb 2005, Park Lee wrote:

> On Fri 9 Jan 2004 - at 10:39, James Morris wrote:
> > This patch against 2.6.1-mm2 adds 'node' access
> > controls for SELinux, which allows network traffic 
> > to be controlled on the basis of remote address. 
> 
> Can 'node' access controls now permit controls
> on inbound messages based on the source address in
> addition to permit controls on outbound messages based
> on the destination address you mentioned above.

Yes, these controls are always specify the remote node.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
