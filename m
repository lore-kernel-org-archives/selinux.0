From: "Frank Mayer" <mayerf@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: definition of domain transition permission
Date: Mon, 3 Mar 2003 16:13:54 -0500
Message-ID: <001b01c2e1c9$ceee6040$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For our policy analysis tool (apol), we're starting to look at more
abstract analyses.  One such analysis function would track and trace
transitions allowed by the policyfrom a given starting point.  That
brings up the question of what is the definition of a domain transition
(i.e., how do you recognize one in the policy).  I thought I knew the
answer, specifically the existence of 3 rules that related 3 different
types, namely:

	allow one_t two_t:process transition;
	allow one_t three_t:file execute;
	allow two_t three_t:file entrypoint;

However in talking with some colleagues who are doing policy analysis I
discovered some other notions (e.g., type_transition rules--which really
don't allow transitions just cause them to occur by default).

My question: does anyone have a different notion of how to recognize a
domain transition in the policy?  Is the above correct?  Would you like
to see some variation (i.e., recognize if transition is allowed via the
above rules, but also if they occur "automatically" via type_transition
statement).  Thanks

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
