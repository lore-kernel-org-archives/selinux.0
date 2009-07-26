Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6QLZN2N005195
	for <selinux@tycho.nsa.gov>; Sun, 26 Jul 2009 17:35:23 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6QLYx7U014680
	for <selinux@tycho.nsa.gov>; Sun, 26 Jul 2009 21:34:59 GMT
Received: by qw-out-1920.google.com with SMTP id 4so1479125qwk.30
        for <selinux@tycho.nsa.gov>; Sun, 26 Jul 2009 14:35:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <81092d890907251556p1079ada7oc09cfcc06009d49f@mail.gmail.com>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248553007.13970.3.camel@notebook2.grift.internal>
	 <81092d890907251359x4eb2914v3247c752d326e612@mail.gmail.com>
	 <1248556274.13970.11.camel@notebook2.grift.internal>
	 <81092d890907251431l534981ebva0cc7945d616175f@mail.gmail.com>
	 <1248558388.13970.21.camel@notebook2.grift.internal>
	 <81092d890907251454q100a854ck7091cc663aa312ed@mail.gmail.com>
	 <1248559521.13970.29.camel@notebook2.grift.internal>
	 <81092d890907251524l53387082h2fe2e16fab896b21@mail.gmail.com>
	 <81092d890907251556p1079ada7oc09cfcc06009d49f@mail.gmail.com>
Date: Sun, 26 Jul 2009 14:35:22 -0700
Message-ID: <47aa07810907261435l1cb53873tb0c083f60fb194f@mail.gmail.com>
Subject: Re: "Error! Unable to set executable context."
From: Larry <selinux@8martialartsforhealth.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I managed to get it working.  Thanks to Dominick for the help.

  -- Larry

