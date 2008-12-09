Subject: Re: Non root user cannot execute semanage, semodule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: erahul29@yahoo.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <829347.35568.qm@web50202.mail.re2.yahoo.com>
References: <829347.35568.qm@web50202.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 13:14:25 -0500
Message-Id: <1228846465.8371.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-12-09 at 09:52 -0800, Rahul Jain wrote:
> Hi All,
>  
> I am currently developing a Role Based Access Solution on Montavista
> linux using SELiunx. I started my implementaion with the reference
> policy from Tresys. In this implementation I had assigned a role of
> security officer to one of my non root Linux user. This user is
> resposible for maintaining SELinux related tasks such as creation,
> building of policy etc. But this user of mine, being a non root user
> is not able to execute some priviledged commands such as semodule and
> semanage. 
> Is there any in which I can permit a non root user execute these
> commands.
>  
> Thanks and Regards
> Rahul Jain

Not directly, no.  SELinux only further restricts what can be done; it
does not completely override the normal Linux checks.

You could invoke semodule/semanage via sudo in order to enable a
non-root user to use them, with suitable policy configuration and
sudoers configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
