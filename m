Subject: Re: fedora-selinux-list Digest, Vol 7, Issue 1
From: "Stanley A. Klein" <sklein@cpcug.org>
To: fedora-selinux-list@redhat.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040901160021.BF91F742CF@hormel.redhat.com>
References: <20040901160021.BF91F742CF@hormel.redhat.com>
Content-Type: text/plain
Message-Id: <1094149537.2094.81.camel@p500>
Mime-Version: 1.0
Date: 02 Sep 2004 14:25:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 12:00, Linas Vepstas <linas@austin.ibm.com> wrote:

> 
> Every now and then, I look at SELinux, and I get scared away by its
> complexity.  This complexity makes it very hard to audit, and assure
> oneself that its actually providing any real security, as opposed to
> the illusion of security.  During this email thread, there are 
> references to mysterious rules that neither party in the conversation 
> fully understands; this scares me. 
> 


This is not the first time I've heard about SELinux complexity.  A
colleague attended a meeting of the DC area SELinux Users Group and came
away repeating stories about 50000 rules that needed to be defined for a
typical system.  His reaction was "How can you be sure you have done
50000 rules right?".  I heard similar talk in the hallway at one of the
EGOVOS conferences.

I think the complexity derives from Mandatory Access Control rather than
SELinux itself.  Thus far almost all of the attention regarding SELinux
policies has been given to basic computer infrastructure and basic
system administration.  Some of the packages in the basic infrastructure
have hundreds of files.  MAC requires each file in each package to be
considered and its access control rules defined.  The complexity in the
rules is a consequence of the complexity in the infrastructure.

The real issue is the adequacy of tools to manage the complexity. 

Furthermore, although SELinux has the mechanisms for defining and
enforcing access control rules beyond the basic infrastructure, trying
to develop policies based on business process rules and business
considerations looks like a daunting task right now.  By this I mean
roles that get beyond sysadmin and user into areas such as bank teller
or hospital primary care provider or control system operations shift
supervisor, together with the rules appropriate to those roles in their
business contexts.

I think there are people working on tool concepts, but it seems we are a
few years away from taming the complexity of MAC and SELinux
sufficiently to allow users to easily and confidently define SELinux
policies for applications based on business considerations.


Stan Klein

-- 

Stanley A. Klein, D.Sc.
Principal Consultant
Stan Klein Associates, LLC
301-881-4087


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
