Subject: Re: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109687748.10589.2.camel@moss-spartans.epoch.ncsc.mil>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <1109687748.10589.2.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 09:53:46 -0500
Message-Id: <1109688827.2205.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 09:35 -0500, Stephen Smalley wrote:
>On Tue, 2005-03-01 at 08:58 -0500, Ivan Gyurdiev wrote:
>> I'd like to mark all role-dependent domains with a new attribute
>> $1_domain (analogous to $1_file_type), and then do the following in
>> base_user_macros.te:
>> 
>> can_ps($1, $1_domain)
>> can_ptrace($1, $1_domain)
>> 
>> Objections?
>
>can_ptrace?  You could easily end up allowing unintended permissions
>directly to the user domain that were previously limited to a specific
>program.

Can you elaborate? I thought can_ptrace was needed for the proper
operation of the strace command.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
