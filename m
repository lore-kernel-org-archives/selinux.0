From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: fedora-selinux-list Digest, Vol 7, Issue 1
Date: Tue, 7 Sep 2004 19:48:18 +1000
Cc: "Stanley A. Klein" <sklein@cpcug.org>, SELinux@tycho.nsa.gov
References: <20040901160021.BF91F742CF@hormel.redhat.com> <1094149537.2094.81.camel@p500>
In-Reply-To: <1094149537.2094.81.camel@p500>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409071948.18983.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Sep 2004 04:25, "Stanley A. Klein" <sklein@cpcug.org> wrote:
> On Wed, 2004-09-01 at 12:00, Linas Vepstas <linas@austin.ibm.com> wrote:
> > Every now and then, I look at SELinux, and I get scared away by its
> > complexity.  This complexity makes it very hard to audit, and assure
> > oneself that its actually providing any real security, as opposed to
> > the illusion of security.  During this email thread, there are
> > references to mysterious rules that neither party in the conversation
> > fully understands; this scares me.
>
> This is not the first time I've heard about SELinux complexity.  A
> colleague attended a meeting of the DC area SELinux Users Group and came
> away repeating stories about 50000 rules that needed to be defined for a
> typical system.  His reaction was "How can you be sure you have done
> 50000 rules right?".  I heard similar talk in the hallway at one of the
> EGOVOS conferences.

What about the stories of systems of 130,000 files where the permissions of 
each file matters?  How can you be sure that you have done 130,000 file 
permissions right?  :-#

A minimal Linux install has 130,000 files...

SE Linux has assertion rules to prevent you doing something really stupid.  
The rule "allow domain shadow_t:file create_file_perms;" will not be compiled 
because of the assertions.  The command "chmod 4777 /bin/foo" can be executed 
on any typical Unix system.

The SE Linux policy can be analysed with apol or slat.  These tools allow you 
to determine what access is granted from a particular domain.  To attempt to 
perform such analysis of Unix permissions you need to start with a "find /" 
operation to discover what access is granted.  On some systems "find /" is 
not feasible (I used to run a system where according to my best estimates 
"find /" would take more than 10 days to complete while hurting system 
performance enough to get the direct attention of the CEO), in which case 
analysing the Unix permissions can not be done.

You (as the administrator of a SE Linux system) do not have to write 50,000 
rules.  Many of the rules in the binary policy are expansions from simple 
rules in the policy language.  A rule such as
"allow user_t domain:dir { search getattr read };" may expand to 300 rules 
(one for each domain) in the policy binary (depending on how many domains are 
in the policy).  Then there's the macro language, if you want to allow user_t 
to see all domains in the output of "ps" then you use the macro invocation 
"can_ps(user_t, domain)" which expands to four rules in the policy.conf file 
which are then multiplied by the 300 domains to give 1200 rules in the policy 
binary (from one line of source which is easy to verify).

Also 99.99% of the policy is already there and has been well checked.  The 
amount of changes you need to make to the default policy should be rather 
small and therefore easy to check.

> I think the complexity derives from Mandatory Access Control rather than
> SELinux itself.  Thus far almost all of the attention regarding SELinux
> policies has been given to basic computer infrastructure and basic
> system administration.  Some of the packages in the basic infrastructure
> have hundreds of files.  MAC requires each file in each package to be
> considered and its access control rules defined.  The complexity in the
> rules is a consequence of the complexity in the infrastructure.

Yes.

> The real issue is the adequacy of tools to manage the complexity.

I believe that the tools to manage SE Linux policy are more adequate than the 
tools to manage Unix permissions.

> Furthermore, although SELinux has the mechanisms for defining and
> enforcing access control rules beyond the basic infrastructure, trying
> to develop policies based on business process rules and business
> considerations looks like a daunting task right now.  By this I mean
> roles that get beyond sysadmin and user into areas such as bank teller
> or hospital primary care provider or control system operations shift
> supervisor, together with the rules appropriate to those roles in their
> business contexts.

Why would you need anything special for that?  It's just a matter of having a 
SE Linux role to match the use of the system and some rules to allow access 
to the appropriate files, databases, etc which are appropriate for that role.

> I think there are people working on tool concepts, but it seems we are a
> few years away from taming the complexity of MAC and SELinux
> sufficiently to allow users to easily and confidently define SELinux
> policies for applications based on business considerations.

I agree that there is more work to be done in this area.  However people have 
been using systems based solely on Unix permissions without any such tools 
for many years.

It would be nice to have a tool to analyse access transitions via SETUID 
programs on a Unix system in the same way that slat and apol can analyse the 
SE Linux policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
