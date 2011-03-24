Subject: RE: [v0 PATCH 1/3] SELinux: Add class support to the role_trans
 structure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: eparis@redhat.com, qingtao.cao@windriver.com, jmorris@namei.org,
        eparis@parisplace.org, selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w107AB9BF9E6715B2B318ECABB60@phx.gbl>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
	 ,<1300847325-20308-2-git-send-email-qingtao.cao@windriver.com>
	 ,<1300891222.28871.6.camel@unknown001a4b0c2895>
	 <SNT139-w107AB9BF9E6715B2B318ECABB60@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Mar 2011 09:21:01 -0400
Message-ID: <1300972861.8157.26.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-03-24 at 09:43 +0000, HarryCiao wrote:
> > Why "cclass"? most of the code uses tclass (which might mean 'target
> > class' but I'm not sure)
> 
> Well, I intended to use "class" but it is a reserved GCC identifier.
> 
> The class could be the subject class, that is, the "process" class, or
> could be the newly object class, so tclass(target class) won't fit
> much here.
> 
> I will update it to "classes" which I think will be better than
> "cclass" :-)

tclass is more consistent with existing code, and it does mean "target
class", where target can be a subject or an object.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
