From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jsingh@ensim.com
Subject: Re: Configuring kernel module for labeling ...
Date: Wed, 3 Nov 2004 03:23:16 +1100
Cc: nsa <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
References: <1099385154.11681.3.camel@jsingh>
In-Reply-To: <1099385154.11681.3.camel@jsingh>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411030323.16648.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Nov 2004 19:45, Jaspreet Singh <jsingh@ensim.com> wrote:
> I am writing an overlayfs module which is not able to set/getxattrs of
> the underlying etx3 dentries properly ???

Luke answered the base part of the question correctly, you need to modify 
fs_use.

However I am concerned about your above paragraph, it is unclear and I can 
interpret it in two ways - which require different policies.  Please describe 
this problem in much more detail and I'll tell you the best answer.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
