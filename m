Subject: Re: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109688215.10589.11.camel@moss-spartans.epoch.ncsc.mil>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <1109687748.10589.2.camel@moss-spartans.epoch.ncsc.mil>
	 <1109688215.10589.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 09:58:21 -0500
Message-Id: <1109689105.2205.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 09:43 -0500, Stephen Smalley wrote:
>On Tue, 2005-03-01 at 09:35 -0500, Stephen Smalley wrote:
>> On Tue, 2005-03-01 at 08:58 -0500, Ivan Gyurdiev wrote:
>> > I'd like to mark all role-dependent domains with a new attribute
>> > $1_domain (analogous to $1_file_type), and then do the following in
>> > base_user_macros.te:
>> > 
>> > can_ps($1, $1_domain)
>> > can_ptrace($1, $1_domain)
>> > 
>> > Objections?
>> 
>> can_ptrace?  You could easily end up allowing unintended permissions
>> directly to the user domain that were previously limited to a specific
>> program.
>
>Even can_ps() is suspect here, e.g. allowing the user domain to inspect
>the state of the program, which may be running with elevated
>permissions.  You can't apply this in general to all derived program
>domains; it has to be done on a case-by-case basis depending on whether
>the program domain is more privileged than the user domain.

Okay I see what you mean - if you're able to trace syscalls that's
dangerous as the program could have higher privileges...

Never mind then - let me think about this some more.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
