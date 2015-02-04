Message-ID: <54D207CA.20301@native-instruments.de>
Date: Wed, 04 Feb 2015 12:51:38 +0100
From: Andrew Holway <andrew.holway@native-instruments.de>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: virtualenv
References: <54CBB4CD.6060006@native-instruments.de>
 <54CBBF4A.10808@tycho.nsa.gov>
In-Reply-To: <54CBBF4A.10808@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> What's the init.d script look like for this service?  If you can prefix
> the /usr/bin/sh command with runcon -t myapp_t --, then it should also
> run in myapp_t.  But you'll then need to allow myapp_t shell_exec_t:file
> entrypoint in your policy.  Is the only domain transition into myapp_t
> from initrc_t?

Hi Stephen,

We're using Centos7 and systemd. I guess we can still throw a runcon in 
there. We used the system-config-selinux tool to generate the base 
policy module but the rules it creates are a bit opaque to me.

I think this is the interface that allows initd_t(systemd) to transition 
our app into its domain. I'm a little unsure how I should be making a 
new entrypoint.

        interface(`myapp_domtrans',`
            gen_require(`
                 type myapp_t, myapp_exec_t;
            ')
            corecmd_search_bin($1)
                 domtrans_pattern($1, myapp_exec_t, myapp_t)
        ')


# /usr/lib/systemd/system/myapp.service

[Unit]
Description=MyAPP
After=network.target

[Service]
User=myapp
Group=myapp
ExecStart=/usr/bin/sh -c 'source /var/lib/myapp/env/bin/activate && 
gunicorn --bind 0.0.0.0:8080 --debug --reload wsgi:app'
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
