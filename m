Subject: Re: object class discovery userland
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4628D4FE.5050604@kaigai.gr.jp>
References: <1177077717.15762.32.camel@sgc>  <4628D4FE.5050604@kaigai.gr.jp>
Content-Type: text/plain
Date: Fri, 20 Apr 2007 11:32:14 -0400
Message-Id: <1177083134.24870.9.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 23:58 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > I have nearly completed the kernel patch for object class discovery
> > which creates the structure:
> > 
> > /selinux/class/CLASSNAME/index
> > /selinux/class/CLASSNAME/perms/PERMNAME
> > 
> > so you get the class index number from the index file, and the
> > permission name file gets the index number of the permission.

> I really wanted the kernel/userland interface to obtain object classes and
> permissions number.
> 
> BTW, what is the reason for 1:1 mapping between PERMNAME entry and permission number?
> For example, if /selinux/class/index provides the pair of object class number/name
> and /selinux/class/CLASSNAME provides the pair of permission number/name, we can
> obtain them with simple iterations of fscanf("%u %s", ...).

See http://marc.info/?l=selinux&m=117580309612610&w=2

> We maybe cache them in userland until the security policy reloaded.

Class and permission indexes aren't really used outside of userspace
object managers.  I'd expect object managers to do this for the classes
they care about, for themselves.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
