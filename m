Subject: Re: Fedora/SE-PostgreSQL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: cpebenito@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <46B079EF.9050909@kaigai.gr.jp>
References: <46B079EF.9050909@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 06 Aug 2007 15:23:07 -0400
Message-Id: <1186428187.17889.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 21:17 +0900, KaiGai Kohei wrote:
> Hi,
> 
> A week ago, I submitted a review request of SE-PostgreSQL to
> the Fedora project as follows:
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522
> 
> The biggest issue is lack of definitions of new object classes
> and access vectors related to database.
> Rest of policies can be installed as a binary security policy module
> packed within the RPM package, but these definitions and MLS/MCS rules
> cannot be moduled.
> 
> The attached patch adds these definitions to the base policy.
> 
> I remember Chris said as follows at the past.
> > Is the code on a path to being merged upstream?  I'm hesitant to apply
> > class changes until the code is on a plan to be merged.
> 
> However, I would like you to consider it again.
> I believe that spread of using secure applications, like SE-PostgreSQL,
> can help promote SELinux more, and it's so worthful to make it more
> uncomplicated to maintain.
> 
> In addition, the next release of PostgreSQL with new features (8.4) is
> planed at the autumn 2008. It means that any SE-PostgreSQL users have to
> replace the default selinux-policy package by the modified one for a year
> and more, at least. I think it's a senseless work.
> 
> It may be a time the definitions of object classes related to database are
> integrated into the base security policy.

Likely a good idea as well to ensure that it does not collide with the X
object class rework.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
