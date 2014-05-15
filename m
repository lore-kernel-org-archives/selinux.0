Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4F8dgHQ011540
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 04:39:42 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so807395pab.1
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 01:39:43 -0700 (PDT)
Message-ID: <1400143177.19923.37.camel@4282a12macko>
Subject: Re: Single init script for multiple daemons
From: Mladen Sekara <dev@emefes.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 15 May 2014 18:39:37 +1000
In-Reply-To: <53739A7F.6090902@tycho.nsa.gov>
References: <1400083486.3010.21.camel@vaio-emefes-com>
 <53739A7F.6090902@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That makes sense, thanks.

So, I take this would be the approach:

- Create a single policy with multiple domains
-- Create separate domains for each daemon + domain for shared resources
-- Transition between them where needed

If the structure is:
/opt/myapp/bin/daemon1 (daemon1_exec_t)
/opt/myapp/bin/daemon2 (daemon2_exec_t)
/opt/myapp/bin/start_all - (start script for both daemon1 and daemon2)
(myapp_initrc_exec_t) 
/opt/myapp/all_shared_resources (myapp_t)
/etc/init.d/sym_link_to_start_all (sym link to /opt/myapp/bin/start_all)

Can I have:
type myapp_initrc_exec_t;
init_script_file(myapp_initrc_exec_t)

for daemon1: init_daemon_domain(daemon1_t, daemon1_exec_t)
for daemon2: init_daemon_domain(daemon2_t, daemon2_exec_t)
...




On Wed, 2014-05-14 at 12:31 -0400, Stephen Smalley wrote:
> On 05/14/2014 12:04 PM, Mladen Sekara wrote:
> > What would be the best approach to attack this:
> > 
> > One application, multiple components/daemons.
> > Some files are specific to a daemon, some are shared between them (eg.
> > log files are unique, some config files, keystores... are shared etc.)
> > 
> > All daemons start from a single init script and I am not allowed to
> > change it.
> > 
> > Options:
> > 
> > 1. Create policy for each component and then domain transition between
> > them (what about shared files???)
> > 2. Create a single policy for multiple daemons?
> > 
> > Any advice...
> 
> Given that there are some resources private to each daemon and the
> daemons may have different permission requirements, I'd suggest creating
> a separate domain per daemon and just defining a set of shared types for
> the shared resources.  You can define them all in a single policy
> module; there is no requirement that there only be a single domain in
> each policy module.
> 
> If you then find that some of the domains are almost identical, you can
> coalesce them.  But you likely won't know that a priori and it is easier
> to coalesce domains/types than to split them.
> 
> 
