From: Scott Stoller <stoller@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16322.27889.485435.758525@gargle.gargle.HOWL>
Date: Mon, 24 Nov 2003 15:41:21 -0500 (EST)
To: SELinux@tycho.nsa.gov
Subject: question about permissions for process execution
CC: stoller@cs.sunysb.edu
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

I'm a newcomer to selinux and have a question about the permissions
that control process execution.

suppose a process of type current_t wants to execute (with execve) a
file of type file_t, and that a domain transition to new_t is requested
(due to a default transition of use of execve_secure).  The first entry
in Table 4 on page 27 of

  Peter Loscocco and Stephen Smalley.
  Integrating Flexible Support for Security Policies into the Linux
  Operating System

seems to indicate that the following permissions, among others, are needed.

1. allow new_t file_t : process entrypoint;

2. allow new_t file_t : process execute; 

However, either I'm confused, or this is inconsistent with the example
policy (policy-1.2).  

Specifically, regarding item 1, policy-1.2 contains rules with "file
entrypoint" permissions but no rules with "process entrypoint"
permissions.  should Table 4  have indicated that
"allow new_t file_t : file entrypoint;" is needed instead?

Regarding item 2, policy-1.2 does not contain any allow statements with
class="process" and with "execute" in the set of permissions.  is this
permission really necessary for execve?  of course, "file execute"
permission is needed; this is listed separately in Table 4.

any clarification would be greatly appreciated.

best regards,
scott

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
