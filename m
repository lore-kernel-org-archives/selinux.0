Subject: Re: user_trans/user_trans_boolean macro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110829424.16850.39.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
	 <1110825077.21378.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1110826572.16850.33.camel@cobra.ivg2.net>
	 <1110829424.16850.39.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 14:41:17 -0500
Message-Id: <1110829277.21378.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 14:43 -0500, Ivan Gyurdiev wrote:
> I'm improving this macro with the purpose of using it in a lot of
> places (couples role/trans role, provides controlling boolean - seems
> beneficial)
> 
> I have a question, however - why is it that role declarations do not
> tolerate duplicates. I've noticed allow/dontaudit rules are tolerant
> to duplicates. 

Role declarations do "tolerate" duplicates, i.e. multiple role
declarations may exist for the same role, in which case the union is
taken, and redundant declarations cause no harm.  What is your question?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
