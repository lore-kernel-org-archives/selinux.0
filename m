Subject: Re: We are attempting once again to split policy out
	into	individual RPMS.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Jeremy Katz <katzj@redhat.com>
Cc: Joshua Brindle <method@gentoo.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146584925.32102.36.camel@orodruin.boston.redhat.com>
References: <44576B91.8060607@redhat.com>  <44577454.5040204@gentoo.org>
	 <1146583000.32102.8.camel@orodruin.boston.redhat.com>
	 <44577BC5.3050009@gentoo.org>
	 <1146584925.32102.36.camel@orodruin.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 03 May 2006 11:15:06 -0400
Message-Id: <1146669307.6723.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 11:48 -0400, Jeremy Katz wrote:
> On Tue, 2006-05-02 at 11:33 -0400, Joshua Brindle wrote:
> > Jeremy Katz wrote:
> > > On Tue, 2006-05-02 at 11:01 -0400, Joshua Brindle wrote:

<snip>

>  
> > The comparison to uid/gid is bogus, uid/gid are unambiguous, file 
> > contexts are ordered by specificity because multiple regexes can match 
> > any given filename. The file_contexts *must* be combined and ordered 
> > prior to labeling, and if multiple policy packages are being installed 
> > within a set those must all be included as well. matchpathcon does not 
> > currently have the sorting mechanism that libsemanage does to properly 
> > combine policy package file contexts.
> 
> By moving the policy to being maintained by the package maintainer, it's
> moving towards having the file context be unambiguous as well.
> Otherwise, the packager really has no control.
> 

Both of these seem like positive changes, particularly having the
package maintainers take responsibility for the SELinux policy
associated with their package.

Also, how ambiguous are the application file contexts now anyway? Josh,
you are claiming that the labeling requires all of the file contexts to
be combined, but for most applications that come with policy the file
contexts are already a) specific and b) cover the majority of the files
provided by that application. The more general file contexts are most
useful for applications without policy.

Karl

-- 
Karl MacMillan
kmacmillan@tresys.com
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
