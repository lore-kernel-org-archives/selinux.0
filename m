Message-ID: <1347630545.12789.5.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: Security hooks for rpm
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Elena Reshetova <elena.reshetova@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Steve
 Lawrence <slawrence@tresys.com>
Date: Fri, 14 Sep 2012 09:49:05 -0400
In-Reply-To: <CALrft9_fR4QPDeH-yT+R7Po9Ufo5D0DvgD0vDwV9msemmEHa=Q@mail.gmail.com>
References: 
	<CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	 <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
	 <1347564198.28276.14.camel@moss-lions.epoch.ncsc.mil>
	 <CALrft9_fR4QPDeH-yT+R7Po9Ufo5D0DvgD0vDwV9msemmEHa=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 14:39 +0300, Elena Reshetova wrote:
> On Thu, Sep 13, 2012 at 10:23 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> > On Mon, 2012-09-10 at 10:44 -0400, Stephen Smalley wrote:
> >> On Mon, 2012-09-10 at 11:07 +0300, Elena Reshetova wrote:
> >> > And here are the actual hooks:
> >> >
> >> > 1. rpmRC SECURITYHOOK_INIT_FUNC(rpmts ts, const char *opts)
> >>
> >> I see that our init func takes a const char *name argument as well; I
> >> don't know offhand whether it is truly required (Steve or Jim?).
> >>
> >
> > This is the name of the collection. It is required so that all the
> > members of a collection can be grouped together. This is needed because
> > all SELinux policy must be installed before applications and files that
> > the policy is for.
> 
> I wonder if we can then have a generic init hook for the plugin (as
> above) and then
> a separate hook to initialize the collection (that could have
> collection name and
> any other needed variables). The plugins that need to use collection
> (like SELinux)
> will use this hook, others just ignore it. Would it be reasonable?
> 

I think so.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
