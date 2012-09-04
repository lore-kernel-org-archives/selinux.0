Message-ID: <1346767354.30701.35.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: An MCS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Tue, 04 Sep 2012 10:02:34 -0400
In-Reply-To: <20120903175904.GA25491@telmora.telvanni>
References: <20120903175904.GA25491@telmora.telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-09-03 at 19:59 +0200, Ole Kliemann wrote:
> Part of the project I'm working on is an MCS policy that I want 
> to describe and (hopefully) proof correct in this posting.
> 
> I do not expect anyone to read this through, but if maybe someone 
> is interested in stuff like this, I'd really appreciate any quick 
> look over it.
> 
> 
> 
> These are the specifications I want my policy to meet:
> 
> I want a user to have 100 compartments, each one totally
> separated from every other. The user (called main user) has full 
> access over every compartment. For each compartment C there shall 
> be 9 subcompartments of C each one totally separated from every 
> other subcompartment or compartment, but accessible from C. 
> 
> No compartment or subcompartment shall have the possibility to 
> access or leak data "horizontally", i.e. to any other compartment 
> or subcompartment that is not of his own.
> 
> Neither shall any compartment or subcompartment be able to access 
> "upwards", i.e. from a subcompartment to its compartment or from 
> a compartment to the main user.
> 
> The only allowed data flow is reading, writing and transitioning 
> from the main user to the compartments and from every compartment 
> to its subcompartments. (Set aside practical exceptions like 
> sigchild, fd use, some X11 stuff that needs to be shared among 
> all compartments etc.)
> 
> 
> My Implementation:
> 
> I have a user user_u with range s0 - s0:c0.c999 starting off as 
> main_t:s0. 
> 
> main_t is not mcs constrained. main_t can transition to sub_t 
> which is mcs constrained and has no access to main_t.
> 
> I call a range of s0:c(N*10).c((N*10)+9), 0<=N<=99, a compartment 
> with id N. E.g. compartment 01 with range s0:c10.c19. 
> 
> I call s0:cI, (N*10) < I <= ((N*10)+9), a subcompartment of N 
> with id I. E.g. subcompartment 5 of compartment 01 with range 
> s0:c15.
> 
> A process of compartment N is run as:
> 
> 	sub_t:s0:c(N*10) - s0:c(N*10).c((N*10)+9)
> 
> A process of subcompartment I of N as:
> 	
> 	sub_t:s0:c((N*10)+I)
> 
> The mlsconstrain (in princip, set aside practical exceptions) is:
> 
> 01:		( t1 != is_mcsconstrained )
> 02:	or	( t2 != is_mcsconstrained )

Not sure if you are using TE to prevent this, but one possible concern
with using the same invariant for source (t1) and target (t2) is with
respect to process ptrace, transition, and dyntransition permissions.
You want to ensure that a MCS constrained process cannot ptrace or
transition to a MCS-unconstrained domain.

> 03:	or	(	
> 04:				( l1 domby h1 ) 
> 05:			and	( l2 domby h2 ) 

The kernel (mls_context_isvalid() in security/selinux/ss/mls.c)
guarantees these invariants for all security contexts.cd 

> 06:			and	( h1 dom h2 ) 
> 07:			and ( h1 dom l2 ) 

Redundant.

> 08:			and ( l1 domby l2 ) 
> 09:		)
> 	
> 
> Proof:
> 
> It is sufficient to proof this for any compartment, say 
> s0:c10.c19. As there is only one sensitivity, the relation of 
> dominance is that of inclusion of category sets. Set inclusion 
> shall be denoted by < > = <= >=.
> 
> 04 and 05 are just to prevent any "weird" contexts. (I'm pretty 
> sure the kernel already enforces those and gives 'invalid 
> context' if low range > high range. But definite specifications 
> are hard to find, so I put them in to be sure.)
> 
> It needs to be shown that a process running as
> 
> 	s0:c10 - s0:c10.c19
> 
> can not access any categories -- directly or through transition 
> -- other than c10.c19.
> 
> For files created or processes transitioned to it holds true that 
> low range as well as high range can only be a subset of c10.c19.  
> This is ensured by 06 and 07. So the process can neither access 
> nor leak data to either the compartments numerically below hin 
> (s0:c0.c9) or above him (s0:c20.c29, ...). 
> 
> But note that the empty set is also subset of c10.c19. So the 
> process would be able to jeopardise his own integrity by 
> transitioning to or leaking data to s0 -- which in turn would 
> then be accessible form any other compartment.
> 
> So the source low range must always be a subset of the target low 
> range. This is ensured by 08.
> 
> For a subcompartment, say s0:c15, it holds true that the process 
> 
> 	s0:c10 - s0:c10.c19
> 
> can transition to, give and write files to etc. as c15 > c10 and 
> c15 < c10.c19.
> 
> For any subcompartment it is obvious from the above that it 
> cannot access or transition to anything else than itself.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
