Subject: Re: Multiple contexts
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 16:08:39 -0700
Message-Id: <1105571319.11828.19.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 16:47 -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 15:11, Ivan Gyurdiev wrote:
> > Please explain this some more - Luke also seems confused about this
> > (unless I misunderstand). I don't understand how the change from one
> > context to multiple contexts stored per file translates into policy
> > being encoded in the file attributes.
> > 
> > It seems to me that this change would simply allow more accurate
> > association of the files with the proper security data.
> > 
> > It is still a centralized policy which decides whether to allow an
> > action or not - it just takes into consideration multiple contexts.
> > I am merely suggesting that when a security decision is necessary for
> > a file, all the contexts it is labeled with are provided by the
> > filesystem, and the security server makes a decision based on 
> > whether an access path (not sure of terminology here) exists
> > between the subject context and any object context.
> 
> If we followed that approach, then we wouldn't be able to tell whether
> information can flow from type A to type B without analyzing the
> filesystem state to see what files had multiple contexts and collapsing
> each such combination into a single security equivalence class (type).

What about a tool that creates a hybrid type on demand, and stores that
information in the policy?

createcon samba_httpd_content_t --inherit 
	samba_share_t httpd_sys_content_t
chcon -R samba_httpd_content_t ~/webserver

There has to be an easier way to do this than changing the original
policy file. The original policy file is hard to understand, and should
be left alone.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
