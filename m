Subject: Re: context_sensitivity_{get|set}
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061013194330.72618.qmail@web36612.mail.mud.yahoo.com>
References: <20061013194330.72618.qmail@web36612.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 16:03:52 -0400
Message-Id: <1160769832.14346.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-13 at 12:43 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> > No, usage is decidedly mixed.  "Security level" is
> > often used to mean
> > the entire label, while "sensitivity" is often used
> > to mean the
> > hierarchical component only (and this fits more with
> > the natural
> > language meaning of sensitivity).  Look around a
> > bit.
> 
> Bah. (waves paw).
> 
> > In any event, in SELinux, each context has a MLS
> > range consisting of a
> > low level and a high level (reduced to a single
> > level when they are
> > equal), and each level consists of a sensitivity
> > value and an optional
> > category set.
> 
> Then your use of the terms is inconsistant
> with historical practice and will contribute
> to the overall confusion.

>From the TCSEC glossary:
	"Security Level - The combination of a hierarchical classification and
a set of non-hierarchical categories that represents the sensitivity of
information."

>From Bell and LaPadula's Secure Computer Systems:  Unified Exposition
and Multics Interpretation:
	"A total security designation is a pair:
		(classification, set of categories).
	 Such a pair we call a "security level.""

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
