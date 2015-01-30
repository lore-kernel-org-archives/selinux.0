Message-ID: <54CBBF4A.10808@tycho.nsa.gov>
Date: Fri, 30 Jan 2015 12:28:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Holway <andrew.holway@native-instruments.de>, selinux@tycho.nsa.gov
Subject: Re: virtualenv
References: <54CBB4CD.6060006@native-instruments.de>
In-Reply-To: <54CBB4CD.6060006@native-instruments.de>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/30/2015 11:43 AM, Andrew Holway wrote:
> Hello,
> 
> We're using virtualenv so we can use weird and wonderful python
> libraries. In the process of writing the SELinux policy module we have
> found that the parent process is in the initrc_t domain rather than the
> desired myapp_t domain.
> 
> It seems the virtualenv parent process is not transitioning to the
> nativeapi_t domain because the shell command "source" is not a
> standalone executable therefore we cannot set this with the
> "nativeapi_exec_t" type label. Is there a way around that would be more
> elegant than using some kind of wrapper script?
> 
> Its a bit odd to me that the parent process can be in one domain and the
> children in another.
> 
> Thanks,
> 
> Andrew
> 
>        system_u:system_r:initrc_t:s0 4086
> /usr/bin/sh -c source /var/lib/myapp/env/bin/activate && gunicorn ...
>        system_u:system_r:myapp_t:s0 4091
> \_ /var/lib/native-api/env/bin/python /var/lib/myapp/env/bin/gunicorn ...
>        system_u:system_r:myapp_t:s0 4176
> \_ /var/lib/native-api/env/bin/python
> /var/lib/native-api/env/bin/gunicorn ...

What's the init.d script look like for this service?  If you can prefix
the /usr/bin/sh command with runcon -t myapp_t --, then it should also
run in myapp_t.  But you'll then need to allow myapp_t shell_exec_t:file
entrypoint in your policy.  Is the only domain transition into myapp_t
from initrc_t?
