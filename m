Subject: Re: mail_client_macros.te
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ivg2@cornell.edu, russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1119008026.12524.14.camel@moss-spartans.epoch.ncsc.mil>
References: <200506170827.59180.russell@coker.com.au>
	 <1118963954.19768.2.camel@localhost.localdomain>
	 <200506171132.07632.russell@coker.com.au>
	 <1118973361.21694.5.camel@localhost.localdomain>
	 <1119008026.12524.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 09:15:42 -0400
Message-Id: <1119014142.18294.82.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-17 at 07:33 -0400, Stephen Smalley wrote:
> On Thu, 2005-06-16 at 21:56 -0400, Ivan Gyurdiev wrote:
> > On Fri, 2005-06-17 at 11:32 +1000, Russell Coker wrote:
> > > Do you think we should change the policy to move all port type definitions to 
> > > types/network.te and have all ports labeled unconditionally?
> > 
> > I think so... at least most of them.
> 
> Concur.   I think that was discussed earlier - it lets us properly
> restrict name_bind for the well-defined ports even when that service
> isn't on the machine (without requiring the full domain for the service
> to also be present), as well to define proper policy over name_connect
> on the client side.

I agree too.  We've defined all of the ports too, in reference policy,
for the same reasons.  See corenetwork.{te,if}.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
