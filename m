Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FEZ3Iv016593
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 10:35:03 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FEZ2bS002969
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 14:35:02 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l9FEWlCe006482
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 10:32:47 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l9FEWlbO006481
	for selinux@tycho.nsa.gov; Mon, 15 Oct 2007 10:32:47 -0400
Subject: Re: Are the reference policy abstractions the right ones?
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
	 <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>
	 <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>
	 <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>
	 <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>
	 <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>
	 <1192029823.2898.32.camel@localhost.localdomain>
	 <1192035162.15060.57.camel@moss-lions.epoch.ncsc.mil>
	 <1192048777.7524.9.camel@localhost.localdomain>
	 <1192122040.26928.61.camel@dhcp-64-223.iad.redhat.com>
	 <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 10:30:09 -0400
Message-Id: <1192458609.13779.10.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I personally like the ideas that James has put forth here. My Master's
thesis work that I finished about half a year ago was along these lines.
My system did suffer from second system syndrome because it was built on
top of the existing policy language however it might bring up some
interesting ideas. The paper can be found at
http://www.fsl.cs.sunysb.edu/project-please.html in pdf, ps, and html
formats. The relevant sections are 3, 5 and Appendix A (and B if you
want to see the language grammar). I don't necessarily know if this is
the direction we want to move in however I do believe some of the ideas
could be useful for evolution of the policy language. If people had time
to look over it and comment I would greatly appreciate it.

Dave Quigley

P.S Sorry for the double post James I forgot to hit reply all instead of
reply.

On Mon, 2007-10-15 at 12:50 +1000, James Morris wrote:
> On Thu, 11 Oct 2007, Karl MacMillan wrote:
> 
> > So - I'd like to hear from some other people. Are these ideas worth
> > pursuing? The proposals:
> > 
> > 1) remove the distinction between attributes / types.
> > 2) allow nested types / attributes.
> > 3) type_class / type_group
> > 4) exceptions
> 
> I think moving to a general OO model at a higher level is desirable, and 
> that we need to go beyond simply 'type' in #3 and look at OO classes which 
> encapsulate all SELinux-related attributes (permissions, labeling rules, 
> network policy, booleans etc).
> 
> People are increasingly utilizing containers/VMs/appliances to manage and 
> isolate their applications, and I think that this is also a means for us 
> to provide higher-level SELinux abstractions.
> 
> With comprehensive SELinux classes, we could:
> 
> - Bind security classes to various levels of system abstraction, and thus 
>   bind security objects to a variety of types of encapsulating objects 
>   (e.g. RPM, VM, container, tarball, standalone file);
> 
> - Modify classes via inheritance (already discussed somewhat);
> 
> - Define high-level interactions between classes via well-defined 
>   interfaces;
> 
> - Compose classes into higher-level classes in a structured, analyzable 
>   manner.
> 
> With the latter being an important way to allow admins to configure 
> overall security at a meaningful level of granularity, matching the level 
> of encapsulation which they are already using for managing applications.
> 
> The idea generally being that admins/developers not think in terms of low 
> level policy constructs (although allow these to be exposed if needed), 
> but rather, to think about composing security objects into e.g. a 
> container, and then from a system point of view, to be able to broadly 
> define how the containers interact with each other and the base system.
> 
> 
> Thoughts?
> 
> 
> - James

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
