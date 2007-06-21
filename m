Subject: Re: RHEL5 console login problem - pam_selinux cannot determine new
	context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kearney <lukek@amazon.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1182438094.15064.293.camel@moss-spartans.epoch.ncsc.mil>
References: <467A8A93.20807@amazon.com>
	 <1182438094.15064.293.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 12:00:15 -0400
Message-Id: <1182441615.15064.327.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-21 at 11:01 -0400, Stephen Smalley wrote:
> On Thu, 2007-06-21 at 15:26 +0100, Luke Kearney wrote:
> > Hi there,
> >                                                                                                                                                        
> >  
> > I'm getting a problem when logging in on a console on a RHEL5 box, I am 
> > suspecting that the problem is somewhere in pam_selinux.so
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
