Message-ID: <20050810151100.93211.qmail@web34306.mail.mud.yahoo.com>
Date: Wed, 10 Aug 2005 08:11:00 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Category Translation patch for MCS/MLS Policy
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42F9E53A.8080008@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> One thing we are
> thinking about for MCS 
> is to allow an file to be in multiple categories.

Do you mean something different from the B&L
notion of multiple categories? Bell and LePadula,
as we all know, would allow a file to be marked
with multiple categories, but the accessing
process would have to have all of the said
categories for success. 

> So a c1-c3 
> translation might look like
> 
> "MedicalRecords,MassGeneral,Cancer"
> or
> "CompanyConfidential,IBMNonDisclosure5"
> 
> So we would want files to show this, but if I do a
> ps -eZ command I 
> don't want "System High" processes to translate it.

Why's that?

> So does MLS ps command translate?

If you're asking what I think you're asking
the answer is yes.

> Or does MCS have to add the concept
> of "system high"?

Not strictly. You could enumerate all categories,
but system high is much simpler, and you can
probably steal^H^H^H^Hhare more of the MLS code
that way. You might want to come up with a name
that's less threatening, perhaps "allcats", or
"star".


Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
