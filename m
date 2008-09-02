Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BCC591.3000101@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB93D2.8090909@redhat.com> <48BCB564.4010404@redhat.com>
	 <48BCC591.3000101@redhat.com>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 09:19:19 -0400
Message-Id: <1220361559.26711.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-09-02 at 14:48 +1000, Murray McAllister wrote:
> Murray McAllister wrote:
> > Murray McAllister wrote:
> > 
> >>>> type: The type is an attribute of Type Enforcement. The type defines 
> >>>> a domain type for subjects, and a type for objects. SELinux policy 
> >>>> rules define how types access each other, whether it be a domain 
> >>>> accessing a type, or a domain accessing another domain. Access is 
> >>>> only allowed if a specific rule exists that allows it.
> >>>>
> >>>> category: The category is an attribute of Multi-Level Security (MLS) 
> >>>> and Multi-Category Security (MCS). Categories are used to categorize 
> >>>> data, and identify its sensitivity or security level. Standard 
> >>>> SELinux policy supports MCS; however, it is not heavily used. MCS 
> >>>> allows users, at their own discretion, to add a category to a piece 
> >>>> of data, for example, PatientRecord or CompanyConfidential. There is 
> >>>> only a single security level, s0. MLS labels data with both 
> >>>> categories (CompanyConfidential) and a sensitivity level. MLS 
> >>>> enforces the Bell-LaPadula Mandatory Access Model, and is used in 
> >>>> Labeled Security Protection Profile (LSPP) environments.
> >>>
> >>> Again, this should be level or range rather than just category, where a
> >>> level is a sensitivity and an optional list of categories and a range is
> >>> a current/low level and a clearance/high level.  You may wish to note
> >>> that people who wish to use the MLS restrictions need to install a
> >>> separate -mls policy package and make it the default.
> >>
> > 
> > How about:
> > 
> > The security level is an attribute of MLS and Multi-Category Security 
> > (MCS). The first part of the security level is the sensitivity, for 
> > example, s0 is a sensitivity. The s0 sensitivity is the only sensitivity 
> > used when running the SELinux targeted policy. Optionally, the security 
> > level can have a list of categories. Categories are used to categorize 
> > data and add an extra level of security. If a user does not have access 
> > to the same or higher categories than an object, and DAC and SELinux 
> > rules allow access, access to that object is denied. 
> 
> I keep getting MLS and MCS mixed up. Should this be "If a user does not 
> have access to same categories as the object is labeled with"?

For MCS, as I recall, the subject's high level/clearance must dominate
the object's level in order to read or write to it.  Thus, it must be
authorized for all categories in the object's level.

For MLS, the subject's low level must dominate the object's level in
order to read from it (read down), and the subject's low level must
equal the object's level in order to write to it (write equal).
Technically, the latter restriction can be relaxed to allow a subject to
write up, but in the current mls policy this requires a particular type
attribute.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
