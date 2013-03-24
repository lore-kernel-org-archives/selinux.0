Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2OKQjHO016782
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2013 16:26:45 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so23806bkc.7
        for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2013 13:26:43 -0700 (PDT)
Message-ID: <1364156797.3144.31.camel@d30>
Subject: Re: sudo best practices
From: Dominick Grift <dominick.grift@gmail.com>
To: Andy Ruch <adruch2002@yahoo.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Date: Sun, 24 Mar 2013 21:26:37 +0100
In-Reply-To: <1363983388.48128.YahooMailNeo@web163406.mail.gq1.yahoo.com>
References: <1363983388.48128.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-03-22 at 13:16 -0700, Andy Ruch wrote:

> Auditadm role needs the ability to mount a drive. However, I don’t want auditadm to be able to mount anything else. Therefore, I’ve created a script (mymount.sh) to mount a particular drive in a particular location. The script also does some extra stuff around the mount command for convenience and logging. The script is labeled mymount_exec_t. When executed, it will transition to mymount_t. Rules were created so that Auditadm is allowed to execute mymount_exec_t and transition appropriately to mymount_t.

Not sure why audit admin should be allowed to mount a drive but that
aside this sound reasonable to me.


> Because mounting a drive requires root permissions, sudo must be used somewhere.

Why? audit admin (like the name suggests) is already a privileged role
(e.g. only makes sense to use audit admin together with root in my view)

>  Currently, I made the script only executable by root. Auditadm then executes the script using sudo.

Audit admin should already be root in my view so no need for sudo here.

>  My reasoning for this was to allow sudo to be executed using the built-in sudo domain for auditadm (auditadm_sudo_t).

Why is that needed? Does not sound like a good idea to me.

>  Then all I had to do was allow my script domain (mymount_t) to run mount. 

Yeap

> 
> 
> Problem:
> I discovered that ‘sudo_role_template’ allows the auditadm sudo domain to execute all executables (corecmd_exec_all_executables).

It does not sound optimal to me to transition from auditadm_sudo_t to
mymount_t in the first place. Why not just auditadm_t -> mymount_exec_t
-> mymount_t. auditadm_t should already be root anyway?

Just because one is allowed to run any executable file does not mean
that he is allowed any executable files functionality, but yes it still
is not optimal probably.

> I didn’t necessarily want to grant auditadm the ability to execute any command as sudo. For example, I have other scripts that should only be executed by sysadm. At the same time, auditadm needs to be able to use sudo for day-to-day responsibilities such as ls, less, cp, etc. for working with /var/log/audit/*.

ls,less etc are generic executable files anyone should be able to run
those.

I would confine the scripts that need to be confined.

> 
> Questions:
> 1) What are the “best practices” regarding using sudo? 

I usually use sudo to run commands on behalf of other users (other with
other roles)

So for example:

A user (that also happens to require access to the auditadm_r role needs
to be able to mount a particular partition and some other stuff:


i would create a role for "mounting a particular partition and "some
other stuff". For example mytask_r role. 

Then create a new selinux user and map the auditadm_r and mytask_r role
to it. Call the selinux users myuser_u for the sake of example.

Then map the the user linux login to the myuser_u selinux user. Now you
can customise the mytask_t domain to you particular needs.

You can additionally create domain (example myscript) for your script
and allow mytask_t to domain transition to that domain via a labeled
executable file.

Then you can specify a type transtion like so:

mytask_t -> myscript_exec_t -> myscript_t

so the user logs in as for example staff_u, uid joe. Then when joe needs
to do some auditing: sudo -t auditadm_t -r auditadm_r aureport -ts
today. When joe needs to mount the partition then joe runs sudo -t
mytask_t -r mytask_r /usr/bin/myscript

so the default login context would be something like:

myuser_u:staff_r:staff_t (joe)

The auditadm context (sudo -t auditadm_t -r auditadm_r aureport -ts
today) would be like:

myuser_u:auditadm_r:auditadm_t (root)

The mytask(adm) context for running the script would be like (sudo -r
mytask_t -r mytask_r /usr/bin/myscript):

myuser_u:mytask_r:mymount_t (root)

That is if you want the user to run the script in a script domain rather
than directly in the mytask_t domain

> 
> 2) What’s the best way to allow some sudo access but restrict others?

Type transition and role based access control like the example above

> 3) In the above example, would it be better to call sudo just on the mount command? Then I would have to allow all permissions for mymount_t to run sudo.

I would probably do it the way i described above.

I written and recorded may articles/sessions about this topic. One of my
latest articles is:

http://www.netkb.info/wordpress/create-a-streaming-media-server-administrator-role/

Which does basically deal with a similar scenario. Although in that
example i did not create a role for each task (admin icecast and admin
ices) instead i combined the two tasks in a single role.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
