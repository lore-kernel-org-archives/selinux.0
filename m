Subject: Re: plicycoreutils: genhomedircon man page
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <873bwwtus9.fsf@glaurung.internal.golden-gryphon.com>
References: <873bwwtus9.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1106251502.26753.217.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 15:05:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-20 at 02:38, Manoj Srivastava wrote:
>         Here is the man page for the other script without a man page
>  in policycoreutils. 

Thanks.  Two suggested changes:
- Update both the script comment and the man page to use 500 rather than
100 for the default STARTING_UID, as that is what the code uses
presently (in the absence of a UID_MIN definition in /etc/login.defs),
- Start with an abstract description of the purpose, e.g. this script is
to generate file context configuration entries for user home directories
based on their default roles and is run when building the policy.

________________________________________________________________________
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
