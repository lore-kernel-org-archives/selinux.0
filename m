Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3U1327g007969
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 21:03:02 -0400
Received: from smtp107.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3U13172010433
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2011 01:03:02 GMT
Message-ID: <4DBB5FC2.8090201@schaufler-ca.com>
Date: Fri, 29 Apr 2011 18:02:58 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Matthew Ife <deleriux@airattack-central.com>
CC: selinux@tycho.nsa.gov
Subject: Re: xattr support in cgroupfs
References: <1304118351.23317.1.camel@home.localdomain>
In-Reply-To: <1304118351.23317.1.camel@home.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/29/2011 4:05 PM, Matthew Ife wrote:
> I was wondering what peoples' thoughts where on doing this.

It's a good idea. Make it so.


> At the moment cgroupfs does not support xattrs so no labelling of selinux
> types is permitted, but since /proc and other pseudo filesystems support
> it this should be possible.
>
> There are a number of use-cases which would benefit from this. For
> example I have recently been working with application layer integration
> of libcgroup with other services (apache being able to switch
> cgroups for vhosts for example) because cgroups offer an excellent means
> of offering resource control to prevent abuse of resources.
>
> Aa a typical example i'd like to be able to label some cgroups in
> cgroupfs as "httpd_cgroup_t" / "httpd_cgroup_task_t" so that I can
> control the access of the files it creates for administering tasks and
> altering what goes in the task list. But currently I must give httpd_t
> complete access to cgroup_t files. I can use DAC effectively enough to
> limit access but without SELinux backing me up it makes me feel somewhat
> naked.
>
> As a matter of fact, I started patching libcgroup to support labelling
> cgroupfs without realizing this facility is unsupported! So I have about
> 70% of an effective patch to do this work properly within libcgroup too.
>
> I welcome peoples' thoughts on this idea.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
