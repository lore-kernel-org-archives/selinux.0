Subject: Re: Non root user cannot execute semanage, semodule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, erahul29@yahoo.com,
        selinux@tycho.nsa.gov
In-Reply-To: <493F5F8E.1080303@schaufler-ca.com>
References: <829347.35568.qm@web50202.mail.re2.yahoo.com>
	 <493EDD04.4050909@redhat.com>  <493F5F8E.1080303@schaufler-ca.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 08:39:52 -0500
Message-Id: <1228916392.23307.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-12-09 at 22:19 -0800, Casey Schaufler wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Rahul Jain wrote:
> >   
> >> Hi All,
> >>  
> >> I am currently developing a Role Based Access Solution on Montavista linux using SELiunx. I started my implementaion with the reference policy from Tresys. In this implementation I had assigned a role of security officer to one of my non root Linux user. This user is resposible for maintaining SELinux related tasks such as creation, building of policy etc. But this user of mine, being a non root user is not able to execute some priviledged commands such as semodule and semanage. 
> >> Is there any in which I can permit a non root user execute these commands.
> >>  
> >> Thanks and Regards
> >> Rahul Jain
> >>
> >>
> >>       
> >>     
> > sudo
> >   
> 
> File based capabilities, too.

No - here we are running programs that do not expect to have any special
privileges beyond their caller.  And semanage is a python script.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
