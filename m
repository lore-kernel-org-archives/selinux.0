Subject: Re: 2.6.25-rc5
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Justin Mattock <justinmattock@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.64.0803111843320.8616@us.intercode.com.au>
References: <dd18b0c30803102202i15fa5b28m2b05b597dee12adc@mail.gmail.com>
	 <Xine.LNX.4.64.0803111843320.8616@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 14:59:58 -0400
Message-Id: <1205261998.23866.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 18:44 +1100, James Morris wrote:
> On Tue, 11 Mar 2008, Justin Mattock wrote:
> 
> > Hello
> >  I've updated to 2.6.25-rc5 and am noticing new security cleasses in
> > SELinux, also the new POSIX option is nice.
> > 
> > [    1.074531] security:  permission egress in class netif not defined in
> > policy                     <----new
> 
> That's fine, it just means that the kernel is aware of permissions that 
> your policy is not.

And just to clarify, those permissions aren't necessarily being enforced
by your kernel.  The new networking permissions only get enabled if the
network_peer_controls capability is set in your policy.  That is to
prevent breakage for existing users until policy is updated to support
the new controls.  I think the necessary rules have been added to the
upstream refpolicy, but the capability hasn't been turned on yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
