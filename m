Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18329
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 10:57:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22457
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:56:40 GMT
Received: from web40206.mail.yahoo.com (web40206.mail.yahoo.com [66.218.78.67])
	by jazzswing.ncsc.mil  with SMTP id OAA22453
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:56:39 GMT
Message-ID: <20020626145704.87984.qmail@web40206.mail.yahoo.com>
Date: Wed, 26 Jun 2002 07:57:04 -0700 (PDT)
From: Michael Nyika <nyix@yahoo.com>
Subject: Re: Configuration issues on a new installation
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020626145119.63606.qmail@web40007.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr Chapman, 
For the most part, YES, the files will be found in the

/policy/domains/programs directory, when system
processes have permissions problems.
Some of my dmesg avc-denied-messages contained lines
with "sysadm_t",
and the file in this case to edit was in 
/policy/domains. It was a file called admin.te
For normal users, look in the same directory for 
user.te

--- Brad Chapman <jabiru_croc@yahoo.com> wrote:
> Mr. Nyika,
> 
> --- Michael Nyika <nyix@yahoo.com> wrote:
> > Certainly sir: 
> > (Pardon me for not giving you a real concrete
> example
> > message). 
> > 
> > If your avc message contains, eg: avc denied {
> write }
> >
>
path=(something)........scontext=system_u:system_r:kernel_t
> > tcontext= (something):(something):file_t
> tclass=file 
> > 
> > then: look for a file called kernel.te in
> > /policy/domains/programs/
> >  
> > why there? because it is the kernel_t domain being
> > denied "write" permission on a "file" of type
> > "file_t". 
> > If you look at the path statement (still in the
> avc
> > denied statement), i believe you'll see the
> probable
> > file that should have that  type.
> > 
> > Now: look for a line in the kernel.te file that
> goes
> > something like this:
> > 
> > allow kernel_t file_t:file { some_entry_here };
> > 
> > If this line exists, then add "write" between the
> {}.
> > If you cant see it, then create the entry. 
> > 
> > next, make sure you run "make load" from the
> /policy
> > directory. You should see the message displayed
> > SUCCESS if you successfully updated the policy
> > configuration.
> 
>        ACK. And the same should be done for all
> programs that generate avc:
> denied messages in the dmesg? (i.e. edit files in
> policy/domain/program/*.te
> for make them)?
> 
> > 
> > ** This is just so you can see that avc will NOT
> deny
> > the permission. It doesnt mean that you should (as
> Mr
> > Smalley says, add permissions blindly. It really
> > depends on what you want as an administrator).
> 
>         ACK. I examined them and found them to be OK
> (so far), so I added them.
> 
> > 
> > If you reboot and then run "dmesg | less" and
> scroll
> > down, you shouldnt see the SAME avc message again.
> 
>         OK.
> 
> Brad
>   
> > 
> > --- Brad Chapman <jabiru_croc@yahoo.com> wrote:
> > > Mr. Nyika,
> > > 
> > > --- Michael Nyika <nyix@yahoo.com> wrote:
> > > > Good-day, 
> > > > I have found that i found the same avc denied
> > > messages
> > > > on my 2.4.18 SElinux kernel. I manually edited
> the
> > > > specific te files, just by looking at the
> messages
> > > > from dmesg. i eliminated all but two. They are
> > > realted
> > > > to the kernel_t domain and have to do with
> write
> > > > permissions mainly.
> > > 
> > >        Could you elaborate on the exact files
> you
> > > edited and how you changed
> > > them, please?
> > > 
> > > > 
> > > > 
> > > > --- Brad Chapman <jabiru_croc@yahoo.com>
> wrote:
> > > > > Everyone,
> > > > > 
> > > > >      I have just started using SELinux on my
> > > 2.4.18
> > > > > system. I found an enormous
> > > > > number of avc: denied messages in my dmesg
> and
> > > > > attempted to remove them. So far
> > > > > I have tweaked the devfs_contexts and the
> > > > > policy.conf files (using
> > > > > scripts/newrules.pl for policy.conf) since
> most
> > > of
> > > > > the errors were related to
> > > > > device files and system call commands. I
> have
> > > also
> > > > > installed the SELinux devfsd
> > > > > extension and added the config entries to my
> > > > > devfsd.conf, to no apparent avail.
> > > > > 
> > > > >      What is the fastest way to eliminate
> most
> > > (if
> > > > > not preferably all) of these
> > > > > messages and put me closer to activating
> > > enforcing
> > > > > mode?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Brad Chapman
> > > > > 
> > > > > =====
> > > > > Brad Chapman
> > > > > 
> > > > > Permanent e-mails: kakadu_croc@yahoo.com
> > > > > 		   jabiru_croc@yahoo.com
> > > > > 		   tanami_croc@devel.lbsd.net
> > > > > 
> > > > > 
> > > > > --
> > > > > You have received this message because you
> are
> > > > > subscribed to the selinux list.
> > > > > If you no longer wish to subscribe, send
> mail to
> > > > > majordomo@tycho.nsa.gov with
> > > > > the words "unsubscribe selinux" without
> quotes
> > > as
> > > > > the message.
> > > > 
> > > > --
> > > > You have received this message because you are
> > > subscribed to the selinux
> > > > list.
> > > > If you no longer wish to subscribe, send mail
> to
> > > majordomo@tycho.nsa.gov with
> > > > the words "unsubscribe selinux" without quotes
> as
> > > the message.
> > > 
> > > Brad
> > > 
> > > 
> > > =====
> > > Brad Chapman
> > > 
> > > Permanent e-mails: kakadu_croc@yahoo.com
> > > 		   jabiru_croc@yahoo.com
> > > 		   tanami_croc@devel.lbsd.net
> > > 
> > >
> __________________________________________________
> > > Do You Yahoo!?
> > > Yahoo! - Official partner of 2002 FIFA World Cup
> > > http://fifaworldcup.yahoo.com
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Yahoo! - Official partner of 2002 FIFA World Cup
> > http://fifaworldcup.yahoo.com
> 
> 
> =====
> Brad Chapman
> 
> Permanent e-mails: kakadu_croc@yahoo.com
> 		   jabiru_croc@yahoo.com
> 		   tanami_croc@devel.lbsd.net
> 
> __________________________________________________
> Do You Yahoo!?
> LAUNCH - Your Yahoo! Music Experience
> http://launch.yahoo.com


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
