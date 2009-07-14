MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Install SELinux policies from rpm package header
Date: Tue, 14 Jul 2009 10:36:44 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E012CDB7F@exchange2.columbia.tresys.com>
In-Reply-To: <4A5C7809.3020205@redhat.com>
References: <C680D5CD.A8AD7%csellers@tresys.com> <9DB3FF14-CCB5-445C-BE63-1EBE84125E6A@nall.com> <4A5B7180.8080909@manicmethod.com> <789CDC33-514C-4816-AF43-BBD629075BA5@nall.com> <06A6610D4F464D4EBEAFBF2C5F86911E012CDA82@exchange2.columbia.tresys.com> <4A5C7809.3020205@redhat.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Joe Nall" <joe@nall.com>, "Joshua Brindle" <method@manicmethod.com>,
        "Chad Sellers" <csellers@tresys.com>, <jwcart2@tycho.nsa.gov>,
        "Paul Howarth" <paul@city-fan.org>, "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Lawrence" <slawrence@tresys.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> 
> On 07/13/2009 02:52 PM, Joshua Brindle wrote:
> >> From: Joe Nall [mailto:joe@nall.com]
> >>
> >> On Jul 13, 2009, at 12:40 PM, Joshua Brindle wrote:
> >>
> >>> Joe Nall wrote:
> >>>> On Jul 13, 2009, at 11:15 AM, Chad Sellers wrote:
> >>>>
> >>>>> On 7/10/09 4:26 PM, "Joshua 
> Brindle"<jbrindle@tresys.com>  wrote:
> >>>>>
> >>>>>>> From: James Carter [mailto:jwcart2@tycho.nsa.gov]
> >>>>>>>
> >>>>>>>> Its alot worse than that. What about files on backup
> >>>>>>> drives? Offline drives?
> >>>>>>>> transient files that will get relabeled to something 
> >>>>>>>> inappropriate?
> >>>>>>>> I'm not confortable relabeling databases with potentially 
> >>>>>>>> sensitive data to var_lib_t because mysql was uninstalled.
> >>>>>>>>
> >>>>>>> The argument seems to be for removing the ability to remove 
> >>>>>>> modules.
> >>>>>>> It would be the roach motel style of policy management.
> >>>>>>>
> >>>>>> I like it, policies check in but don't check out. I
> >> haven't heard
> >>>>>> an argument about 1) how I'm crazy and wrong or 2) how to keep 
> >>>>>> systems running as expected otherwise though.
> >>>>> There's certainly a case for leaving all policy
> >> installed. Policy is
> >>>>> configuration data, which RPM also leaves installed 
> when removing 
> >>>>> packages.
> >>>>> We could easily treat policy the same.
> >>>> Our app has 140 rpms that install policy. They install in
> >> the %post
> >>>> and do a restorecon of the relevant installed files and 
> >>>> /etc/selinux/mls/modules. Daemons are stopped in the
> >> %preun. Policy
> >>>> is removed in the %postun and more restorecon occurs. 
> The biggest 
> >>>> annoyance with this approach is the 140 individual
> >> transactions are
> >>>> ssllooww.
> >>>>
> >>> Yes, if you want to test out the patch sent to the rpm list
> >> and report
> >>> results with lots of policy packages that would be awesome :)
> >>>
> >>>> I would really like to see policy batched up and installed
> >> early in
> >>>> the transaction. I think blindly leaving the policy behind on 
> >>>> uninstall is configuration management insanity. When an rpm is 
> >>>> removed, all of the unmodified installation should be 
> removed with 
> >>>> it. Files should be relabeled to match the post
> >> installation policy.
> >>>> That way a subsequent install behaves the way you would
> >> intuitively
> >>>> expect.
> >>>>
> >>> I see the claim but I don't see the argument. A 
> subsequent install 
> >>> will either replace the old module or do nothing (if its
> >> the same) and
> >>> all the old files will already be labeled properly, in 
> fact this is 
> >>> the main reason I want to leave old policies around. Note
> >> that users
> >>> will always be able to remove policies themselves, I just
> >> don't think
> >>> we can make rpm smart enough to know the users intentions
> >> (perhaps if
> >>> it was written in python we could just import psychic :) )
> >> We are going to have to disagree on what is proper. Based on our 
> >> experience with multiple policies, I think you are going 
> to get into 
> >> trouble with policy upgrades when type declarations move 
> or multiple 
> >> rpms declare the same type in policy. You have to think about how 
> >> policies and rpms evolve over time.
> >>
> >
> > So renames are a different issue that we are thinking 
> about. Eg., if a 
> > module claims to replace a module meaning it provides the same 
> > type-space and behavior then we need some facility for 
> telling rpm so 
> > it can remove the old and add the new during the same transaction, 
> > this is already a work in progress.
> >
> > Removing a policy entirely is what the above thread was 
> about, and I 
> > still maintain that automated removal of policies is a bad idea, 
> > violates the principle of least surprise and has the potential of 
> > leaking sensitive data or leaving the system inconsisten or 
> > non-functional.
> One Idea I had was to have two policies.  One for install and 
> one for uninstall, the uninstall policy takes all of the 
> types defined in the install and typealias them to some base name.
> 
> httpd_exec_t == bin_t
> httpd_var_run_t == var_run_t
> 

Yes, that is an option. Karl talked about using the type hierarchy to
gracefully degrade types automatically in the past, I doubt this is
practical though since the type hierarchy used for security dominance is
unlikely to also represent some functional degradation of types. Further
I suspect that bin_t, for example, isn't currently a superset of all
exec types.

This is sort of like my uninstall template idea except that I was
thinking the types would stick around and allow rules that allowed
admins and backup programs to continue the access would be put in place.
If someone was willing to do uninstall sections of all the policies I
suppose this idea could work. This may be worth considering for the new
intermediate language work.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
