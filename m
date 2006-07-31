Message-ID: <44CE19AF.9040703@trustedcs.com>
Date: Mon, 31 Jul 2006 09:54:39 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 0/2] new and improved range_transition statements
References: <44CA2919.4010708@trustedcs.com>	 <1154351236.26550.14.camel@localhost.localdomain>	 <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>	 <1154354323.26550.42.camel@localhost.localdomain> <1154356249.1447.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154356249.1447.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-07-31 at 09:58 -0400, Karl MacMillan wrote:
> 
>>On Mon, 2006-07-31 at 09:56 -0400, Stephen Smalley wrote:
>>
>>>On Mon, 2006-07-31 at 09:07 -0400, Karl MacMillan wrote:
>>>
>>>>My biggest question is how to handle the format change. There are some
>>>>other bug fixes awaiting a module format change (not certain about
>>>>kernel format change) and it would be nice to include those in this
>>>>format bump. Unfortunately there are not patches for those fixes at the
>>>>moment.
>>>>
>>>>Could we branch the code for a month or so for the other changes can be
>>>>introduced or is the fix more critical? Do you think that this must go
>>>>into RHEL 5 / FC6? Is it possible for the kernel changes to make it in
>>>>time for 2.6.18 and if they don't will this be included in RHEL 5 / FC6?
>>>
>>>It doesn't necessarily have to be in 2.6.18 to make RHEL5; consider the
>>>MLSXFRM and NetLabel patches, which are being queued for 2.6.19 but IIUC
>>>will be back ported and included in RHEL5.
>>>
>>
>>I know. I'm trying to get a feel for whether this change is critical or
>>the workarounds mentioned in the bug are sufficient for now. If it is
>>not critical I'd rather batch some other format changes. Otherwise the
>>change should go in and potentially be backported if it misses 2.6.18.
> 
> 
> I'd view this change as more important to RHEL5 than any of the other
> proposed format changes, so I'd like to see both the kernel change and
> the userland change make it into RHEL5.

As an aside to the primary bugfix that this patch addresses...

As I mentioned, I was striving to make to new formats be ready to handle
range_transitions in policy modules.  I think that this will be a necessity
for MLS application developers that with to use RHEL5.  The current alternative
seems to be (assuming the need to use new range_transitions statements, which
we currently do...) replacing the RHEL policy package altogether with
something that includes source to build either a new base policy or a
monolithic policy that provides the necessary transitions.

I was hoping that by solidifying the formats now (and getting those accepted
into RHEL5 early), we could continue to work on on code fixes/enhancements
to allow the statements in policy modules and hope to get that work into
RHEL since it would not require further format changes.  I am hoping that the
format can handle that now...  There are still thing that will need to be
addressed (such as how to handle MLS requirements for modules) to achieve
the goal.  I'm willing to lend a hand on the further work, but I'm sure I
will need some serious hand-holding when I dig into the link phase ;)  Thanks
again to Joshua for the help he has provided me to get the patches to where
they are right now.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
