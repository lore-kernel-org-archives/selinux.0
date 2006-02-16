Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
   selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <200602161035.15321.sgrubb@redhat.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <200602160956.20357.sgrubb@redhat.com>
	 <1140103740.12655.79.camel@moss-spartans.epoch.ncsc.mil>
	 <200602161035.15321.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 10:27:58 -0600
Message-Id: <1140107279.7961.1.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 10:35 -0500, Steve Grubb wrote:
> On Thursday 16 February 2006 10:29, Stephen Smalley wrote:
> > Except for what other code should do about NULL pointers in output.  If
> > they defer it to vsnprintf, they will end up with <NULL> in the output.
> > So should Tim's code be checking for !ctx and outputting (null) there as
> > well?
> 
> Yes, I think that would be consistent will all the other audit code.
> 
> -Steve
> 

Yes.  I've already made this change.  I just saw that Darren's recent
patch submission included the API work I just did (that he suggested
yesterday)... in the process of testing now.

Thanks.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
