Message-Id: <200303041447.JAA18952@moss-shockers.ncsc.mil>
Date: Tue, 4 Mar 2003 09:47:42 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: definition of domain transition permission
To: SELinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> For our policy analysis tool (apol), we're starting to look at more
> abstract analyses.  One such analysis function would track and trace
> transitions allowed by the policyfrom a given starting point.  That
> brings up the question of what is the definition of a domain transition
> (i.e., how do you recognize one in the policy).  I thought I knew the
> answer, specifically the existence of 3 rules that related 3 different
> types, namely:
> 
> 	allow one_t two_t:process transition;
> 	allow one_t three_t:file execute;
> 	allow two_t three_t:file entrypoint;
> 
> However in talking with some colleagues who are doing policy analysis I
> discovered some other notions (e.g., type_transition rules--which really
> don't allow transitions just cause them to occur by default).

The allow rules are a more reliable basis for analysis, since they
completely define what is permitted on the system.  The type_transition
rules do not implicitly allow anything; they only define the default
labeling behavior when the ordinary Linux calls are used (vs. the
extended SELinux calls, where the SID is explicitly specified by the
application).  If there were a fixed set of permissions associated with
a transition, then I might consider having a type_transition rule
implicitly authorize the transition (i.e. automatically generate the
corresponding allow rules), but if you look at the domain_trans and
file_type_trans macros, you will see that one could easily argue for
fewer or more permissions for a particular transition.  The macros
merely (try to) express the common case.

On the other hand, analysis of the type_transition rules can help in
understanding the typical operation of the system.  Many of the
transitions in the system will be captured by type_transition rules,
since we seek to provide transparency to applications whenever possible
(i.e. we don't want to modify them to use the extended calls unless it
is truly justified).  But some transitions (including important ones
such as transitions from login or sshd, which have been modified to use
execve_secure) are only fully captured by the allow rules.  Hence, if
you want a graph of possible domain transitions, you need to look at
the allow rules that grant process transition permission (plus the
other allow rules that you listed if you also want to capture
information about the entrypoint program).  File type transitions
(which correspond to file creations, not relabels) need to be analyzed
based on allow rules that grant file create permission (and possibly
the other create-time checks, depending on what you want to verify,
e.g. you might want to check where new files can be placed based on
add_name permission to directories and associate permission to
filesystems).  File relabels need to be analyzed based on allow rules
that grant file relabelto and relabelfrom permissions.

As a side note, at present, there are some legacy type_transition rules
from init_t to various domains that are not allowed by any allow
rules.  These rules were to enable SELinux to retroactively determine
the proper domain for pre-existing processes if SELinux was inserted as
a standalone module rather than built-in. In that case, certain
processes were reparented to init before SELinux initialized, so
SELinux saw them as being direct children of init.  Since the (limited)
support for SELinux as a standalone module has been dropped, these
rules can be removed from the example policy.

> My question: does anyone have a different notion of how to recognize a
> domain transition in the policy?  Is the above correct?  Would you like
> to see some variation (i.e., recognize if transition is allowed via the
> above rules, but also if they occur "automatically" via type_transition
> statement).  Thanks

Yes, your latter suggestion (showing transitions based on allow rules, but
also noting whether they occur by default) seems good.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
