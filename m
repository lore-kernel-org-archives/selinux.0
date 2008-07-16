Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GHiChv029899
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 13:44:12 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GHiBhc011042
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 17:44:11 GMT
Date: Wed, 16 Jul 2008 19:44:10 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
Message-ID: <20080716174410.GA9226@hardeman.nu>
References: <20080716165634.GA8072@hardeman.nu> <487E2C1F.4010308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <487E2C1F.4010308@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
>David Härdeman wrote:
>> While working on SELinux-enabling a Debian system, I often Google for
>> avc messages that show up in dmesg and 90% of the time it seems that the
>> problem has already been solved in Fedora's version of the refpolicy but
>> not in the upstream version.
...
>> The question is how to treat the patches after that? Should I post them
>> as I go through them (a couple per day for a couple of weeks?) and hope
>> that someone at Tresys will apply them?
...
>> 
>My goal is to get more then just TreSys to check in patches.  Currently
>we have a bottleneck that is not likely to be fixed.  This is not
>anyone's fault, but we are not taking advantage of OpenSource and
>allowing many hands/eyes to do this work.  Changing a module to user
>auth_use_nsswitch when we realize it calls getpw*, should be easy to get
>merged, and should not have a gatekeeper to prevent it.  If multiple
>policy writers agree on the patch, it should just go in.  Now more
>complicated changes like removing user prefix need to go much more slowly.
>
>As far as my massive fix versus a 250 minor patches, is just a matter of
>someone coming up with a better way.  I don't want to have 250 different
>patches in the spec file.  Quilt has been suggested, but I am  not
>familiar with it and am not sure how it work, nor do I have time to
>implement it.

You obviously already have a script to split the big patch into smaller 
ones. Wouldn't it be ok to have the smaller patches in a directory in 
the CVS repo, do your work against the small patches and then cat all 
patches into a big one before you do a new release? It would avoid 
having to change the .spec file and you'd be able to drop minor patches 
as they are merged upstream easily (and quilt is quite nice btw).

>My current work habit is to take AVC messages from everywhere that I get
>them. Bugzilla, Mail List, Chat Rooms, email, Personal Testing ...  And
>modify my pool.

Is that pool maintained in a repo somewhere? If not, would it perhaps be 
an idea to maintain the pool as a branch in the tresys repo?

> When I am done I run a big diff against refpolicy and
> update the patch.  So referencing all of the bugzilla's would only get
>a snapshot of the fixes and would be very time consuming and dirty up
>the patches. 

"dirty" the patches...but I'm thinking one line comments which explain 
some of the changes. I wouldn't call that dirtying the patches. For 
example, in postgrey.te, the redhat patch gives postgrey_t the ability 
to restart apache...and I can't see why. A quick one-liner which 
explained the background would have been great :)

>Getting a quilt of different fixes for each day, I do not
>believe would be of much use either since they are random.  Me
>documenting each fix and sending it immediately upstream would not help,
>since this would overwhelm me and upstream.

No, but committing one fix at a time to a repo would help, even if the 
"fix documentation" (i.e. commit message) is just "let firefox read config 
file foo".

>We are bringing on another dedicated policy writer in September,   who
>could maybe help with verifying policy changes and getting them upstream.

I guess what I'm really wondering is if I can help you in some way? 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
