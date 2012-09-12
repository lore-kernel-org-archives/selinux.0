MIME-Version: 1.0
In-Reply-To: <CALrft9_VWLjYZ2+iqBArf9JoUxOimK+A-ZCMaAPp5MEo0sot4Q@mail.gmail.com>
References: <CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	<1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
	<CALrft98Np4v5Lyhzy+_NEJkf9aqkC60PzMT4fFoYcPgohzyJqQ@mail.gmail.com>
	<1347373683.17403.36.camel@moss-pluto.epoch.ncsc.mil>
	<5834517F-2F20-4A03-9178-E27ADAA73AD8@me.com>
	<CALrft9_VWLjYZ2+iqBArf9JoUxOimK+A-ZCMaAPp5MEo0sot4Q@mail.gmail.com>
Date: Wed, 12 Sep 2012 14:49:20 +0300
Message-ID: <CALrft998bGyRArMoj+1K0tvpECjUKoBrFsotC_=ivifbPZx5DA@mail.gmail.com>
Subject: Re: Security hooks for rpm
From: Elena Reshetova <elena.reshetova@gmail.com>
To: pmatilai@redhat.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Steve Lawrence <slawrence@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>, Jeffrey Johnson <n3npq@me.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Panu,

If you remember we have been discussing a while ago about the
possibility to define a unified set of security hooks for rpm that we
can use for our MSM implementation and others can use, too. We have
finished the discussion around smth that I would need to reach an
agreement with SELinux team (in CC now) that they can use this set of
hooks, too.

We had discussions at LinuxCon just recently and I think we all want
to have a unified interface. I think we can settle the hooks arguments
and position inside the code, but there is a bigger question that
would be great to hear your opinion on.

Currently (this is my understanding, so please correct me if I am
terribly wrong) rpm has only one plugin interface that is defined as
"collection plugins". It isn't very generic enough to be called the
"rpm plugin interface". Do you have any plans/roadmap to have smth
like generic rpm plugin interface in the future? And how should the
security interface be embedded into rpm? Should we define a notion of
"security plugin", its set of hooks and be able to load a number of
these plugins (if a number of security modules is active on the
system). Or should we rather try to define a generic plugin interface
that can in the beginning have the hooks related to security,  but
further be extended with other non-security related hooks?

Best Regards,
Elena.



On Wed, Sep 12, 2012 at 2:36 PM, Elena Reshetova
<elena.reshetova@gmail.com> wrote:
> On Tue, Sep 11, 2012 at 6:05 PM, Jeffrey Johnson <n3npq@me.com> wrote:
>> While your POV is perfectly sane and general, the reality is
>> that there are no other RPM modules, nor has there been any
>> attempt to use the existing SELinux module framework except
>> for MSSF.
>
> True, but I guess everything has its beginning. So, if we are the second user
> of this interface, we can make it work well for any other potential users.
> Mimi was considering using some hooks in rpm for bootstrapping the
> IMA/EVM signatures, so she might be a third user. And after that others
> might also follow.
>
>>> If not, I don't see why it cannot be made to support that functionality.
>>> It isn't truly unique to security; other kinds of functional plugins may
>>> need/want to be able to abort the installation.
>>>
>>
>> The existing module framework is too narrowly focussed on SE Linux
>> (and MSSF) needs to be generally useful for "package management".
>>
> Yes, I think we need a generic interface for rpm plugins that can be used
> for security or package management reasons. However, I don't think we
> can attempt to define all needed hooks for all generic purposes now, but
> regarding security together we might have quite close hit.
>
>> Passing a dirname/basename pair instead of a full file path is a flawed API imho. ymmv.
> I can change it to pass fsm->path. Having these two separated might be useful
> for some reasons, but it indeed looks better with just one argument that
> contains both.
>
>> While using a "void *" pointer makes sense for opaque layering design, a
>> shared data structure alleviates the need to reinvent the wheel in modules.
>>
>> E.g. all versions of RPM already make significant use of crypto libraries.
>> Linking modules opaquely to to the same/different crypto libraries forces
>> needless bloat and duplication for the sole purpose of a opaque layering
>> design.
>
> Sure, but I don't think I was proposing that. I was just trying to
> make sure the internal,
> specific only to concrete LSM data, is out of rpm itself. Smack rpm
> plug-in isn't
> going to make much use of selinux label handles and vice versa.
>
>> The design issues of a generally useful module framework for RPM need more
>> than a wrapper (with security labeling side-effects) to mkdir(2).
>
> What kind of functionality do you have in mind for this wrapper apart
> from labeling?
>
>> More thought and a higher level abstraction than wrapped system calls needs to be
>> considered for a useful module framework for RPM.
>
> Yes, and this is I think where the problem might be. If we say that
> our goal is to design
> a generic module framework for RPM (not only for security purpose),
> then I am afraid
> this can take ages and it is quite a big step. I personally don't have
> any good understanding
> of needs for rpm modules outside of security ones.
>
> Let me try to include rpm maintainer into this discussion and see what
> he thinks about this.
>
> Best Regards,
> Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
