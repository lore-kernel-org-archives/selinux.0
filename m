Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n485r3AY021886
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 01:53:03 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n485pOet005177
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 05:51:24 GMT
Received: by qw-out-1920.google.com with SMTP id 9so886835qwj.30
        for <selinux@tycho.nsa.gov>; Thu, 07 May 2009 22:53:02 -0700 (PDT)
Date: Fri, 8 May 2009 01:56:08 -0400
From: max <maximilianbianco@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux and access(2), we want to know.
Message-ID: <20090508055607.GA3175@vertex.ga.at.cox.net>
References: <1241723924.2791.107.camel@localhost.localdomain> <20090507195729.GA21104@us.ibm.com> <1241729838.2791.127.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241729838.2791.127.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 07, 2009 at 04:57:18PM -0400, Eric Paris wrote:
> On Thu, 2009-05-07 at 14:57 -0500, Serge E. Hallyn wrote:
> > Quoting Eric Paris (eparis@redhat.com):
> > > 3) I've also heard it hinted that we could do this with audit by just
> > > having audit drop the denials that include the access(2) syscall and the
> > > scontext and tcontext for the slew of things the SELinux policy writers
> > > know we are not interested in.  And while it seems good, now we have
> > 
> > What is the difference whether an attacker does access(2) to check for
> > /etc/shadow rights, or does a failed open()?
> > 
> > Either you care that someone is poking around, or you don't.  Right?

Yes.
 
> No, sadly not true.  Sometimes people have a reason to poke....

This statement is also true. For example(true story), recently a guy claiming to be from the census bureau was poking around my folks neighborhood. One of the neighbors saw the car going up and down the road, stopping at the top of driveways, wandering down, looking around, being nosy and generally acting suspicious, so the neighbor, she gets a little nervous when the guy decides to stop in her driveway and starts moving toward the door.This is out in the country mind you, so she grabs the shotgun and opens the door before he gets there, asks him what the hell he wants,this guy sees the shotgun blurts out he is with the census bureau and hauls ass. I trust you see my point, just because he ran when he saw the shotgun doesn't mean he wasn't legit.  

Personally as a user, I would like to know if a program is misbehaving or if someone is up to no good but as a novice in software development I recognize that this is not going to be even remotely easy. Just like writing policy without understanding what the program does behind the scenes. I could just look at the audit trail to see what it wants but without looking at the code I don't know if its really legit or malicious or just poorly coded.Good admins are hard to find and ones well versed in kernel internals to boot, even harder still.

So really your skirting the issue of whether or not to add some IDS functionality to SELinux.

Now in some cases like /etc/shadow the answer will be fairly obvious, you might be allowed to look but only one program should really need to write to this place. Grub might be another, I can't think of any legitamate reason, right now, why any program other than grub or any user other than root might need to modify grub. So in the obvious cases a big flare should go up telling me that I should absolutely consult with the list or another professional before allowing this access. Skull and cross-bones, big red letters, etc....

In other cases you may have to let SELinux learn if certain behavior is acceptable, now this has its own drawbacks but if users are just going to "allow according to SETroubleshoot" anyway then I don't see that your much worse off in the end. If SELinux can learn based perhaps on the origination point of the call whether or not it should be *audited* then maybe we are getting somewhere. Of course I have no idea at this point how one might go about such a thing or if its even feasible to do so. I am working my way through the code but its going to take me some time to sort this all out.

Now as far as overhead goes, sooner or later, you are going to have to pay the piper somewhere along the line but the kernel stuff I will leave, for now, to the resident wizards. The question I have is this: Is the audit daemon as efficient as it can be? I have auditd running and rsyslog by default on this box. Why two services for what amounts to the same job? I mean from a security perspective isn't every event a potential security issue? Perhaps the whole approach to auditing needs to be revisited. 

In the end I think, at the very least, your going to have to have some sort of IDS style functionality for certain key areas so the effect of a don't audit is less potentially catastrophic. Allowing a potentially dangerous access to go unaudited even if your certain of denial is not really desirable from an auditing standpoint. I need to know if anyone is attempting to abuse the system.  

-- 
"Any fool can know. The point is to understand" --Albert Einstein

Bored??
http://fiction.wikia.com/wiki/Fuqwit1.0

http://fiction.wikia.com/wiki/Coding_the_Magic_into_the_Eight_Ball

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
