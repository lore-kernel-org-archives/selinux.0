Message-ID: <54D22712.5020104@tycho.nsa.gov>
Date: Wed, 04 Feb 2015 09:05:06 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Holway <andrew.holway@native-instruments.de>, selinux@tycho.nsa.gov
Subject: Re: virtualenv
References: <54CBB4CD.6060006@native-instruments.de>
 <54CBBF4A.10808@tycho.nsa.gov> <54D207CA.20301@native-instruments.de>
In-Reply-To: <54D207CA.20301@native-instruments.de>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/04/2015 06:51 AM, Andrew Holway wrote:
> 
>> What's the init.d script look like for this service?  If you can prefix
>> the /usr/bin/sh command with runcon -t myapp_t --, then it should also
>> run in myapp_t.  But you'll then need to allow myapp_t shell_exec_t:file
>> entrypoint in your policy.  Is the only domain transition into myapp_t
>> from initrc_t?
> 
> Hi Stephen,
> 
> We're using Centos7 and systemd. I guess we can still throw a runcon in
> there. We used the system-config-selinux tool to generate the base
> policy module but the rules it creates are a bit opaque to me.
> 
> I think this is the interface that allows initd_t(systemd) to transition
> our app into its domain. I'm a little unsure how I should be making a
> new entrypoint.

The refpolicy interface is domain_entry_file() in domain.if.  Add the
following to your .te file:
domain_entry_file(myapp_t, shell_exec_t)

> 
>        interface(`myapp_domtrans',`
>            gen_require(`
>                 type myapp_t, myapp_exec_t;
>            ')
>            corecmd_search_bin($1)
>                 domtrans_pattern($1, myapp_exec_t, myapp_t)
>        ')
> 
> 
> # /usr/lib/systemd/system/myapp.service
> 
> [Unit]
> Description=MyAPP
> After=network.target
> 
> [Service]
> User=myapp
> Group=myapp
> ExecStart=/usr/bin/sh -c 'source /var/lib/myapp/env/bin/activate &&
> gunicorn --bind 0.0.0.0:8080 --debug --reload wsgi:app'

Insert /usr/bin/runcon -t myapp_t -- before /usr/bin/sh above.  This
will jump into the myapp_t domain before launching the shell, so the
shell and all of its descendants will run in your domain.

> ExecReload=/bin/kill -s HUP $MAINPID
> ExecStop=/bin/kill -s TERM $MAINPID
> PrivateTmp=true
> 
> [Install]
> WantedBy=multi-user.target
