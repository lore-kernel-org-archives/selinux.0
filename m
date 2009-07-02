Subject: Re: request for review of, and collaboration on SELinux models
 wiki entry
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <domg472@gmail.com>
Cc: Sebastian Pfaff <sebastian.pfaff@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1246549788.26320.42.camel@notebook2.grift.internal>
References: <1246542053.26320.15.camel@notebook2.grift.internal>
	 <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
	 <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com>
	 <1246549788.26320.42.camel@notebook2.grift.internal>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 13:03:12 -0400
Message-Id: <1246554192.13464.350.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 17:49 +0200, Dominick Grift wrote:
> On Thu, 2009-07-02 at 17:25 +0200, Sebastian Pfaff wrote:
> > hello,
> > 
> > from http://selinuxproject.org/page/SELinux_models (Multi Category  
> > Security):
> > 
> > [...] Multi Category Security and Multi Level Security are mutually  
> > exclusive.
> > 
> > > - MCS and MLS are just particular configurations of constraints for  
> > > the
> > > MLS engine and thus share the same field and engine logic.  MCS was an
> > > attempt to make the MLS field and engine useful for general users, and
> > > is being leveraged by sandbox and by svirt for separating multiple
> > > instances of sandboxes or guest VMs.
> > 
> > In other words: MCS and MLS are not mutally exclusiv?! Not in SELinux  
> > and not in gernal? For me, MCS in SELinux is an "extra",  which  you  
> > can use with MLS (or MLS engine) at the same time. Please correct me,  
> > if i'm wrong.
> > 
> > Imho, MCS uses "compartments" or categories to realize the need to  
> > know principle and MLS uses vertical levels to achieve (at least in  
> > SELinux) confidentiality (BLP model). Imo compartments and levels are  
> > not mutally exclusive.
> 
> MCS and MLS are SELinux models (MCS and MLS are just particular
> configurations of constraints for the MLS engine and thus share the same
> field and engine logic.)
> 
> The MCS configuration of constraints conflict with the MLS configuration
> of constraints.
> 
> In MCS the usage of assigned compartments is to the discretion of the
> user
> 
> In MLS the usage of assigned compartments is mandatory.
> 
> As far as i know MCS and MLS are mutually exclusive. 

Correct.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
