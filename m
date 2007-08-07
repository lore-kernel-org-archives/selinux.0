Subject: Re: policygentool error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90708070734v508adaffy420506b3b1fbbecd@mail.gmail.com>
References: <9f066ee90708070734v508adaffy420506b3b1fbbecd@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 15:29:32 -0400
Message-Id: <1186514972.26457.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-07 at 10:34 -0400, Mark wrote:
> I am just starting out with generating modules, so forgive me if I am
> way off course here.  I wrote a simple TCP server application and
> would like to run the app in its own domain, just so that I can start
> learning SE Linux policy generation.  I stumbled across the tool
> "policygentool" after reading the tresys web page.  So I gave it a try
> with my simple program: 
> 
> [root@localhost]# policygentool mwserver /usr/bin/mwserver
> 
> 
> This tool generate three files for policy development, A Type
> Enforcement (te)
> file, a File Context (fc), and a Interface File(if).  Most of the
> policy rules 
> will be written in the te file.  Use the File Context file to
> associate file
> paths with security context.  Use the interface rules to allow other
> protected
> domains to interact with the newly defined domains.
> 
> After generating these files use the /usr/share/selinux/devel/Makefile
> to
> compile your policy package.  Then use the semodule tool to load it.
> 
> # /usr/share/selinux/devel/policygentool myapp /usr/bin/myapp
> # make -f /usr/share/selinux/devel/Makefile
> # semodule -l myapp.pp
> # restorecon -R -v /usr/bin/myapp "all files defined in myapp.fc"
> 
> Now you can turn on permissive mode, start your application and avc
> messages 
> will be generated.  You can use audit2allow to help translate the avc
> messages
> into policy.
> 
> # setenforce 0
> # service myapp start
> # audit2allow -R -i /var/log/audit/audit.log
> 
> Return to continue:
> 
> If the module uses pidfiles, what is the pidfile called?
> n
> If the module uses logfiles, where are they stored?
> n
> If the module has var/lib files, where are they stored?
> n
> Does the module have a init script? [yN] 
> n
> Does the module use the network? [yN]
> y
> [root@localhost mwserver]# make -f /usr/share/selinux/devel/Makefile
> backup/mwserver.if:38: Error: duplicate definition of
> mwserver_domtrans(). Original definition on 23. 
> Compiling seedit mwserver module
> /usr/bin/checkmodule:  loading policy configuration from
> tmp/mwserver.tmp
> /usr/bin/checkmodule:  policy configuration loaded
> /usr/bin/checkmodule:  writing binary representation (version 6) to
> tmp/mwserver.mod 
> Creating seedit mwserver.pp policy package
> rm tmp/mwserver.mod.fc tmp/mwserver.mod
> [root@localhost mwserver]# ls
> backup  mwserver.fc  mwserver.if  mwserver.pp  mwserver.te  tmp
> typescript
> [root@localhost mwserver]# semodule -i mwserver.pp
> libsepol.permission_copy_callback: Module mwserver depends on
> permission flow_out in class packet, not satisfied
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!

policygentool and selinux-policy-devel are for people using reference
polcy, not seedit's simplified policy.  The two don't mix.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
