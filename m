Subject: Re: inode_doinit_with_dentry messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 13:04:24 -0400
Message-Id: <1113325464.25217.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-12 at 12:52 -0400, James Morris wrote:
> On Wed, 13 Apr 2005, Russell Coker wrote:
> 
> > Would it be possible to have a file in /selinux to determine whether such 
> > messages are displayed?
> > 
> > When we convert a machine between strict and targeted policies we (the 
> > developers) expect many such messages.  The users however will not be 
> > expecting such messages to fill their logs, so it would be good if we could 
> > turn off the logging of such messages for the duration of setfiles operation.
> 
> How are you doing the conversion?
> 
> I usually edit the config file, boot with selinux=0, relabel, then reboot 
> with selinux=1.
> 
> How many people really need to do this though?

I don't think we want to create a special case just for this particular
error message, or pollute selinuxfs with individual toggles for each
such case.  Possibly we could convert many of the error messages in
hooks.c and ss/*.c to using audit_log instead of printk, then set up
filtering in auditd.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
