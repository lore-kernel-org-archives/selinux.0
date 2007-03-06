Subject: Re: AVC denials debug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <D043357D-5AD2-4C8E-8282-63E4045EF0F4@sf-net.com>
References: <D043357D-5AD2-4C8E-8282-63E4045EF0F4@sf-net.com>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 07:46:28 -0500
Message-Id: <1173185188.15967.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-06 at 10:33 +0100, Stefan Schulze Frielinghaus wrote:
> Hi,
> 
> often when I try to create a new policy I have to execute the program  
> a thousand times and examine the avc denials. There is one nasty  
> problem if you execute the command three times behind the other you  
> will only get avc denials for running the program the second time. I  
> believe this is the wanted behaviour of the avc chache, isn't it?
> 
> A quote from "SELinux by example":
> "The AVC chaches decisions made by the security server for subsequent  
> access checks ...."
> .....
> "The AVC is invalidated when a policy is loaded,...."
> 
> This is exactly the behaviour I recognized everytime when I loaded  
> the policy again and run the command I received "new" AVC denial.
> 
> So my question is how can I clean the AVC cache manually not only by  
> loading a new policy?

You should see every AVC denial when in enforcing mode unless you enable
the ratelimit mechanism.  The caching of security decisions from the
security server doesn't prevent auditing of the denials on a per-check
basis.  In permissive mode, the AVC will only audit the first occurrence
of a given denial and then cache that as a granted permission since a)
you only need one instance for policy generation purposes, and b) it
could otherwise easily end up flooding the audit system with identical
messages.  (At times, people have been interested in per-process or
per-domain permissive mode; might make an interesting project - at
present, the best one can do is to make a domain unconfined and add
auditallow rules to collect a record of what permissions it actually
used).

There are presently only indirect ways of flushing the AVC:
- reload policy (just run load_policy even w/o a new policy),
- switch from permissive to enforcing (setenforce 1),
- set a boolean value (setsebool <someboolean>=<somevalue>, even the
same as it is presently)

Each of these three operations will flush the AVC in order to ensure
that it remains consistent with the current policy state.  I suppose we
could add another selinuxfs node under /selinux/avc to allow manual
flushes, but since you can indirectly do it just by reloading your
existing policy or setting a boolean to the value it already has, it
isn't really necessary.

> Another question is there something out to suppress the dontaudit  
> statements? I tried to run a CGI script in the httpd_$1_script_t  
> domain type. The script is rejected with a "Internal Server Error"  
> when SELinux is enforcing. There are no avc denials created!
> So I believe there are some dontaudit statements I didn't cache. At  
> the Tresys webside there is already a bug filled (#34) which  
> addresses this issue (enableaudit). At the moment is there a dirty  
> hack or something similar which could help me to find out the rules  
> my policy still needs?

You can build policy with the 'enableaudit' target (make enableaudit) to
build a base module that has all dontaudit rules removed from it and
then install that base module; in Fedora, that base module is built and
installed as /usr/share/selinux/$SELINUXTYPE/enableaudit.pp for use by
users.  However, that only addresses the base module presently, not
non-base modules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
