Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1110829277.21378.219.camel@moss-spartans.epoch.ncsc.mil>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
	 <1110825077.21378.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1110826572.16850.33.camel@cobra.ivg2.net>
	 <1110829424.16850.39.camel@cobra.ivg2.net>
	 <1110829277.21378.219.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:00:48 -0500
Message-Id: <1110830448.16850.44.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 14:41 -0500, Stephen Smalley wrote:
> On Mon, 2005-03-14 at 14:43 -0500, Ivan Gyurdiev wrote:
> > I'm improving this macro with the purpose of using it in a lot of
> > places (couples role/trans role, provides controlling boolean - seems
> > beneficial)
> > 
> > I have a question, however - why is it that role declarations do not
> > tolerate duplicates. I've noticed allow/dontaudit rules are tolerant
> > to duplicates. 
> 
> Role declarations do "tolerate" duplicates, i.e. multiple role
> declarations may exist for the same role, in which case the union is
> taken, and redundant declarations cause no harm.  What is your question?

You're right, my mistake ...
Not sure why I was running into errors earlier.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
