Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'John D. Ramsdell'" <ramsdell@mitre.org>, <russell@coker.com.au>
Cc: "'Joshua D. Guttman disp: current'" <guttman@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
Subject: RE: Announce: SELinux conditional policy extensions
Date: Fri, 20 Feb 2004 09:46:33 -0500
Message-ID: <007101c3f7c0$55f27380$020d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <ogtu11lyk7i.fsf@divan.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ramsdell@linus.mitre.org wrote:
> In my opinion, adding more complexity to the policy enforcement
> mechanism is likely to drive away new users.  Why should people be
> interested in an operating system that provides mandatory access
> control if they find its access control policy incomprehensible?
> 
> SE Linux policies are difficult to understand even with policies that
> make no use of the conditional policy extension.  Consider the
> situation surrounding information flow analysis.  Both MITRE and
> Tresys have produced tools that perform an information flow analysis.
> In a comprehensible system, it would be obvious how the two flow
> analyses relate.  I have yet to see a plausible account of the two
> flow analyses in a common framework.

All true.  We here have spent a huge amount of energy analyzing policies, and
building tools to support analysis.  But...The complexity is not because NSA
decided to make Linux more complex and then add type enforcement.  The
complexity is because Linux *is* a complex OS, with notions and mechanisms that
evolved over decades.  Any comprehensive attempt to encapsulate all access in
such a system, where the semantics of "access" is loosely defined with numerous
exceptions and special cases is bound to be complex.  The OS is complex and
there is no way around it...we're not dealing with nice security kernels here
that have simple task and segments abstractions upon which we can define clean
and simple access control constructs.

Several years ago when I first started to get involved with SE Linux I had much
the same reaction as above.  I've concluded that SE Linux is (from a security
assurance perspective) most analogous to the long ago Trusted XENIX from
IBM/TIS, where we evolved a mainstream Unix system to a B2 (middle-high?)
assurance level.  It was not easy and the Unix architecture is by no means clean
as compared to what a security kernel would contemplate.  

Nonetheless, what excites me is the economic potential of SE Linux to be
successful and widely adapted with a strong and flexible mandatory security
mechanism (TE rather than BLP or Biba).  So we all have challenge of finding
ways to analyze these policies and evolving abstractions to make the mechanisms
more accessible to developers if we want to stay in the Linux arena.   Far from
driving people away, it is my observation that SE Linux is making mandatory
security more accessible.

If one's goal is a simple, mathematically verifiable access control
architecture, then Linux is not the OS for you.  But if we're looking for widely
acceptable access control that can be rigorously informally analyzed, then I'm
pleasantly surprised with SE Linux. 

 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
