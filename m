Subject: Re: Configuring kernel module for labeling ...
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1099420972.31739.269.camel@moss-spartans.epoch.ncsc.mil>
References: <1099385154.11681.3.camel@jsingh>
	 <200411030323.16648.russell@coker.com.au>
	 <1099417545.12370.21.camel@jsingh>
	 <1099420134.31739.250.camel@moss-spartans.epoch.ncsc.mil>
	 <1099420972.31739.269.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1099427580.12614.15.camel@jsingh>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 02:03:01 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

this can't be real ... or is it the matrix ... I have been trying these
things for the past 7 days .. and you solved them . in just two mails.

Thanx a lot sir...

On Wed, 2004-11-03 at 00:12, Stephen Smalley wrote:

> Looking at mini_fo/main.c, I see that it doesn't copy the inode
> attributes (e.g. mode) until after the d_instantiate.  Not good for
> SELinux, as we want the mode at that time to determine the security
> class.  Might want to try the patch below.
> 
It worked .. and i have tested it now.
> Note that fs/xattr.c:setxattr() calls a security_inode_post_setxattr()
> hook function upon successful setting of the attribute to tell 
> SELinux to update its incore inode SID as well. You need to do 

Ok... i got it now. Yups I have seen the code ... I thought something on
the same lines .. I will try to figure it out my-self and bother you
only if i can't do it.

Can you provide me with some documents/links .. so that i can learn
these things ... with details.

Thanx a lot...
Jaspreet Singh.

-- 
:: don't walk as if you own the world 
	 walk as if you dont damn who owns it ::




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