On Sat, Jul 25, 2009 at 3:56 PM, Larry Ross<selinux.larry@gmail.com> wrote:
> On Sat, Jul 25, 2009 at 3:24 PM, Larry Ross <selinux.larry@gmail.com> wrote:
>>
>>
>> On Sat, Jul 25, 2009 at 3:05 PM, Dominick Grift <domg472@gmail.com> wrote:
>>>
>>> On Sat, 2009-07-25 at 14:54 -0700, Larry Ross wrote:
>>> > On Sat, Jul 25, 2009 at 2:46 PM, Dominick Grift <domg472@gmail.com>
>>> > wrote:
>>> >
>>> >         On Sat, 2009-07-25 at 14:31 -0700, Larry Ross wrote:
>>> >         > On Sat, Jul 25, 2009 at 2:11 PM, Dominick Grift
>>> >         <domg472@gmail.com>
>>> >         > wrote:
>>> >         >
>>> >         >         On Sat, 2009-07-25 at 13:59 -0700, Larry Ross wrote:
>>> >         >         > On Sat, Jul 25, 2009 at 1:16 PM, Dominick Grift
>>> >         >         <domg472@gmail.com>
>>> >         >         > wrote:
>>> >         >         > On Sat, 2009-07-25 at 12:41 -0700, Larry Ross
>>> >         wrote:
>>> >         >         > > I am trying to create a custom selinux user for
>>> >         the strict
>>> >         >         policy on
>>> >         >         > > RHEL5.3
>>> >         >         > > I want logins that are mapped to this user to be
>>> >         able to
>>> >         >         login via
>>> >         >         > > gdm, but when they do I get an error "Error!
>>> >         Unable to set
>>> >         >         > executable
>>> >         >         > > context."
>>> >         >         > >
>>> >         >         > > What does this error message mean?
>>> >         >         > >
>>> >         >         > > I am able to login via gdm with logins that are
>>> >         mapped to
>>> >         >         user_u.  I
>>> >         >         > > have run the AVCs generated when I login in
>>> >         permissive
>>> >         >         mode (which
>>> >         >         > > succeeds) through audit2allow and gotten to the
>>> >         point
>>> >         >         where it
>>> >         >         > doesn't
>>> >         >         > > seem that I am getting any killer AVCs.  What am
>>> >         I missing
>>> >         >         that is
>>> >         >         > > needed for a custom user to use X-Windows?  Is
>>> >         there some
>>> >         >         place I
>>> >         >         > can
>>> >         >         > > look to determine what is causing the error?
>>> >         >         > >
>>> >         >         > >    Thank you,
>>> >         >         > >    Larry
>>> >         >         > >
>>> >         >         > > /var/log/messages:
>>> >         >         > >  Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm
>>> >         login:
>>> >         >         unable to
>>> >         >         > > obtain default security context for appuser.
>>> >         >         > >
>>> >         >         > >
>>> >         >         > >  /var/log/audit/audit.log:
>>> >         >         > > type=USER_AUTH msg=audit(1248550033.507:1432):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14022
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > authentication acct="?" :
>>> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=failed)'
>>> >         >         > > type=USER_LOGIN msg=audit(1248550033.507:1433):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14022
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         > > msg='acct=dbapp:
>>> >         >         exe="/usr/sbin/gdm-binary" (hostname=newhost,
>>> >         >         > > addr=127.0.0.1, terminal=:0 res=failed)'
>>> >         >         > > type=USER_AUTH msg=audit(1248550043.787:1434):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14022
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > authentication acct="appuser" :
>>> >         >         > > exe="/usr/sbin/gdm-binary" (hostname=?, addr=?,
>>> >         >         terminal=:0
>>> >         >         > > res=success)'
>>> >         >         > > type=USER_ACCT msg=audit(1248550043.789:1435):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14022
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > accounting acct="appuser" :
>>> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=success)'
>>> >         >         > > type=CRED_ACQ msg=audit(1248550043.790:1436):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14022
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > setcred acct="appuser" :
>>> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=success)'
>>> >         >         > > type=LOGIN msg=audit(1248550043.796:1437): login
>>> >         pid=3003
>>> >         >         uid=0 old
>>> >         >         > > auid=14022 new auid=14020 old ses=35 new ses=36
>>> >         >         > > type=USER_START msg=audit(1248550043.804:1438):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14020
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > session open acct="appuser" :
>>> >         >         > exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=success)'
>>> >         >         > > type=USER_LOGIN msg=audit(1248550043.804:1439):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14020
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         > msg='uid=14020:
>>> >         >         > > exe="/usr/sbin/gdm-binary" (hostname=newhost,
>>> >         >         addr=127.0.0.1,
>>> >         >         > > terminal=:0 res=success)'
>>> >         >         > > type=USER_END msg=audit(1248550092.461:1440):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14020
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > session close acct="appuser" :
>>> >         >         > exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=success)'
>>> >         >         > > type=CRED_DISP msg=audit(1248550092.461:1441):
>>> >         user
>>> >         >         pid=3003 uid=0
>>> >         >         > > auid=14020
>>> >         subj=system_u:system_r:xdm_t:s0-s0:c0.c1023
>>> >         >         msg='PAM:
>>> >         >         > > setcred acct="appuser" :
>>> >         >         exe="/usr/sbin/gdm-binary" (hostname=?,
>>> >         >         > > addr=?, terminal=:0 res=success)'
>>> >         >         > >
>>> >         >         >
>>> >         >         > Dominick,
>>> >         >         >   Thank you for your reply.
>>> >         >         >
>>> >         >         >         probably means you have no default
>>> >         contexts defined
>>> >         >         for
>>> >         >         >         "appuser"
>>> >         >         >
>>> >         >         > How do I define a default context for an selinux
>>> >         user?
>>> >         >
>>> >         >
>>> >         >         Well this is how a default contexts file looks for
>>> >         the user_u
>>> >         >         selinux
>>> >         >         user in fedora (targeted policy):
>>> >         >
>>> >         >         [root@notebook2 ~]#
>>> >         >         cat /etc/selinux/targeted/contexts/users/user_u
>>> >         >         system_r:local_login_t:s0       user_r:user_t:s0
>>> >         >         system_r:remote_login_t:s0      user_r:user_t:s0
>>> >         >         system_r:sshd_t:s0              user_r:user_t:s0
>>> >         >         system_r:crond_t:s0             user_r:user_t:s0
>>> >         >         system_r:xdm_t:s0               user_r:user_t:s0
>>> >         >         user_r:user_su_t:s0             user_r:user_t:s0
>>> >         >         user_r:user_sudo_t:s0           user_r:user_t:s0
>>> >         >         system_r:initrc_su_t:s0         user_r:user_t:s0
>>> >         >         user_r:user_t:s0                user_r:user_t:s0
>>> >         >
>>> >         > That looks like the information that is
>>> >         > in /etc/selinux/strict/contexts/default_contexts:
>>> >         > system_r:sulogin_t:s0   sysadm_r:sysadm_t:s0
>>> >         > system_r:local_login_t:s0       staff_r:staff_t:s0
>>> >         user_r:user_t:s0
>>> >         > sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0
>>> >         > system_r:remote_login_t:s0      user_r:user_t:s0
>>> >         staff_r:staff_t:s0
>>> >         > system_r:sshd_t:s0              user_r:user_t:s0
>>> >         staff_r:staff_t:s0
>>> >         > sysadm_r:sysadm_t:s0
>>> >         > system_r:crond_t:s0     user_r:user_crond_t:s0
>>> >         > staff_r:staff_crond_t:s0 sysadm_r:sysadm_crond_t:s0
>>> >         > system_r:system_crond_t:s0 mailman_r:user_crond_t:s0
>>> >         > system_r:xdm_t:s0               staff_r:staff_t:s0
>>> >         user_r:user_t:s0
>>> >         > sysadm_r:sysadm_t:s0 app_user_r:app_user_t:s0
>>> >         > staff_r:staff_su_t:s0   staff_r:staff_t:s0 user_r:user_t:s0
>>> >         > sysadm_r:sysadm_t:s0
>>> >         > sysadm_r:sysadm_su_t:s0 staff_r:staff_t:s0 user_r:user_t:s0
>>> >         > sysadm_r:sysadm_t:s0
>>> >         > user_r:user_su_t:s0     staff_r:staff_t:s0 user_r:user_t:s0
>>> >         > sysadm_r:sysadm_t:s0
>>> >         > sysadm_r:sysadm_sudo_t:s0       sysadm_r:sysadm_t:s0
>>> >         > staff_r:staff_sudo_t:s0 sysadm_r:sysadm_t:s0
>>> >         staff_r:staff_t:s0
>>> >         > user_r:user_sudo_t:s0   sysadm_r:sysadm_t:s0
>>> >         user_r:user_t:s0
>>> >         >
>>> >         >
>>> >         > I added app_user contexts into that file.  It isn't well
>>> >         documented,
>>> >         > so I may have done it wrong.
>>> >
>>> >
>>> >         i would try to add something like this:
>>> >
>>> >         system_r:local_login_t:s0       app_user_r:app_user_t:s0
>>> >         system_r:remote_login_t:s0      app_user_r:app_user_t:s0
>>> >         system_r:sshd_t:s0              app_user_r:app_user_t:s0
>>> >         system_r:crond_t:s0     app_user_r:app_user_crond_t:s0
>>> >         system_r:xdm_t:s0               app_user_r:app_user_t:s0
>>> >         app_user_r:app_user_su_t:s0     app_user_r:app_user_t:s0
>>> >         app_user_r:app_user_sudo_t:s0   app_user_r:app_user_t:s0
>>> >
>>> >         maybe also:
>>> >
>>> >         app_user_r:app_user_t:s0
>>> >          app_user_r:app_user_t:s0
>>> >
>>> >         or maybe just append the second column on the rows that also
>>> >         have user_t
>>> >         above.
>>> >
>>> >         like for example:
>>> >
>>> >         system_r:local_login_t:s0       staff_r:staff_t:s0
>>> >         user_r:user_t:s0
>>> >
>>> >         app_user_r:app_user_t:s0
>>> >
>>> > I thought I had done that, but I see now I missed a few.  I appended
>>> > the app_user contexts to the rows in default_contexts and tried it
>>> > without success.  Is there something I have to do to make the new
>>> > default_contexts active?  Do I have to reboot the machine?
>>>
>>> No you should not have to do anything else afaik.
>>> Unfortunately my experience with el5 is very limited.
>>> I kind of ran out of suggestions.
>>>
>>> You might also check
>>> the /etc/pam.d/gdm, /etc/pam.d/sshd, /etc/pam.d/login to see if they
>>> have pam_selinux entries, but i do not think this is related since your
>>> user_u and other logins work
>>>
>>> Have a good look at /etc/selinux/strict, see if you can find some clues.
>>> It may also be that your app_user_t policy has errors.
>>
>>
>> That is true.  That it why I asked the original question about what this
>> error means.  What is an "executable context" that the error is referring
>> to?  It looks like it is scanning through the default_contexts looking for
>> one that it can transition to.  Could it be that there is no rule that
>> allows it to transition from its current context (which I think is xdm_t) to
>> app_user_t?  Or am I misunderstanding it?
>
>
> What is the best way to determine what needs to be allowed?
>
> If I run permissive and login as appuser, id in a console window returns:
> uid=14020(appuser) gid=14012(nm_user_g) groups=100(users),14012(app_user_g)
> context=system_u:system_r:xdm_t:SystemLow-SystemHigh
> If I run enforcing, I get the message "Error! Unable to set executable
> context." when I try to log in.
>
> Once I have determined what context is needed, how do I add it to the
> policy? I don't see any rules in the existing policy for user_u that seem
> good candidates.
>
>>
>>
>>
>>>
>>> Hopefully others can add more suggestions. Although its weekend now so
>>> may be a while.
>>
>>
>>  I realize that and thank you for your time.
>>
>> Just realized that I have been replying to you directly, I meant to leave
>> the whole discussion on the group.  Hopefully it hasn't been too mangled.
>>
>>
>>>
>>> >
>>> >
>>> >
>>> >         >
>>> >         >
>>> >
>>> >
>>> >         >         >         can you show us the output of 'semanage
>>> >         user -l |
>>> >         >         grep
>>> >         >         >         appuser'?
>>> >         >         >
>>> >         >         > [root@newhost ~]# semanage user -l | grep appuser
>>> >         >         >
>>> >         >         > returns no results, as I would expect, appuser is
>>> >         a linux
>>> >         >         login id,
>>> >         >         > not an selinux user.
>>> >         >         >
>>> >         >         > [root@newhost ~]# semanage login -l | grep appuser
>>> >         >         > appuser                   app_user_u
>>> >         s0
>>> >         >
>>> >         >
>>> >         >         semanage user -l | grep app_user_u
>>> >         >
>>> >         > [root@newhost ~]# semanage user -l | grep app_user_u
>>> >         > app_user_u       app_user    s0         s0
>>> >         > app_user_r
>>> >         >
>>> >         >
>>> >         >
>>> >         >
>>> >         >         >
>>> >         >         >
>>> >         >         >         If this user is based of off user_u you
>>> >         could
>>> >         >         simply:
>>> >         >         >
>>> >         >         >
>>> >         >
>>> >         cp /etc/selinux/contexts/users/user_u
>>> > /etc/selinux/contexts/users/appuser
>>> >         >         >
>>> >         >         >         but it depends on how your appuser
>>> >         selinux-user is
>>> >         >         configured
>>> >         >         >         ( whats
>>> >         >         >         his default domain )
>>> >         >         >
>>> >         >         > The only thing
>>> >         in /etc/selinux/strict/contexts/users/
>>> >         >         > is "root", there is no file there for user_u.
>>> >         >
>>> >         >
>>> >         >         That's weird, i would expect default contexts be
>>> >         defined since
>>> >         >         you
>>> >         >         stated that your user_u login works. Maybe it is
>>> >         stored in a
>>> >         >         different
>>> >         >         location in el5.
>>> >         >
>>> >         >         See if you can locate a file called user_u or any
>>> >         other file
>>> >         >         that may
>>> >         >         have similar entries as i pasted above in
>>> >         >         you /etc/selinux/strict/contexts (and /users).
>>> >         >
>>> >         > see above.
>>> >         >
>>> >         >
>>> >         >
>>> >         >         >
>>> >         >         >   -- Larry
>>> >         >         >
>>> >         >
>>> >
>>> >
>>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
