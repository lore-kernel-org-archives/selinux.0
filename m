MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RHEL5 console login problem - pam_selinux cannot determine newcontext
Date: Fri, 22 Jun 2007 14:03:58 +0100
Message-ID: <78202E55185C354F97E2DD052617C6460382D8E6@exchg-sl1-01.ant.amazon.com>
In-Reply-To: <1182441615.15064.327.camel@moss-spartans.epoch.ncsc.mil>
From: "Kearney, Luke" <lukek@amazon.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That's it - I updated pam, and it's no longer a problem.

Thanks for the help.

Luke 

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: 21 June 2007 17:00
To: Kearney, Luke
Cc: selinux@tycho.nsa.gov; Daniel J Walsh
Subject: Re: RHEL5 console login problem - pam_selinux cannot determine
newcontext

On Thu, 2007-06-21 at 11:01 -0400, Stephen Smalley wrote:
> On Thu, 2007-06-21 at 15:26 +0100, Luke Kearney wrote:
> > Hi there,
> >

> >  
> > I'm getting a problem when logging in on a console on a RHEL5 box, I

> > am suspecting that the problem is somewhere in pam_selinux.so
> 
> I saw the same bug in Fedora a while ago, and it was a bug in 
> pam_selinux.  Dan, is there an update for RHEL5?

Looks like this is bug 229542, and fixed in pam-0.99.6.2-3.15.el5.
Don't know about official RHEL5 update status, but there are some rpms
over at:
http://people.redhat.com/dwalsh/SELinux/RHEL5/

--
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
