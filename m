From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
Date: Tue, 12 Jun 2007 19:27:17 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil> <20070611204336.GA30846@sergelap.austin.ibm.com>
In-Reply-To: <20070611204336.GA30846@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706121927.20068.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 June 2007 06:43, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> If we decide to have this take the place of the file capabilities i
> guess we're all set, but if both are going upstream, do you think
> CONFIG_SECURITY_FILE_CAPABILITIES and selinux should be mutually
> exclusive?

This is the sort of thing that can be revised at some future time when there 
are some users for FILE_CAPABILITIES.  While there are no users for either of 
the options there seems little incentive to make them work together in the 
short term.

The potential interactions between FILE_CAPABILITIES and cap_override are not 
obvious, I can think of several options for how these things might work - 
basically determining how much SE Linux will permit FILE_CAPABILITIES to do 
what it wants.  If we are going to make them work together then before code 
is written it would probably be more effective to have some agreement on how 
it will work - which will depend on some sample implementations of both 
systems and public comment.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
