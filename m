Subject: Re: Stopping COTS from accessing root directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gregg Tomas <java_gregg@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <533612.81219.qm@web110407.mail.gq1.yahoo.com>
References: <533612.81219.qm@web110407.mail.gq1.yahoo.com>
Content-Type: text/plain
Date: Fri, 29 Jan 2010 10:25:35 -0500
Message-Id: <1264778735.16815.125.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-28 at 16:28 -0800, Gregg Tomas wrote:
> Hello Everyone,
> 
> Bare with me, I am fairly new to SELinux policy writing.
> 
> How do you write a rule to stop an application from accessing the root
> (/) directory? 
> I am running Open Office (openoffice_exec_t) and whenever I open the
> open dialog (From the menubar, File -> Open) , on the top right of the
> open dialog, there are 3 buttons. The left most button is the "up one
> level" button. If you click and hold your mouse left button down on
> it, a sub menu appears and display a menu item called Workplace. If I
> click on it, it will bring you to root directory (/). I am trying to
> prevent that. I have a neverallow rule in my test.te:
> neverallow openoffice_exec_t root_t:dir { search }; 
> However, it still transitions there after I touch /.autorelabel and
> reboot.
> 
> Thanks.

neverallow rules are assertions that are checked by the policy compiler.
They are not "deny" rules (nor is there such a thing in SELinux), and
they do not remove allow rules.  They just cause a policy build to fail
if they are violated.  They only get checked if you set expand-check=1
in your /etc/selinux/semanage.conf or you perform a local build via
semodule_link and semodule_expand (as is done in the make validate
target of refpolicy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
