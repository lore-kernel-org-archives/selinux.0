Subject: Re: Selinux checkpolicy parse error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Warner <chris@servertogo.com>
Cc: selinux@tycho.nsa.gov, cwarner@kernelcode.com
In-Reply-To: <1112098232.21770.70.camel@jasmine>
References: <1112098232.21770.70.camel@jasmine>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 12:00:16 -0500
Message-Id: <1112115616.4339.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-29 at 07:10 -0500, Christopher Warner wrote:
> I've tried
> to search the mailing list but the interface via nsa.gov is kludgy and
> ineffective for searching the archive. There seems to have been a
> resolution regarding checkpolicy but the communication between the two
> parties was private or missing from the list. Should there be a better
> interface to previous archived messaging I'd like to know.

There is an unofficial mailing list archive at
http://marc.theaimsgroup.com/?l=selinux that is much more readily
searchable.  Google can also be your friend ;) You can also grab the
list archives in raw text format via majordomo if you want.

> Here is the respective error:
> 
>  -bash-3.00# make
> /usr/bin/checkpolicy  -o policy.19 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> types/file.te:92:ERROR 'syntax error' at token ':' on line 3329:
> type shadow_t, file_type, secure_file_type;
> allow auth shadow_t: file { getattr read };
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.19] Error 1
> 
> The line from policy.conf:
> allow auth shadow_t : file { getattr read };
> 
> Syntax seems to be correct; I'm currently using flex version 2.5.4.
> Kernel version 2.6.11.5, i'm patched up with everything from cvs.

This sounds familiar, looks like the thread starting at
http://marc.theaimsgroup.com/?l=selinux&m=109338670806273&w=2
As far as I could see, it was a bug in the scanner produced by the
person's version of flex, not a bug in the checkpolicy sources.  And I
couldn't reproduce it on Fedora.

> Essentially I would just like to create a simple policy to get things
> working. I'd try to start with something simple but the way the policy
> is intertwined with context's etc would require me to basically start
> rewriting from there and I'm not sufficiently experienced enough with
> Selinux to do so yet. If there is no way to do so beyond that I am
> willing to put the required effort and time in. However, I suspect there
> is a more succinct and quicker way to get up and started.

selinux-policy-targeted from Fedora is a simpler starting point if you
want to just confine specific daemons.  
 
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
