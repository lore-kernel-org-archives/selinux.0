Subject: Re: Nodecon configuration question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bludau <selinux-thomas@gonicus.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200905111534.16145.selinux-thomas@gonicus.de>
References: <200905111534.16145.selinux-thomas@gonicus.de>
Content-Type: text/plain
Date: Mon, 11 May 2009 09:43:15 -0400
Message-Id: <1242049395.4289.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-05-11 at 15:34 +0200, Thomas Bludau wrote:
> Hello,
> 
> i've a question for limiting network-access on my selinux installation. The 
> system which one i'm using is a debian lenny with the default policys and a 
> selfmade creation of java.pp and wine.pp. 
> 
> Now i would limit the access for the wine programms to 5 or 6 ip addresses 
> from the local network. 
> 
> That is what i was trying:
> At the first step i changed the inaddr_any_node_t type in the corenetwork.te 
> file to one of my needed ip addresses to test if it would work with a minimal 
> configuration change.
> like this:
> 
> type inaddr_any_node_t alias node_inaddr_any_t, node_type;
> nodecon 10.10.10.10 255.255.255.255 
> gen_context(system_u:object_r:inaddr_any_node_t,s0)
> 
> Typed a "make" and copied the base.pp into 
> the /etc/selinux/default/modules/active/ directory.

You aren't supposed to directly modify the modules/active directory;
instead you can update your base.pp file by running semodule -b base.pp.
That will not only put the base.pp file into place but also regenerate
and reload the kernel policy - no reboot required.

BTW, semanage now supports configuration of node contexts outside of the
base module if you want to try that.

> In the selfmade wine.te configuration i typed following:
> 
> allow wine_t inaddr_any_node_t:tcp_socket node_bind;
> 
> Every time i finished the make i reboot the system with the new base.pp. The 
> wine configuration is alway this one i want to have. ("semodule -l | grep 
> wine" shows the right version)
> 
> But after starting a wine programm f.e. putty.exe it cant get a right 
> connection to the test-host. Everytime i get the message from putty: Unable 
> to open connection to 10.10.10.10 Network error: Permission denied"
> 
> I think something is not right in my configuration or in my train of 
> thoughts.. 
> 
> I would be very happy if someone can give me a food for thought.
> 
> Greetings
> Thomas Bludau
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
