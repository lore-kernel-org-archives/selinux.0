MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: More  small fixes to policycoreutils
Date: Wed, 22 Nov 2006 14:22:59 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com>
In-Reply-To: <4564A20F.5070007@redhat.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> 
> Stephen Smalley wrote:
> > On Mon, 2006-11-20 at 16:58 -0500, Daniel J Walsh wrote:
> >   
> >>> What is pam_tally and what does the call to pam_acct_mgmt do, and 
> >>> how does it affect run_init?
> >>>
> >>>       
> >> I believe pam_tally increments a counter for failed logins in 
> >> pam_authenticate and decrements it when it gets to pam_account 
> >> management.  If it never gets there, the counter continues 
> to increment.
> >>     
> >
> > I thought I saw that pam_tally was being moved from the 
> generic system 
> > auth config to specific program configs, and was thus no longer an 
> > issue for run_init.  No?
> >
> >   
> That might be, but after talking to Nalin, he heavily 
> recommends that we use pam_acct_mgmt with a pam_permit.  He 
> says that is the recommended way, and would admins to add 
> customizations on when and how you can run the command.
> 

So what does this mean as far as the patch that you sent goes? Will you
be sending out a revised one soon?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
