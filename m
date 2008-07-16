Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GJTirD018747
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:29:44 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GJTghc010606
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 19:29:43 GMT
Date: Wed, 16 Jul 2008 21:29:42 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
Message-ID: <20080716192942.GA11166@hardeman.nu>
References: <20080716165634.GA8072@hardeman.nu> <487E2C1F.4010308@redhat.com> <20080716174410.GA9226@hardeman.nu> <1216232357.21191.76.camel@gorn> <487E451C.5000603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <487E451C.5000603@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 02:59:40PM -0400, Daniel J Walsh wrote:
>Christopher J. PeBenito wrote:
>> On Wed, 2008-07-16 at 19:44 +0200, David Härdeman wrote:
>>> On Wed, Jul 16, 2008 at 01:13:03PM -0400, Daniel J Walsh wrote:
>>>> David Härdeman wrote:
>>>>> While working on SELinux-enabling a Debian system, I often Google for
>>>>> avc messages that show up in dmesg and 90% of the time it seems that the
>>>>> problem has already been solved in Fedora's version of the refpolicy but
>>>>> not in the upstream version.
>>> ...
>>>>> The question is how to treat the patches after that? Should I post them
>>>>> as I go through them (a couple per day for a couple of weeks?) and hope
>>>>> that someone at Tresys will apply them?
>> [...]
>>> I guess what I'm really wondering is if I can help you in some way? 
>> 
>> The main points which would improve upstreaming efficiency from Dan's
>> set are:
>> 
>> 1. description / justification
...
>> 2. style
...
>> 3. patch composition
...

Basically all three requirements are the same as the general rules that 
apply for patch submissions to the linux-kernel mailing list (or to any 
well-behaved OSS project).

>And the problem I have with all of these is volume of change.  When a
>new release goes out and a whole bunch of new users start using SELinux
>the volume of bugzillas generated is use.  My first responsibility is to
>get SELinux fixed for these users. 

I can't imagine that a one-line commit comment would be an overwhelming 
burden when committing a couple of lines of policy changes? Heck, most 
maintainers should welcome it as it serves as a support for their own 
memory as well...I mean, most of these issues aren't exactly new for 
FOSS projects and SCM repos is the best answer people have come up with 
so far...

>Marking up the policy with lots of
>bugzilla's or justifications is both time consuming and I believe just
>dirties the policy.

Comments about patches are generally carried as commit messages and not 
inline. I don't see how it would dirty any policy. And in-line comments 
for unconventional changes I'd see not as "dirty" but as a great help to 
the person reading through the policy (I've already had a few "huh?" 
moments when reading through the RedHat patch, and that's not because 
they are bad in any way, its because its inevitable without the proper 
context).

>In the more bizarre categories that should be
>required.  My goal is to get the non-bizarre changes upstreamed so we
>could concentrate on the bizarre ones and either justify or remove them.

The question is if it's even possible to hunt down the original 
explanation for the bizarre ones after a few hundred of them have 
accumulated and they have been obscured by the passing of time?

>Changes like adding fs_list_inotify should just get into the upstream.

I realize I'm stepping into a debate which is somewhat over my head 
here, but couldn't Tresys arrange so that you get direct commit access, 
then you could commit trivial patches directly and send more 
unconventional ones to the list for discussion?

Or alternatively...perhaps a shadow branch could be setup where the 
commit rules would be more lax and then the changes could be synced over 
at intervals...

(Or even better, everything could be done via git...but that's a 
pipedream at this stage) :)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
