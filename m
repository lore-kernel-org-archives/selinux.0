Subject: Re: issue on confidentiality
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041022174344.38864.qmail@web51503.mail.yahoo.com>
References: <20041022174344.38864.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098467279.7614.304.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 13:47:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 13:43, Park Lee wrote:
> On Fri, 22 Oct 2004 at 12:47, Stephen Smalley wrote:
>  
> >You can actually express a MLS policy via a TE configuration; 
> >it just starts to explode the type space if you have a large number
> >of levels.
> 
> Would you please give me some hints on how to do it ?

You just define a role and a set of TE types for each MLS level, and
then define allow rules among the types that are consistent with the MLS
model.  Think of it as simply expressing the MLS model via an access
matrix.  Sorry, I don't have time to give a step-by-step tutorial, but
that should suffice to explain the idea.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
