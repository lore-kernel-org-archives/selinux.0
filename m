Subject: Re: fork rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Arpan Darivemula <apd005@latech.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1118002418.21085.10.camel@Raikiri.metadns.cx>
References: <1118002418.21085.10.camel@Raikiri.metadns.cx>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 09:57:29 -0400
Message-Id: <1118066249.23249.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-05 at 15:13 -0500, Arpan Darivemula wrote:
> ----fc file----
> /home/dsi/fork  --      user_u:object_r:dsifork_exec_t
> ---------------
> ----te file----
> type dsifork_exec_t, file_type, sysadmfile;
> allow user_t dsifork_exec_t:file {execute execute_no_trans read};
> neverallow dsifork_exec_t self:process{fork};
> ----------------
> Now the process forks nonetheless. The rule does not make any difference
> in stopping the fork. How can I control a fork in this ? I want to be
> able to have a line that can allow or block the fork.

1) dsifork_exec_t is the type of an executable file, not a process
domain.  You need a type dsifork_t, domain; statement to declare the
process domain and a domain_auto_trans(user_t, dsifork_exec_t,
dsifork_t) macro call to set up the transition from user_t to dsifork_t
upon executing the executable file.
2) A domain can only do what is explicitly allowed by allow rules,
nothing more.  neverallow is a compile-time assertion on the policy
(i.e. verify that there are no allow rules in the policy that give this
permission), not a runtime policy rule.

Naturally, looking at existing policy for examples is always a good
idea.  Also, see
http://selinux.sourceforge.net/resources.php3
for some documentation resources that are available.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
