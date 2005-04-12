Date: Tue, 12 Apr 2005 12:52:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: inode_doinit_with_dentry messages
In-Reply-To: <200504130026.12751.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Apr 2005, Russell Coker wrote:

> Would it be possible to have a file in /selinux to determine whether such 
> messages are displayed?
> 
> When we convert a machine between strict and targeted policies we (the 
> developers) expect many such messages.  The users however will not be 
> expecting such messages to fill their logs, so it would be good if we could 
> turn off the logging of such messages for the duration of setfiles operation.

How are you doing the conversion?

I usually edit the config file, boot with selinux=0, relabel, then reboot 
with selinux=1.

How many people really need to do this though?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
