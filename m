Subject: Re: Announcement: setools version 1.1
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <ogtekuw3ocr.fsf@divan.mitre.org>
References: <1071786946.16624.37.camel@colossus.columbia.tresys.com>
	 <ogtekuw3ocr.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1072118308.24522.5.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 22 Dec 2003 13:38:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-22 at 09:43, John D. Ramsdell wrote:
> Karl MacMillan <kmacmillan@tresys.com> writes:
> 
> > - Enhanced transitive information flow analysis in Apol. The transitive
> > information flow analysis in apol has been significantly enhanced to
> > allow the filtering of object classes, object class permissions, and
> > intermediate types in queries, finding additional information flows
> > between types, and a removal of potential false positives.
> 
> How does this version of the information flow analysis address Steve's
> observation that it is a bug in the policy if someone is trying to
> separate based on the class (vs. using separate types)?
> 

Our tool accurately reflects the semantics of the policy. If someone
uses those semantics in a way that is considered a "bug" by the analyst
(or Steve) our tool will help find those bugs. That is, in fact, the
goal of our tools.

Karl

> John
> 
> Stephen Smalley <sds@epoch.ncsc.mil> writes:
> 
> > On Thu, 2003-12-11 at 15:46, Karl MacMillan wrote:
> > > Interesting. This seems like a special case to me - "implicit
> > > relationship" seems to mean that the information is flowing to that proc
> > > file outside of the control of the policy. Just to make certain that I
> > > understand, am I correct that information can only flow to proc files in
> > > this example? In other words, if there was a plain text file labeled b_t
> > > no information could flow through it from c_t to a_t without another
> > > rule:
> > > 
> > > allow b_t b_t : file write;
> > 
> > Correct.
> > 
> > > Are there any implicit relationships like this?
> > 
> > Offhand, no, although I may be forgetting something.  Sockets
> > and System V IPC objects do inherit the type of the creating
> > process by default, but there are explicit allow rules authorizing the
> > creation and subsequent access.  devpts nodes are dynamically created by
> > the kernel in response to access to /dev/ptmx, so you never see an
> > explicit allow rule for the creation, but they do require explicit allow
> > rules for accessing them.
> > 
> > > I agree that this isn't a likely situation (we have yet to see this
> > > false positive in a real policy), but one of the goals of automated
> > > tools is to detect poorly written policies. However, both of these
> > > strategies help prevent a false positive where it can appear that
> > > information flows between 2 objects without a subject, which is a likely
> > > situation.
> > 
> > I'd view it as a bug in the policy if someone is trying to separate
> > based on the class (vs. using separate types).
> > 
> > -- 
> > Stephen Smalley <sds@epoch.ncsc.mil>
> > National Security Agency
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
