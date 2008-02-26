From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: I have begun merging XWindows Controls into Rawhide.
Date: Tue, 26 Feb 2008 20:26:13 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <47C2CBA1.5040807@redhat.com> <1203957368.32061.74.camel@gorn> <47C32259.10505@tycho.nsa.gov>
In-Reply-To: <47C32259.10505@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802262026.15197.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 26 February 2008 07:17, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> I would be fine with only having one type for the X server; this would
> certainly simplify the policy that currently has all kinds of kludgery
> to support both "xdm_" and "$1_".

With an X server being a trusted object manager the benefit of having separate 
instances of the X server for various roles is greatly reduced.  Not that it 
ever was a great benefit given the small number of people who used it.

In retrospect it should have been removed some time ago.

> > This comes back to forthcoming effort for trying to use RBAC for role
> > separation.  That would eliminate the structural complexity we see due
> > to using TE for the role separation
>
> Is work being done on this?  I recall you said you were interested in
> taking on this task.

Is this going to involve using roles on filesystem objects?  If not then how 
would you distinguish the files created by different roles?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
