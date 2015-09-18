Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8IDY2E5026821
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 09:34:03 -0400
Subject: Re: remove unconfined user
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
References: <CA+=dQ-_64TQHHx5GWqByLSh=X=pWiLr4FXzEWH6w6C70c4DOxA@mail.gmail.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <55FC12C6.6070801@redhat.com>
Date: Fri, 18 Sep 2015 15:33:58 +0200
MIME-Version: 1.0
In-Reply-To: <CA+=dQ-_64TQHHx5GWqByLSh=X=pWiLr4FXzEWH6w6C70c4DOxA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2015 11:00 AM, Divya Vyas wrote:
> Hi,
> 
> I am running a minimum policy  with unconfined policy
> 
> id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> This leads to my http process running to unconfined type
> 
> ps -efZ | grep http
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 2357 1  0
> 08:38 ? 00:00:00 /usr/sbin/httpd -k start
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2358 2357 
> 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2359 2357 
> 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2360 2357 
> 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2361 2357 
> 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 2458 2138  0
> 08:43 pts/0 00:00:00 grep http
> 
> I want my http process to run in confined user type so that apache.pp
> can be functional . I think it should run in httpd_exec_t type ? Am I
> correct.
> 
> I want to add some rules in apache policy.
> 
> Thanks,
> Divya
> 
> 

This is probably material for selinux@lists.fedoraproject.org. How do
you start httpd?

> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
