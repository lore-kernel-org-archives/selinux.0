Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LFV0dW018107
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 10:31:01 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LFSr3J029771
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 15:28:53 GMT
Date: Mon, 21 Feb 2005 15:38:52 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: Java Legacy problem
Message-ID: <20050221153852.GW14038@lkcl.net>
References: <1108910713.3610.18.camel@cobra.ivg2.net> <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net> <20050220171743.GJ14038@lkcl.net> <4219DB94.1090906@redhat.com> <1108992257.26875.0.camel@cobra.ivg2.net> <4219E93C.9040005@redhat.com> <1108995869.27158.14.camel@cobra.ivg2.net> <20050221150609.GV14038@lkcl.net> <4219FA78.9010208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4219FA78.9010208@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 21, 2005 at 10:12:56AM -0500, Daniel J Walsh wrote:

> My goal is to have a user domain and the equivalent userdomain + legacy 
> stuff.
> 
> So only applications that are marked legacy can do the execmod/execmem 
> stuff.  But have the same privs as any other userdomain
> executable.
> 
> This is one of the things that SELinux does not handle well.    

 no.  *sigh*.  it has to be explicitly spelled out.

> When a 
> user runs this app, add these privs to his existing privs.

 the solutions to this proposed so far [add these privs] have been
 ruled out on the grounds that it is exceptionally difficult to do
 the off-line policy analysis.

 ... which reminds me of another potential solution i thought of.

 you know how linux security modules are stackable, right?

 well... how about stacking policies as well?

 so you could define a list of binary policies that must be
 applied, and the order in which they must be applied, and
 whether (like PAM) they are "sufficient" or "required".


 so you could have _two_ policies, one which allowed legacy
 stuff on user_t _and_ user_java_t (yes, note carefully,
 i said _both_!), and one which allowed legacy stuff on ONLY
 user_java_t.

 the effect of having to go through both policies (which in all other
 respects would be identical) would be that, other than a performance
 hit, you'd end up with the apparent result that user_t is not
 allowed to do legacy stuff, but user_java_t is.


 i believe that the task of "combining" the policy.conf plus the
 rules for off-line auditing checking would be a lot simpler than
 previously proposed solutions.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
