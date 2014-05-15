Message-ID: <5374AE5D.5070103@tycho.nsa.gov>
Date: Thu, 15 May 2014 08:09:01 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Mladen Sekara <dev@emefes.com>
Subject: Re: Single init script for multiple daemons
References: <1400083486.3010.21.camel@vaio-emefes-com>	
 <53739A7F.6090902@tycho.nsa.gov> <1400143177.19923.37.camel@4282a12macko>
In-Reply-To: <1400143177.19923.37.camel@4282a12macko>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2014 04:39 AM, Mladen Sekara wrote:
> That makes sense, thanks.
> 
> So, I take this would be the approach:
> 
> - Create a single policy with multiple domains
> -- Create separate domains for each daemon + domain for shared resources
> -- Transition between them where needed
> 
> If the structure is:
> /opt/myapp/bin/daemon1 (daemon1_exec_t)
> /opt/myapp/bin/daemon2 (daemon2_exec_t)
> /opt/myapp/bin/start_all - (start script for both daemon1 and daemon2)
> (myapp_initrc_exec_t) 
> /opt/myapp/all_shared_resources (myapp_t)
> /etc/init.d/sym_link_to_start_all (sym link to /opt/myapp/bin/start_all)
> 
> Can I have:
> type myapp_initrc_exec_t;
> init_script_file(myapp_initrc_exec_t)
> 
> for daemon1: init_daemon_domain(daemon1_t, daemon1_exec_t)
> for daemon2: init_daemon_domain(daemon2_t, daemon2_exec_t)
> ...

I think so, but you'll likely get better advice on writing refpolicy
modules on the refpolicy mailing list,
http://oss.tresys.com/mailman/listinfo/refpolicy

That was split from the main selinux list a while back due to the high
volume of refpolicy-specific discussions and patches.
