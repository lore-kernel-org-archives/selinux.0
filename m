Subject: Re: Data type changed?
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1062591879.18568.315.camel@moss-spartans.epoch.ncsc.mil>
References: <200309031100.47270.yanjunwu@sonata.iscas.ac.cn>
	 <1062591879.18568.315.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1062603445.27795.6.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 03 Sep 2003 11:37:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-03 at 08:24, Stephen Smalley wrote:
> On Tue, 2003-09-02 at 23:00, Wu Yanjun wrote:
> > In Linux-2.6.0-test4, I see selinux changed the type of basic data structures 
> > significantly.  eg. turn security_id_t, access_vector_t, security_class_t, 
> > etc. back to their protoypes.Could any one tell me what's the reason? and 
> > will these changes be permanent?
> 
> typedefs are considered harmful by the kernel developers, and the change
> is permanent.

Will the typedefs be removed from the userspace tools (like checkpolicy)
as well?

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
