Subject: Re: Problems related to the policy management infrastructure
From: Dominick Grift <domg472@gmail.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1239290894.22856.55.camel@moss-lions.epoch.ncsc.mil>
References: <1239290894.22856.55.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 18:49:12 +0200
Message-Id: <1239295752.6022.25.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-09 at 11:28 -0400, James Carter wrote:
> 1. Distribution of policy
> 	a. No way to easily distribute custom policy

1. - work like shared libs and not static libs

I created my own user domain and distributed this as a stand alone
module to other systems in my network.

One of the interfaces i call in that module was changed.

Now i have to rebuild, re-install my stand alone module so that the
changes apply.

After every selinux-policy update i rebuild/re-install all my stand
alone modules just to make sure latest policy applies.

2. - implement shared policy

I have two stand alone modules that share policy. This cannot be build.

The development part is not aware of either modules shared policy.

This makes the concept of sharing policy useless for stand alone
modules.

3. - there is a file object context file (.fc) but what about port
object contexts? etc.

If i want to declare a port in my standalone module i have to label it
manually using semanage port -a. This is because "normally" ports are
declared/maintained in corenetwork.if.in. A .pc ( port object context
file ) would be easier i think. 

4. - file context can not be removed or modified because it is defined
in policy.

I have my own git stand alone policy module. However i cannot install it
because some of the contexts defined in it conflict with contexts
declared in policy (selinux-policy). These contexts cannot be
modified/removed.

The issues i noted above all make it hard to manage (stand alone)
policy. They are ,in my opinion, good reasons why the modular .pps' are
no serious full alternative to developing in the main policy package.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
