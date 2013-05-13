From: "Vu, Joseph" <joseph.vu@boeing.com>
To: David Quigley <dpquigl@davequigley.com>,
        James Bottomley
	<james.bottomley@hansenpartnership.com>
CC: Ric Wheeler <rwheeler@redhat.com>, Steve Dickson <steved@redhat.com>,
        Trond Myklebust <trond.myklebust@netapp.com>,
        "J. Bruce Fields"
	<bfields@redhat.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        "Linux NFS
 list" <linux-nfs@vger.kernel.org>,
        Linux FS devel list
	<linux-fsdevel@vger.kernel.org>,
        Linux Security List
	<linux-security-module@vger.kernel.org>,
        SELinux List
	<selinux@tycho.nsa.gov>,
        Jack Rieden <jrieden@redhat.com>
Subject: RE: [PATCH 00/17] lnfs: linux-3.9 release
Date: Mon, 13 May 2013 13:00:59 +0000
Message-ID: <756D04455A661C4CA25DC5BA4902A7A72269B0D1@XCH-PHX-204.sw.nos.boeing.com>
References: <1367515151-31015-1-git-send-email-SteveD@redhat.com>
 <51848BE0.2080901@redhat.com> <1367855617.1868.16.camel@dabdike>
 <51880B01.5040907@redhat.com> <1367871935.1868.48.camel@dabdike>
 <cb264c17aefd307cdc6e93b576f695e9@countercultured.net>
In-Reply-To: <cb264c17aefd307cdc6e93b576f695e9@countercultured.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

Thank you for your great effort in making this capability available.

Joe

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of David Quigley
Sent: Sunday, May 12, 2013 4:56 PM
To: James Bottomley
Cc: Ric Wheeler; Steve Dickson; Trond Myklebust; J. Bruce Fields; David P. Quigley; Linux NFS list; Linux FS devel list; Linux Security List; SELinux List; Jack Rieden
Subject: Re: [PATCH 00/17] lnfs: linux-3.9 release

On 05/06/2013 16:25, James Bottomley wrote:
> On Mon, 2013-05-06 at 22:56 +0300, Ric Wheeler wrote:
>> On 05/06/2013 06:53 PM, James Bottomley wrote:
>> > On Sat, 2013-05-04 at 07:17 +0300, Ric Wheeler wrote:
>> >> On 05/02/2013 08:18 PM, Steve Dickson wrote:
>> >>> From: Steve Dickson <steved@redhat.com>
>> >>>
>> >>> Here is an the next rlease of the label NFS patches ported to the 
>> >>> linux-3.9 release
>> >>>
>> >>> The following changes were made from the previous release.
>> >>> (Note, only the server patch changed in this release)
>> >>>
>> >>> * Remove the buffer overflow in the allocation of labels.
>> >>>
>> >>> * Removed needless char * casting
>> >>>
>> >>> * Removed the -EMSGSIZE to nfs4err_badlabel errno mapping
>> >>>     by changing the return value of nfsd4_label_alloc() to
>> >>>     be a _be32 value.
>> >> It would be great to see this patch series land in time for 3.10
>> - seems like a
>> >> major feature that has had been held in development for years and
>> it does have a
>> >> very interested user base waiting for this to land.
>> >>
>> >> Are there any existing roadblocks to having this make it this
>> merge
>> >> window?
>> > You mean other than the one Bruce and Trond already mentioned and
>> which
>> > you presumably already read? i.e. it's a large feature whose final 
>> > incarnation landed when the merge window was already open which by 
>> > process should receive incubation in linux-next before being
>> merged.
>> >
>> > It is entirely within the gift of the maintainers to vary the
>> incubation
>> > requirements, but if they do and it comes back with a ton of
>> problems
>> > from the 0 day project or smatch or even a build failure that
>> would have
>> > been picked up by linux-next, they'll be at the wrong end of
>> Linus'
>> > flame thrower not you.  So it is rather unfair to pressure the 
>> > maintainers like this.
>> >
>> > Kernel processes exist for a reason and almost every maintainer
>> has the
>> > scars that remind them of this.
>> >
>> > James
>> >
>> >
>>
>> Don't worry James - this one has had at least as much testing as the 
>> average SCSI driver update :)
>>
>> This is was not meant as pressure, James Morris (not you) had replied 
>> that his patches are ready and he expected them to be pulled via the 
>> NFS trees.
>
> Yes, I know this ... Trond and Bruce both said definitely 3.11 and 
> probably 3.11 respectively, that's why I was surprised to see a 3.10 
> request.
>
>> This was meant to facilitate getting this multi-tree, 
>> multi-maintainer series ready to merge and make sure we aren't stuck 
>> each waiting for a response from the next person in the loop.
>>
>> Note that this patch set has been in development for *years*, been 
>> tested at connectathon, tested by interested parties who promoted the 
>> earliest versions of the patches and tested by RHEL (of course, the 
>> series has evolved over time).
>
> That's good, but not sufficient.  A large number of "well tested" big 
> patch sets have failed integration nastily when they were merged over 
> the years.  That wasn't because they weren't actually tested, but 
> because as soon as they hit the tree, they caused side effects, or 
> people tried configurations the submitters hadn't or because they 
> tried tests the submitters hadn't thought of.  This is why we have an 
> integration process involving linux-next ... to try and find these 
> types of problems *before* merger and that's why large features tend 
> to spend at least a week in linux-next to try to find the issues.
>

To be fair I doubt you're going to see any new problems on top of what 
Bruce has already caught. He has done the work to tweak all the knobs to 
make sure config wise any LNFS features turned on or off don't break 
NFSv4 both at compile and run-time. On top of that all the security 
patches are self contained as LNFS is the only user. Finally based on 
people's knee-jerk reaction to disable SELinux on most of their systems 
I doubt you're going to get much more testing out of linux-next than 
we've already done. We already have a wink and a nod from Casey that 
SMACK has issues with Labeled NFS and that he has no objections to 
fixing that problem later. All that said its still the maintainer's 
decision to take it or not and I'd imagine backporting the patches to 
3.10 from 3.11 wouldn't be a tremendous amount of work if someone needed 
it to fall into that specific version. Personally I can't wait for the 
patches to get merged since I started this project almost 6 years ago at 
this point. Steve Dickson has picked up the torch and kept running with 
it since my time no longer permitted me to champion the patch set and I 
think its ready for use by quite a few customers.

Dave

Dave



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
