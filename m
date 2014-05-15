Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4FCngTA028351
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 08:49:42 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so1070146pbb.27
 for <selinux@tycho.nsa.gov>; Thu, 15 May 2014 05:49:42 -0700 (PDT)
Message-ID: <1400158177.2492.2.camel@vaio-emefes-com>
Subject: Re: Single init script for multiple daemons
From: Mladen Sekara <dev@emefes.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 15 May 2014 22:49:37 +1000
In-Reply-To: <5374AE5D.5070103@tycho.nsa.gov>
References: <1400083486.3010.21.camel@vaio-emefes-com>
 <53739A7F.6090902@tycho.nsa.gov> <1400143177.19923.37.camel@4282a12macko>
 <5374AE5D.5070103@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ah, apologies and thanks for your help.

-- 
Mladen Sekara <dev@emefes.com>


On Thu, 2014-05-15 at 08:09 -0400, Stephen Smalley wrote: 
> On 05/15/2014 04:39 AM, Mladen Sekara wrote:
> > That makes sense, thanks.
> > 
> > So, I take this would be the approach:
> > 
> > - Create a single policy with multiple domains
> > -- Create separate domains for each daemon + domain for shared resources
> > -- Transition between them where needed
> > 
> > If the structure is:
> > /opt/myapp/bin/daemon1 (daemon1_exec_t)
> > /opt/myapp/bin/daemon2 (daemon2_exec_t)
> > /opt/myapp/bin/start_all - (start script for both daemon1 and daemon2)
> > (myapp_initrc_exec_t) 
> > /opt/myapp/all_shared_resources (myapp_t)
> > /etc/init.d/sym_link_to_start_all (sym link to /opt/myapp/bin/start_all)
> > 
> > Can I have:
> > type myapp_initrc_exec_t;
> > init_script_file(myapp_initrc_exec_t)
> > 
> > for daemon1: init_daemon_domain(daemon1_t, daemon1_exec_t)
> > for daemon2: init_daemon_domain(daemon2_t, daemon2_exec_t)
> > ...
> 
> I think so, but you'll likely get better advice on writing refpolicy
> modules on the refpolicy mailing list,
> http://oss.tresys.com/mailman/listinfo/refpolicy
> 
> That was split from the main selinux list a while back due to the high
> volume of refpolicy-specific discussions and patches.
