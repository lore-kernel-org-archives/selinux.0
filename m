Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5SMA9ad003392
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 18:10:09 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5SMA7kP026877
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 22:10:07 GMT
Received: by wwf22 with SMTP id 22so552933wwf.30
        for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 15:10:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201106282329.06313.russell@coker.com.au>
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
	<4E08B41F.80608@trentalancia.com>
	<BANLkTimY8OOEzZjfA=z=vfY_p3+XN3N8EQ@mail.gmail.com>
	<201106282329.06313.russell@coker.com.au>
Date: Tue, 28 Jun 2011 15:06:08 -0700
Message-ID: <BANLkTimq6daGvg5kCbDy32y7RQ0fb4hLPA@mail.gmail.com>
Subject: Re: login process unable to execute /bin/sh
From: Sam Gandhi <samgandhi9@gmail.com>
To: russell@coker.com.au
Cc: Guido Trentalancia <guido@trentalancia.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russell,

On Tue, Jun 28, 2011 at 6:29 AM, Russell Coker <russell@coker.com.au> wrote:
> On Tue, 28 Jun 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
>> > Perhaps, you should try adding the other rule ?
>> >
>> > allow initrc_t local_login_t:process transition;
>
> Why would that be desirable?  /bin/login is generally run from getty which is
> run from init.  Do we have a need for scripts under /etc/init.d/ to run
> /bin/login?

I have fixed this. Now getty runs in getty_t and login is in local_login_t

  611 system_u:system_r:getty_t          S    /bin/busybox /sbin/getty
-L 115200
  594 system_u:system_r:local_login_t  S    login -- root

>
>> Jan  1 10:00:37 192.168.137.1 kernel: type=1400 audit(37.230:44): avc:
>>  granted  { transition } for  pid=600 comm="getty" path="/bin/login"
>> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
>> tcontext=system_u:system_r:local_login_t tclass=process
>>
>> Am I wrong in assuming that getty is not an issue because audit
>> message indicates that when getty executed program /bin/login , domain
>> transition was done successfully to local_login_t
>
> Why is getty running in initrc_t?  What label is on the getty executable and
> what is the context of the program that runs it?
>
>> Jan  1 10:00:39 192.168.137.1 kernel: type=1400 audit(39.090:45): avc:
>>  denied  { transition } for  pid=812 comm="login" path="/bin/sh"
>> dev=ubifs ino=93 scontext=system_u:system_r:local_login_t
>> tcontext=root:system_r:initrc_t tclass=process
>>
>> One more piece of information I didn't include in previous email was,
>> /bin/sh is labeled as shell_exec_t and I do see following rules in my
>> policy.conf.
>
> /bin/sh is usually a symlink (labelled as bin_t) and points to something else
> matching /bin/*sh - which should have shell_exec_t as the type.  Not that it
> matters in a normal situation.

In my situation I am using busybox that is compiled with option
CONFIG_INSTALL_APPLET_SCRIPT_WRAPPERS=y.
hence /bin/sh  is not a link, but really a script that contains  following line

#!/bin/busybox

We decided to use option of CONFIG_INSTALL_APPLET_SCRIPT_WRAPPERS as
it will allow us to label busybox executables and may not require
approach you have suggested in your paper
http://doc.coker.com.au/papers/porting-se-linux-hand-held-devices/

>
>> type_transition initrc_t shell_exec_t:process initrc_t;
>
> That looks wrong.
>
>> allow initrc_t shell_exec_t:file { read { getattr execute } Ballow
>> initrc_t shell_exec_t:file { read getattr lock execute ioctl };
>> allow initrc_t shell_exec_t:file entrypoint;
>>
>> allow local_login_t shell_exec_t:file { read { getattr execute } };
>> type_transition local_login_t shell_exec_t:process initrc_t;
>> allow local_login_t shell_exec_t:file { read { getattr execute } };
>> allow local_login_t shell_exec_t:file { { read getattr lock execute
>> ioctl } execute_no_trans };
>> allow local_login_t shell_exec_t:file entrypoint;
>>
>> The best as I understand allow rules, the local_login_t rules above
>> says, when process running in context local_login_t (login program in
>> my case) tries to execute program of type shell_exec_t it should be
>> allowed, and process should transition to context initrc_t (because of
>> type_transition statement above).
>>
>> Still puzzled as to why I keep getting local_login deny message
>> (help!). I am running the system with  'auditallow domain
>> domain:process transition;'  and I don't see any other domain
>> transitions happening when I try to login to my system.
>
> You shouldn't have a login session with the domain initrc_t.  You should have
> the login program tell the kernel which context to use and it should be
> something with a different domain.  Either the login program should be patched
> or you should use PAM with pam_selinux.so configured.
>

I am using the latest pam_selinux for login and my pam.d/login looks like this:

session required pam_selinux.so close debug verbose
session required pam_selinux.so open nottys debug verbose
auth            sufficient      pam_unix.so shadow audit use_authtok
auth           required        pam_deny.so
account         required        pam_unix.so shadow audit use_authtok

In spite all of this I was still getting that AVC deny message from login_t

type=1400 audit(39.090:45): avc: denied  { transition } for  pid=812
comm="login" path="/bin/sh" dev=ubifs ino=93
scontext=system_u:system_r:local_login_t
tcontext=root:system_r:initrc_t tclass=process

The problem turned out to be the constraints and I have fixed the
problem by having following in my constraints file (originally I
didn't have t1 == can_change_process_identity )

Now my process transition constrains look like this:

constrain process transition
        ( u1 == u2 or t1 == privuser or t1 == can_change_process_identity );
constrain process transition
        ( r1 == r2 or t1 == privrole );
constrain process dyntransition
        ( u1 == u2 and r1 == r2);

And I have set attribute can_change_process_identity on local_login_t

typeattribute local_login_t can_change_process_identity;

Now when users login things are transitioning properly, but this kind
of sounds bit hack-ish? But I looked at monolithic policy that is
generated as part of  "reference policy" and it seems to set lot of
other flags on login_t so I suppose its right thing to do?

-Sam


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
