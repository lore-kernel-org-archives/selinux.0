Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00376
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:54:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA07201
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:53:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA07197
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:53:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: addition for xdm.te
Date: Thu, 21 Mar 2002 16:54:41 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203211031470.19336-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203211031470.19336-100000@raven>
MIME-Version: 1.0
Message-Id: <20020321155442.2550225CCC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Mar 2002 16:41, Stephen Smalley wrote:
> On Thu, 21 Mar 2002, Russell Coker wrote:
> > domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)
>
> Why?  Do some people start xdm from an rc script?  If not, then there is

Yes, I think that most people who don't use Red Hat use an rc script.

The whole thing of changing run-levels to stop and start an xdm is a Red 
Hatism (although it may be a mistake they copied from Slackware).

> no reason to provide a transition from initrc_t.  There is already a
> transition in init.te to handle xdm being started directly by init, as
> configured in /etc/inittab:
> 	domain_auto_trans(init_t, xdm_exec_t, xdm_t)
>
> We could move the above domain_auto_trans rule from init.te to xdm.te to
> provide better encapsulation of xdm_t.  In general, it is debateable
> whether it is better to place the rule in the source domain's .te file or
> the target domain's .te file.  Originally, the convention was to place the
> rule in the source domain's .te file, listing all outgoing transitions
> from a domain.  I chose to distribute the rules for big "multiplexor"
> domains among the target domain .te files in the last release to make it
> easier to add new daemons and user domains without needing to update a
> central source domain .te file each time, but the other domains still tend
> to follow the original convention.

I think it makes more sense to have all the xdm policy in the xdm file.  Then 
someone who doesn't use a xdm type program can remove the file and everything 
else will be fine.

Regarding the file contexts.  What if we had the file contexts lines in the 
.te files?  We could have them prefixed by "###" so that they don't get 
parsed as domain rules but can be easily recognised in the policy.conf.  Then 
it would be a simple matter of:
grep ^### policy.conf | cut -c 4-200 > file_contexts

Or if ### in config files is too grungy for you then put the following in the 
macro file:
define(`file_context', `###')dnl

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
