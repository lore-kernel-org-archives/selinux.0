Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3BIU69U009495
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 14:30:46 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so1900763lbi.14
        for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 11:29:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365695580.32085.YahooMailNeo@web163401.mail.gq1.yahoo.com>
References: <1365695580.32085.YahooMailNeo@web163401.mail.gq1.yahoo.com>
Date: Thu, 11 Apr 2013 14:29:48 -0400
Message-ID: <CACLa4psgJPQKHTjLSO2fiOBDtcyN1pZ-vN20mt2G8OQx5CBwEA@mail.gmail.com>
Subject: Re: sysadm restarting services
From: Eric Paris <eparis@parisplace.org>
To: Andy Ruch <adruch2002@yahoo.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I typically used run_init and add pam_rootok to the run_init pam stack
so I'm not constantly retyping the root password.

(long term, aka RHEL7, the answer is that systemd does the work on
your behalf, so you don't have to worry about things like this any
more)

On Thu, Apr 11, 2013 at 11:53 AM, Andy Ruch <adruch2002@yahoo.com> wrote:
> Hello,
>
> I trying to grant sysadm permissions to restart a service. The service needs
> to run as it's own type, preferably using system_r role. I'm running Red Hat
> 6.3 with a custom policy based on the reference policy.
>
> From the research I've done so far, it appears that I can use 'run_init' or
> enable the 'direct_sysadm_daemon' flag when I compile the policy. However,
> using the 'direct_sysadm_daemon' flag doesn't seem to allow sysadm to
> restart the service. Instead, it seems to allow sysadm access to execute the
> program the service is pointing to since the daemon attribute is being added
> in the 'init_daemon_domain' template call. I need sysadm to make the call
> through the service script since the service has some additional logic for
> launching the executable.
>
> My module types are as follows (I modeled this after other services like
> ntp, dhcp, etc.) :
>
> # Service: /etc/init.d/myprog
> type myprog_initrc_exec_t;
> init_script_file( myprog_initrc_exec_t )
>
> # Main Program: /usr/sbin/myprog
> type myprog_t;
> type myprog_exec_t;
> init_daemon_domain( myprog_t, myprog_exec_t )
>
>
>
> What is the best/recommended way for sysadm to restart services (run_init
> vs. direct)?
>
>
>
> Thanks,
> Andy Ruch

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
