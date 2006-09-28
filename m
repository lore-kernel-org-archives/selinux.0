Date: Wed, 27 Sep 2006 19:13:07 -0500
From: "George C. Wilson" <ltcgcw@us.ibm.com>
To: SELinux <SELinux@tycho.nsa.gov>, LSPP <redhat-lspp@redhat.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Irina Boverman <iboverma@redhat.com>,
        Serge Hallyn <serue@linux.ibm.com>, Trent Jaeger <tjaeger@cse.psu.edu>,
        Klaus Weidner <klaus@atsec.com>, Joe Nall <joe@nall.com>
Subject: Labeled Networking Telecon Notes
Message-ID: <20060928001306.GA12728@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Following are notes I took yesterday.  I hope they aren't too cryptic or
inaccurate to be useful.

--
George


Labeled Networking Telecon Notes -  Tuesday, September 26, 2006

Attendees:
Joshua Brindle
Darrel Goeddel
Steve Grubb
Chad Hanson
Linda Knippers
Joy Latten
Karl MacMillan
Paul Moore
Joe Nall
Eric Paris
Chris PeBenito
Casey Schaufler
Steve Smalley
Ted Toth
Dan Walsh
Klaus Weidner
George Wilson
Kris Wilson
Larry Wilson
Venkat Yekkirala
(There were additional folks on the call whose names I didn't get.)

George:  The big problem is there seems to be no overall architecture.
Joshua:  One problem is reading remote socket contexts.  Not working as expected.
Can propagate types w/Joy's patch.  But not initiator connect context on server
side.  All 4 SA entries are labeled the same.
Venkat:  That will change once initiator context patch is in.  Will use those as
SA context.
Joshua:  So we will be able to get the server context?  What about when the
context doesn't exist on the local machine.  Strict vs. targeted, for example:
types exist on one that don't on the other.  When labeling SPD entries, the must
be valid on local machine.  They are not guaranteed to exist, though.
Klaus:  A context must be valid on system using it.  You want info about the
process to use as the basis for making decisions.  That is different from how
SELinux works.
Joshua:  For CIPSO, there must be label translation.  It is the way labeled
networking traditionally works.  Need to propagate labels from non-overlapping
contexts.
Karl:  Stage in CIPSO is before it gets to SELinux.  Should be kept separate.
Need an info service, but not necessarily through SELinux.
Karl:  Policy will take care of it in vast majority of cases.  Can just alias
types.
Joshua:  That makes it hard.
Karl:  Will be doing it in policy.  Anything more is outside the scope of present
work.
Klaus:  Can we agree that the labels need to be valid on machine it is coming
from?
SDS:  SELinux only returns contexts valid on the local system.
Klaus:  Need a translation layer before it gets to SELinux.
Joshua:  Don't want invalid context; need remote context to send context to
local machine.
Karl:  Whether it deals on local or remote doesn't matter - one will be invalid
on the other.
Joshua:  Yes, translation happens in the middle.
Karl:  That is research-oriented.
Casey:  TSIX is a working example.
Karl:  When will the latest stuff with secmark doing what IPsec is doing  be
available?   Primarily translating info about endpoint - labels on packet
differentiated from label on socket.
Venkat:  SAs are not packet labels anymore; they're really socket labels
according to configured policy.  Can enforce getpeercon() semantics - shouldn't
be implied domain - can check and fail.
Karl:  Even w/IPsec, can set arbitrary contexts on packet, which may be different
from context on socket.
Venkat:  That will no longer be true very soon.  Will look for SA that matches
socket, then will call out to racoon.
Joshua:  Are you planning on changing SA initiation to do it per-domain?
Venkat:  You mean getting the domain from policy?
Joshua:  So it would be per-domain.
Venkat:  That is correct.
Karl:  Really, those are per-socket contexts, not per-domain.
Joshua:  That sounds right.
Karl:  Remaining concern is reconciliation w/secmark.  The existing secmark
implementation is confusing.  Endpoints are more intuitive.
Joshua:  So is existing method of labeling sockets wrong?
Venkat:  It's carrying the remote domain rather than socket label.
SDS:  We'll need to rework this in the reference policy.
Karl:  have httpd_t, httpd_packet_t; client would be separate.  Policy works
the same for all labeled mechanisms.
Joshua:  Secmark is more general.  You could stick any other label in there.  It
has nothing to do with a domain.
Karl:  Now it's discriminating based on data type; but could discriminate based
on endpoint - network topology.
Joshua:  How does that work?
Karl:  If you have 2 apaches and 2 domains.
Joshua:  2 clients would be using the same port -  how to differentiate?
Karl:  May not be able to w/secmark.  With IPsec they are differentiated.  Have
refinement of same model.
Joshua:  If using iptables rules to do this, how do we use the rules to
differentiate say mozilla_t from aggregator_t.
Karl:  May not be able to without knowledge of network topology.  If it does use
secpoint, they will become httpd_client_t.  If it receives and IPsec client
connection, might be able to differentiate between types.
Venkat:  Policy will have to express real remote domain.  There will be a check
whereby no random IPsec domain can set the type.
Karl:  We could use type transition rules to collapse to them all to http_obj_t
if necessary.  The rules will be similar no matter what you are doing.  It's
still endpoint- oriented.  IPsec and secmark are different ways of accomplishing
differentiation.
Joshua:  When you have rules applied to connections, you will have different obj
classes.  Policy has same thing happening, but applying to different objects.
Reconcile objects?
Venkat:  Peer-class.  Refinement will give that to you.
Joshua:  What about packet and assoc obj classes?
Venkat:  We can retain those checks.
Joshua:  Don't need to get rid of them entirely.
Venkat:  Reconciliation patch has receive compat function.
Joshua:  Since we have peer obj class, will we reconcile local peercon answers?
Will we have local peer contexts?  What about Unix domain, local sockets?  Would
we use getpeercon() for all lookups from now on?
Venkat:  Yes, origination domain should come through.
Paul:  I'm happy with this.
Joshua:  It's very good for our purposes.
Karl:  This solves a number of things - not shipping multiple policies.  Will it
be clear to secmark users that iptables rules may no longer be in effect.  1st
time we'll have overlapping label rules.
Joshua:  Won't get unexpected connection that blows away old label if policy
dictates that label must be of similar types?  Distro policy can have default
policy on where to get labels.
Karl:  Sounds like good idea.  Need to make sure object class models are clear.
Joshua:  This reconciles secmark and IPsec.  What about CIPSO?
Venkat:  Could be used with ranged SAs.  It's almost natural.
Joshua:  The level thing is fine.
But when CIPSO supports full contexts, what happens?
Venkat:  Paul would discourage using CIPSO and IPsec together.  CIPSO is for
legacy.
Paul:  2 issues - 1. What to do when just CIPSO on connection w/secmark.  About
the only reasonable think to do is take TE part of context from secmark from flow
in and concat MLS label from CIPSO connection.  Not too different from IPsec
proposal for IPsec from Venkat.
Joshua:  Need to add rules to flow through.
Paul:  Right.  Not too different from secmark-only case; just adjust label.
Casey:  That's in line with the way MLS systems traditionally used networking.
Paul:  Not that shocking.  2. What do you do if you have IPsec on commmo channel
as well.  Need some discussion on thread.
Venkat:  Would take TE portion from secmark; by that time IPsec connection
already resolved.  Already have that point to refinement.
Paul:  Point is - do we want to allow IPsec and CIPSO on same connection?
Joshua:  Use case?
Casey:  TSIX world -  1 vendor decided they wanted CIPSO and SAMP labels; CIPSO
for range checking - TSIX SAMP labels used after CIPSO's.  In general, pick one
or the other.
Paul:  That is similar to what SDS was saying:  additional check on the label.
>From my POV, it's just taking what is in secmark no matter where it came from.
Question becomes do we want to blindly throw away what is in the secmark label or 
have a check between the two - iptables throw away; IPsec throw away.
Darrel:   Should always have check - CIPSO.
Venkat:  New patch is kernel patch.
Steve Grubb:  We have a tight deadline on kernel patches.
Paul:  Will need day or 2 after IPsec patch.
Joshua:  What about racoon after Venkat's patch?
Venkat:  Expect no changes to Joy's patch as result of SA context
Eric:  If we don't have code by Friday, this mostly dead.
Venkat:  Seems like reasonable goal.  Will have a patch out tomorrow.
Paul:  As soon as we can get patch, that will help me.
Venkat:  Correct secid reconciliation is pretty close to done.  Just pieces here
and there.
Dan:  Great - not packets, endpoints.  Must write rules; or will it be taken
care of for us?  Do I have to say something in iptables?
Karl:  You will have to have iptables rules.
Dan:  How to label?
Joshua:  Would have labels applied by secmark.  Could make inet labels of
localhost take label of local socket.
Venkat:  Will be carried with local host.
Chad:  Like forwarding case - already have label.
Karl:  Iptables rules will only be used for external packets coming in?
Venkat:  Can define in secpoint as well.
Karl:  Overriding of existing label?
All sending packets will take socket context - in absence of secmark labels
you need flow out checks.
Venkat:  Once past loopback, makes no sense to override existing labels.  That
part will have to be ignored.
Dan:  Don't know if that answers question.
Karl:  Will have similar # of rules as with secmark today.
Dan:  Sigh.
Karl:  We don't have a way to get labels from the outside world other than IPsec.
Dan:  Can we write particular rules?
Chad:  There is no way to simplify writing policy, really.
Karl:  Name bind and name connect are unaffected.  Will still have node and
netif?
Steve Smalley:  Only for bind checks.
Dan:  I still see an issue with booleans.  Will we have to load a bunch of
iptables rules?  I don't know how this is going to work in practice.  This is an
improvement; userspace will require modification.
George:  Will this work be completed in time for the RHEL5 cutoff?
Steve Grubb:  Leaning towards enabling kernel pieces; will work through it.  But
leaning towards 5.1 for userspace.
Karl:  Would be new way of enabling security.
Joshua:  5.0 could ship w/o secmark.  Kernel will be the same - just userspace
mods would be required.  Wait to introduce network management until 5.1.
Dan:  Targeted policy is freeflow until users turns it on - unlabeled packets w/o
mangling rules.  We lose a lot by not getting it in.  Similar problem w/compat
mode.  Compat mode needs stuff written, too.  You would have to write your own
policy modules.
George:  So I hear us leaning towards compat mode?
Steve Grubb:  We have more time on userspace.  If somebody works through them
quickly it could happen.  I don't know who's working on it . . .
Paul:  Only 1 week difference between kernel and userspace cutoffs, I thought.
Linda:  Just joined.  Sounds like we are talking about tools to use secmark in
compat mode or not.
Geo:  We will writing policy no matter what now.
Linda:  Why?
Dan:  If you want to control, you need either secmark or IPsec rules.
Klaus:  Dealing w/MLS rules.  From a certification POV, it is not necessary to
be concerned about TE or domains to be LSPP compliant.
Karl:  Sounds like we're OK so long as compat mode is off.  MLS constraints will
still work.
Klaus:  If all packets get default labels, MLS rules should make decisions.  We
don't need to care about TE.
Karl:  We need a big boolean to allow labeled networking to work even when the
firewall is down.  Need applications to continue to work if admins want to do
that.
Klaus:  We still need a way to reject unlabeled connections.
Karl:  Goes back to discussion of needing separate SID on packets for unlabeled
vs default labels.
Klaus:  Default label would in theory be OK, so long as it is incompatible
with other labels.
Joshua:  If you bring down the firewall, that would be setting the rules to
accept; no secmark anywhere at all?
Casey:  That sounds like it would be dangerous.  Dealt with granularity of host
default label before.
Karl:  We're talking about targeted; don't know what to do for strict.  If we
put boolean and nothing matches, it will get the unlabeled SID.
???:  If the firewall goes down, we should reject everything.
Karl:  Boolean would allow unlabeled networking.  Want iptables init script
to turn that to true as the firewall goes down.  If we don't flip it in LSPP,
nothing will receive unlabeled packets.  Sounds like should have everything on
by default in RHEL5 without rules.
Dan:  LSPP only cares about MLS.  Wouldn't have to use mangle rules?
Karl:  Would have to pass unlabeled allow rule to get to MLS constraints.
Dan:  Unlabeled packets means they are all at SystemLow, unlabeled_t.  I'm not
talking about IPsec; I'm talking about packets able to flow on single machine.
Don't have to turn on TE.  Could say everything coming in on interface 1 is
unlabeled_t:secret.
Klaus:  Would ignore TE; just look at connection; can add TE later.
Karl:  "Allow unlabeled packets or any other label" would be the actual boolean.
MLS would do its normal thing.  The easiest thing is to turn everything on. 
Steve Grubb:  Dunno if maint will apply the patch if have to change significantly
between 5.0 and 5.1.
Karl:  Nothing changes in iptables.  The patches are already in head.  That's
the one that doesn't change.  How are we going to turn rules on by default is
only question.  He's already applied the patches - change "secmark" to "secpoint"
name is only issue.  Most of the IPsec stuff is there.  There's really just one
change left for that.  Most everything is in.
Steve Grubb:  Racoon patches were being compiled this AM; should be pulled over
into rawhide.
Karl:  So far as iptables work, will post when that is ready.
Venkat:  Secmark is done.  Reconciliation patches will fix case with multiple
labeling mechanisms.
Karl:  We're not depending on it for unlabeled packets.
Klaus:  Would still be using secmark rules?
Karl:  No rules for secmark.
Klaus:  If all LSPP features work w/o firewall, I suppose we don't.
George:  Need documentation for arch and setup instructions.
Klaus:  Need to know kernel, tools, versions, etc.
(Misc. chatter I didn't document.)

-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
