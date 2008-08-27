Subject: Re: Socket and inode label consistency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Trent Jaeger <tjaeger@cse.psu.edu>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 07:57:34 -0400
Message-Id: <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-26 at 20:50 -0400, Trent Jaeger wrote:
> Hi,
> 
> I see on the Kernel Development To Do list at http:// 
> selinuxproject.org/page/Kernel_Development that the following task is  
> identified:
> 
> "Full APIs for getting and setting security contexts of sockets and  
> IPC objects. Ensure that socket context is kept consistent on socket  
> inode and sock structures when changed."
> 
> We are being bitten by this now, so I am wondering if anyone is  
> working on it or wishes to discuss how to proceed.  We would be  
> interested in addressing this issue.

I don't know of anyone working on it, but we are interested in it.
As I recall, you can get and set the socket inode label via fgetxattr
and fsetxattr but the struct sock label isn't accessible from userspace
(except via getpeercon, and then only for the peer).  I think you'd need
to add a .setxattr method to the socket_file_ops and have them call into
the LSM interface to update the sock information (as well as continuing
to update the socket inode info).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
